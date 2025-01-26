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
 * @description This class provides the ability to compare fields on SObjects with the mock database
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class ComparableService {
    /**
     * @description : given an sObject and a field name (which may be a relationon i.e. Account.Name),
     *              : return a map with the comparable sObject (i.e. the parent), the field api name of that object,
     *              : and the relationship name
     * @param record : the sObject
     * @param fieldLookupChain : the field name
     * @return : a map with the comparable sObject, the field api name, and the relationship name, and whether the field is polymorphic
     * @throws QueryException : if the field name is invalid
     */
    @SuppressWarnings('PMD.NcssMethodCount')
    public static ComparableRecordData getComparables(
        SObject record,
        String fieldLookupChain
    ) {
        QueriedFieldResolver resolver = new QueriedFieldResolver.Builder()
            .setFieldLookupChain(fieldLookupChain)
            .setComparableRecord(record)
            .build();

        return resolver.resolve();
    }

    @TestVisible
    private static Boolean isParentRecordLookup(String fieldLookupChain) {
        return fieldLookupChain.contains('.');
    }

    /**
     * @description Get the comparable field name from a field name and a comparable sObject
     * @param comparableRecord `SObject`
     * @param finalField `String`
     * @param isPolymorphic `Boolean`
     * @return  `String`
     */
    public static String getComparableField(
        SObject comparableRecord,
        String finalField,
        Boolean isPolymorphic
    ) {
        String comparableField;
        if (isPolymorphic) {
            Map<String, String> polymorphicFieldMap = SchemaService.getPolymorphicFieldMap();
            Boolean isPolyField = (polymorphicFieldMap.containsKey(
                finalField.toLowerCase()
            ));
            if (isPolyField) {
                comparableField = polymorphicFieldMap.get(
                    finalField.toLowerCase()
                );
            } else {
                Schema.SObjectType comparableSot = SchemaService.getSObjectType(
                    comparableRecord
                );
                comparableField = SchemaService.getFieldName(
                    comparableSot,
                    finalField
                );
            }
        } else {
            Schema.SObjectType comparableSot = SchemaService.getSObjectType(
                comparableRecord
            );
            comparableField = SchemaService.getFieldName(
                comparableSot,
                finalField
            );
        }
        return comparableField;
    }

    /**
     * @description : getComparables, except we don't return the comparable sObject, we return a blank sObject of that type
     * @param obj : the sObject
     * @param field : the field name
     * @return : a map with the comparable sObject, the field api name, and the relationship name
     * @throws QueryException : if the field name is invalid
     */
    public static Map<String, Object> getComparableData(
        sObject obj,
        String field
    ) {
        sObject comparableRecord = obj;
        String comparableField = field;
        if (!isParentRecordLookup(comparableField)) {
            Schema.SObjectType comparableSot = SchemaService.getSObjectType(
                comparableRecord
            );
            comparableField = SchemaService.getFieldName(
                comparableSot,
                comparableField
            );
            return new Map<String, Object>{
                'comparableRecord' => comparableRecord,
                'comparableField' => comparableField,
                'relationshipName' => comparableField
            };
        }

        List<String> fieldParts = comparableField.split('\\.');
        String finalField = fieldParts[fieldParts.size() - 1];
        fieldParts.remove(fieldParts.size() - 1);
        String parentField = fieldParts[0];
        sObject parentRecord;
        String relationshipName = '';
        while (!fieldParts.isEmpty()) {
            Map<String, Object> parentInfo = ComparableService.getParentObjectData(
                obj,
                parentField
            );

            parentRecord = (sObject) parentInfo.get('parentRecord');
            relationshipName +=
                (String) parentInfo.get('fieldRelationshipName') + '.';

            fieldParts.remove(0);
            if (!fieldParts.isEmpty()) {
                parentField = fieldParts[0];
            }
        }
        comparableRecord = parentRecord;
        Schema.SObjectType comparableSot = SchemaService.getSObjectType(
            comparableRecord
        );
        comparableField = SchemaService.getFieldName(comparableSot, finalField);
        relationshipName += comparableField;

        return new Map<String, Object>{
            'comparableRecord' => comparableRecord,
            'comparableField' => comparableField,
            'relationshipName' => relationshipName
        };
    }

    /**
     * @description : given a field node and a select node, return a map with the comparable sObject data,
     *                the field api name, and the relationship name, builds on getComparables
     * @param fieldNode : the field node
     * @param selectNode : the select node
     * @return : a map with the comparable sObject, the field api name, and the relationship name
     * @throws QueryException : if the field name is invalid
     * @see getComparables
     */
    public static Map<String, Object> getComparableDataFromNodes(
        Node fieldNode,
        Node selectNode
    ) {
        String fieldName = fieldNode.id;
        Node fromNode = selectNode.right;
        Node objNode = fromNode.left;
        String objName = objNode.id;

        String objApiName = SchemaService.getSObjectName(objName);
        Type t = type.forName(objApiName);
        if (t == null) {
            throw new QueryException('Invalid object name: ' + objName);
        }
        sObject sObj = (sObject) t.newInstance();
        return getComparableData(sObj, fieldName);
    }

    /** @description : return a parent sObject from a field name and a child sObject
     * @param sObj : the child sObject
     * @param fieldName : the field name of the parent sObject from the child
     *                  : ex. OpportunityLineItem, the field is Opportunity
     * @return : a map with the parent sObject, the field api name, and the relationship name
     */
    public static Map<String, Object> getParentObjectData(
        SObject sObj,
        String fieldName
    ) {
        // api name of the child sObject
        String objApiName = sObj.getSObjectType().getDescribe().getName();
        // api name of the id object on the child (i.e. OpportunityId)
        String fieldApiName;
        // api name of the relationship field on the child (i.e. Opportunity)
        String fieldRelationshipName;
        // api name of the parent sObject
        String parentObjApiName;
        // whether this field is a polymorphic relationship
        Boolean isPolymorphic = false;

        Schema.SObjectType sot = SchemaService.getSObjectType(sObj);
        List<Schema.SObjectField> fields = SchemaService.getFields(sot);
        for (Schema.SObjectField field : fields) {
            Schema.DisplayType fieldType = SchemaService.getFieldType(field);
            String relationshipName = SchemaService.getFieldRelationshipName(
                field
            );

            if (
                fieldType == DisplayType.Reference &&
                relationshipName.toLowerCase() == fieldName
            ) {
                List<Schema.sObjectType> objTypeList = SchemaService.getReferenceTo(
                    field
                );

                if (objTypeList.size() == 1) {
                    parentObjApiName = SchemaService.getSObjectName(
                        objTypeList[0]
                    );
                } else {
                    Schema.SObjectType parentSot = SchemaService.getFieldSObjectType(
                        field
                    );
                    parentObjApiName = SchemaService.getSObjectName(parentSot);
                }

                fieldApiName = SchemaService.getFieldName(field);
                fieldRelationshipName = relationshipName;
                isPolymorphic = (objTypeList.size() > 1);

                sObject parentRecord = SchemaService.getSObjectType(
                        parentObjApiName
                    )
                    .newSObject();

                Map<String, Object> objInfo = new Map<String, Object>{
                    'fieldApiName' => fieldApiName,
                    'fieldRelationshipName' => fieldRelationshipName,
                    'parentObjApiName' => parentObjApiName,
                    'objApiName' => objApiName,
                    'parentRecord' => parentRecord,
                    'isPolymorphic' => isPolymorphic
                };
                return objInfo;
            }
        }

        throw new QueryException('Invalid relationship name: ' + fieldName);
    }

    /** @description : return a parent sObject from a field name and a child sObject
     * @param sObj : the child sObject
     * @param fieldName : the field name of the parent sObject from the child
     *                  : ex. OpportunityLineItem, the field is Opportunity
     * @return A map with the parent sObject, the field api name, and the relationship name
     */
    public static Map<String, Object> getParentObject(
        sObject sObj,
        String fieldName
    ) {
        // api name of the child sObject
        String objApiName = sObj.getSObjectType().getDescribe().getName();
        // api name of the id object on the child (i.e. OpportunityId)
        String fieldApiName;
        // api name of the relationship field on the child (i.e. Opportunity)
        String fieldRelationshipName;
        // api name of the parent sObject
        String parentObjApiName;
        // whether this field is a polymorphic relationship
        Boolean isPolymorphic = false;

        String sObjApiName = sObj.getSObjectType().getDescribe().getName();
        SObjectType t = ((SObject) Type.forName(sObjApiName).newInstance())
            .getSObjectType();

        List<Schema.SObjectField> fields = SchemaService.getFields(t);
        for (SObjectField f : t.getDescribe().fields.getMap().values()) {
            Schema.DescribeFieldResult dfr = f.getDescribe();
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
                List<Schema.sObjectType> objTypeList = dfr.getReferenceTo();

                if (objTypeList.size() == 1) {
                    parentObjApiName = objTypeList[0].getDescribe().getName();
                } else {
                    String parentFieldApiName = SchemaService.getFieldName(f);
                    Id parentRecordId = (Id) sObj.get(parentFieldApiName);
                    parentObjApiName = SchemaService.getSObjectName(
                        parentRecordId
                    );
                    isPolymorphic = true;
                }

                if (parentObjApiName == null) {
                    throw new QueryException(
                        'Invalid relationship name: ' + fieldName
                    );
                }

                fieldApiName = dfr.getName();
                fieldRelationshipName = dfr.getRelationshipName();

                sObject parentRecord = ((sObject) Type.forName(parentObjApiName)
                        .newInstance())
                    .getSObjectType()
                    .newSObject();

                Id parentId = (Id) DataStore.getById(sObj.Id).get(fieldApiName);

                parentRecord.put('Id', parentId);
                Map<String, Object> objInfo = new Map<String, Object>{
                    'fieldApiName' => fieldApiName,
                    'fieldRelationshipName' => fieldRelationshipName,
                    'parentObjApiName' => parentObjApiName,
                    'objApiName' => objApiName,
                    'parentRecord' => parentRecord,
                    'isPolymorphic' => isPolymorphic
                };
                return objInfo;
            }
        }

        throw new QueryException('Invalid relationship name: ' + fieldName);
    }
}
