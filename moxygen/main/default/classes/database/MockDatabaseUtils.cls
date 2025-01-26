/*
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

/**
 * @description : utilities for a MockDatabase, contains methods that DO NOT mutate the database
 *              : a method in here must be dependent on the database, but not necessary to understand
 *              : the database
 */
@SuppressWarnings(
    'PMD.CognitiveComplexity, PMD.StdCyclomaticComplexity, PMD.CyclomaticComplexity'
)
public inherited sharing class MockDatabaseUtils {
    /**
     * @description : get the sObject from the database
     * @param recordId : the record id
     * @return : the sObject
     */
    public SObject findRecord(Id recordId) {
        try {
            return DataStore.getById(recordId);
        } catch (Exception e) {
            throw new QueryException('No record found for ' + recordId);
        }
    }

    /**
     * @description Return a parent sObject from a field name and a child sObject
     * @param sObj The child SObject
     * @param fieldName the field name of the parent sObject from the child
     *                  ex. OpportunityLineItem, the field is Opportunity
     * @return The parent sObject
     */
    public ParentRecordData findParentRecord(SObject sObj, String fieldName) {
        String sObjApiName = sObj.getSObjectType().getDescribe().getName();
        SObjectType t = SchemaService.getSObjectType(sObjApiName);

        List<Schema.SObjectField> fields = SchemaService.getFields(t);
        for (SObjectField field : t.getDescribe().fields.getMap().values()) {
            Schema.DescribeFieldResult dfr = field.getDescribe();
            Schema.DisplayType dfrFieldType = dfr.getType();
            String dfrRelationshipName = dfr.getRelationshipName();
            String lowercaseDfrRelationshipName = null;
            if (dfrRelationshipName != null) {
                lowercaseDfrRelationshipName = dfrRelationshipName.toLowerCase();
            }

            if (
                dfrFieldType == Schema.DisplayType.REFERENCE &&
                lowerCaseDfrRelationshipName == fieldName
            ) {
                return buildParentRecordData(field, sObj);
            }
        }

        throw new QueryException('Invalid relationship name: ' + fieldName);
    }

    private ParentRecordData buildParentRecordData(
        SObjectField field,
        SObject childRecord
    ) {
        DescribeFieldResult dfr = field.getDescribe();
        String fieldName = dfr.getName();
        List<Schema.sObjectType> objTypeList = dfr.getReferenceTo();

        String parentObjApiName;
        Boolean isPolymorphic = false;
        if (objTypeList.size() == 1) {
            parentObjApiName = SchemaService.getSObjectName(objTypeList[0]);
        } else {
            String parentFieldApiName = SchemaService.getFieldName(field);
            Id parentRecordId = (Id) childRecord.get(parentFieldApiName);
            parentObjApiName = SchemaService.getSObjectName(parentRecordId);
            isPolymorphic = true;
        }

        if (parentObjApiName == null) {
            throw new QueryException('Invalid relationship name: ' + fieldName);
        }
        String fieldRelationshipName = dfr.getRelationshipName();

        sObject parentRecord = ((sObject) Type.forName(parentObjApiName)
                .newInstance())
            .getSObjectType()
            .newSObject();

        SObjectType sot = SchemaService.getSObjectType(childRecord);
        Map<Id, sObject> mockRecordsChild = DataStore.getAllBySot(sot);
        Id parentId = (Id) mockRecordsChild.get(childRecord.Id).get(fieldName);

        parentRecord.put('Id', parentId);
        return new ParentRecordData.Builder()
            .setFieldApiName(fieldName)
            .setFieldRelationshipName(fieldRelationshipName)
            .setParentObjApiName(parentObjApiName)
            .setObjApiName(SchemaService.getSObjectName(childRecord))
            .setParentRecord(parentRecord)
            .setIsPolymorphic(isPolymorphic)
            .build();
    }

    /**
     * @description Get the value of an aggregate node
     * @param aggrNode
     * @param selectNode
     * @return  `Map<String, Object>`
     * @exception
     */
    public Map<String, Object> getAggrNodeValue(
        Node aggrNode,
        Node selectNode
    ) {
        if (aggrNode.nodeType == NodeType.FIELD) {
            Map<String, Object> aggrNodeValue = new Map<String, Object>{
                'field' => aggrNode.id
            };

            if (aggrNode.right == null) {
                Map<String, Object> comparables = ComparableService.getComparableDataFromNodes(
                    aggrNode,
                    selectNode
                );
                String comparableField = (String) comparables.get(
                    'comparableField'
                );
                aggrNodeValue.put('alias', comparableField);
            } else {
                String alias = aggrNode.right.id;
                aggrNodeValue.put('alias', alias);
            }
            return aggrNodeValue;
        }

        Integer exprNumber = 0;
        String alias = 'expr' + exprNumber;

        Node curr = selectNode;
        while (curr != null) {
            if (curr.nodeType != NodeType.AGGREGATE_FUNCTION) {
                curr = curr.left;
                continue;
            }

            if (curr.id != aggrNode.id) {
                exprNumber++;
                curr = curr.left;
                continue;
            }

            Node foundFieldNode = curr.right;
            Node aliasNode = foundFieldNode.left;

            if (aliasNode == null) {
                exprNumber++;
                curr = curr.left;
                continue;
            }

            alias = aliasNode.id;
            break;
        }

        Node fieldNode = aggrNode.right;
        return new Map<String, Object>{
            'field' => fieldNode.id,
            'alias' => alias
        };
    }

    /**
     * @description Get the value of a field node
     * @param valueNode
     * @param sObj
     * @param params
     * @return  `Object`
     * @exception QueryException
     */
    @SuppressWarnings(
        'PMD.StdCyclomaticComplexity, PMD.CognitiveComplexity, PMD.NcssMethodCount'
    )
    public Object getFieldNodeValue(
        Node valueNode,
        sObject sObj,
        Map<String, Object> params
    ) {
        Boolean isBindVar = (valueNode.nodeType == 'bind variable');
        Boolean isParamsNull = (params == null);
        Boolean isValueInParams = (!isParamsNull &&
        params.containsKey(valueNode.id));

        if (isBindVar && isParamsNull || isBindVar && !isValueInParams) {
            throw new QueryException('Missing bind variable: ' + valueNode.id);
        }

        if (isBindVar) {
            return params.get(valueNode.id);
        }

        if (valueNode.nodeType == 'value list') {
            List<Object> values = new List<Object>();
            Node valueListNode = valueNode.left;
            while (valueListNode != null) {
                values.add(getFieldNodeValue(valueListNode, sObj, params));
                valueListNode = valueListNode.left;
            }
            return values;
        }

        if (valueNode.nodeType == 'null') {
            return null;
        }

        if (valueNode.nodeType == 'subquery') {
            Node subquerySelectNode = valueNode.right;
            Node subqueryFieldNode = subquerySelectNode.left;
            Integer fieldsList = 0;

            Node curr = subqueryFieldNode;
            while (curr != null) {
                fieldsList++;
                curr = curr.left;
            }
            if (fieldsList > 1) {
                throw new QueryException('Subquery must select only one field');
            }

            Node subqueryFromNode = subquerySelectNode.right;
            Node subqueryObjNode = subqueryFromNode.left;

            String fieldName = subqueryFieldNode.id;
            String objName = subqueryObjNode.id;

            String objApiName = SchemaService.getSObjectName(objName);
            sObject childObj = SchemaService.blankSObjectFrom(objApiName);
            if (childObj == null) {
                throw new QueryException('Invalid object name: ' + objName);
            }
            String fieldApiName = null;
            Schema.SObjectType childObjSot = SchemaService.getSObjectType(
                childObj
            );
            List<Schema.SObjectField> childObjFields = SchemaService.getFields(
                childObjSot
            );
            for (Schema.SObjectField field : childObjFields) {
                fieldApiName = SchemaService.getFieldName(field);
                if (fieldApiName == fieldName) {
                    fieldApiName = fieldApiName;
                    break;
                }
            }
            if (fieldApiName == null) {
                throw new QueryException('Invalid field name: ' + fieldName);
            }

            Schema.SObjectField childObjField = SchemaService.getField(
                childObjSot,
                fieldApiName
            );
            if (childObjField == null) {
                throw new QueryException('Invalid field name: ' + fieldName);
            }

            Schema.DisplayType childObjFieldType = SchemaService.getFieldType(
                childObjField
            );

            if (
                childObjFieldType != Schema.DisplayType.REFERENCE &&
                childObjFieldType != Schema.DisplayType.ID
            ) {
                throw new QueryException('Subquery must select an ID field');
            }
            String parentFieldApiName = SchemaService.getFieldName(
                childObj,
                fieldName
            );
            Schema.SObjectField parentField = SchemaService.getField(
                childObj,
                parentFieldApiName
            );

            Boolean isSameType = SchemaService.idsReferenceSameSObject(
                parentField,
                childObjField
            );

            if (!isSameType) {
                throw new QueryException(
                    'Subquery must select a field of the same type as the parent object'
                );
            }

            List<SObject> subQueryObjects = (List<SObject>) MockDatabase.doSelectQueryInternal(
                subquerySelectNode,
                params
            );
            List<Id> subQueryIds = new List<Id>();
            for (sObject subQueryObj : subQueryObjects) {
                subQueryIds.add((Id) subQueryObj.get(fieldApiName));
            }
            return subQueryIds;
        }

        return valueNode.Id;
    }

    /**
     * @description : check if the required fields are set on a record
     * @param record : the record
     * @return : first required field that is not set
     */
    public String getUnfulfilledField(SObject record) {
        Schema.SObjectType sot = SchemaService.getSObjectType(record);
        for (Schema.SObjectField field : SchemaService.getFields(sot)) {
            if (SchemaService.isRequiredField(field)) {
                if (record.get(field) == null) {
                    return SchemaService.getFieldName(field);
                }
            }
        }
        return null;
    }

    /**
     * @description Check if the required fields are set on a record
     * @param record
     * @exception DMLException
     */
    public void checkForRequiredFieldsOnInsert(SObject record) {
        String unfulfilledField = getUnfulfilledField(record);
        if (unfulfilledField != null) {
            throw new DMLException(
                'Required field not set: ' + unfulfilledField
            );
        }
    }

    /**
     * @description Check if the required fields are set on a record
     * @param record
     * @exception DMLException
     */
    public void checkForRequiredFieldsOnUpdate(SObject record) {
        Map<String, Object> newRecordMap = Common.mapFromRecord(record);
        for (String fieldName : newRecordMap.keySet()) {
            Schema.SObjectField field = SchemaService.getField(
                record,
                fieldName
            );
            if (
                SchemaService.isRequiredField(field) &&
                newRecordMap.get(fieldName) == null
            ) {
                throw new DmlException('Field ' + fieldName + ' is required');
            }
        }
    }

    /**
     * @description Returns an empty response based on the top level nodes
     * @param topLevelNodes
     * @return  `Object`
     */
    public Object emptyResponse(TopLevelNodes topLevelNodes) {
        Boolean isAggregateQuery = NodeService.isAggregateQuery(topLevelNodes);
        Boolean isCount = NodeService.isSingularCount(topLevelNodes);
        if (isAggregateQuery) {
            return new List<Aggregate>();
        } else if (isCount) {
            return 0;
        } else {
            return new List<SObject>();
        }
    }
}
