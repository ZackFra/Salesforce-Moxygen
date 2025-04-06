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
 * @description This class is responsible for handling the WHERE clause logic
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
@SuppressWarnings(
    'PMD.StdCyclomaticComplexity,PMD.CognitiveComplexity,PMD.CyclomaticComplexity'
)
public with sharing class WhereLogicHandler extends BooleanLogicHandler {
    SObject record;

    enum ComparisonStrategy {
        DATE_FUNC,
        PARENT_FIELD,
        FIELD
    }

    Map<ComparisonStrategy, Type> strategyTypeByEnum = new Map<ComparisonStrategy, Type>{
        ComparisonStrategy.DATE_FUNC => WhereLogicDateFuncStrategy.class,
        ComparisonStrategy.PARENT_FIELD => WhereLogicParentFieldStrategy.class,
        ComparisonStrategy.FIELD => WhereLogicRecordFieldStrategy.class
    };

    /**
     * @description Constructor
     * @param options - the options to be used for the handler
     */
    public WhereLogicHandler(BooleanLogicOptions options) {
        super(options);
        this.record = (SObject) this.obj;
    }

    /**
     * @description Checks if the WHERE clause is met
     * @param operatorNode
     * @return  `Boolean`
     * @exception QueryException
     */
    public override Boolean isCompareConditionMet(Node operatorNode) {
        Node fieldNode = operatorNode.left;
        Node valueNode = operatorNode.right;

        Object fieldValue = getFieldValueFromValueNode(valueNode);

        // the Type field on a polymorphic relationship is a special case
        ComparisonStrategy strategy = getComparisonStrategy(fieldNode);
        Type strategyType = strategyTypeByEnum.get(strategy);
        IWhereLogicComparisonStrategy comparisonStrategy = (IWhereLogicComparisonStrategy) strategyType.newInstance();
        WhereLogicComparisonResults comparisonResults = comparisonStrategy.getFieldValue(
            this.record,
            fieldNode
        );

        String finalField = comparisonResults.getFinalField();
        SObject parentRecord = comparisonResults.getParentRecord();
        Object sObjectFieldValue = comparisonResults.getRecordFieldValue();

        OperatorHandlerFactory handlerFactory = new OperatorHandlerFactory();

        IOperatorHandler handler = handlerFactory.getHandler(operatorNode.id);
        if (comparisonResults.getIsPolymorphicTypeField()) {
            return handler.handle(sObjectFieldValue, fieldValue);
        }

        Schema.SObjectType parentSot = SchemaService.getSObjectType(
            parentRecord
        );
        Schema.DisplayType fieldType = SchemaService.getFieldType(
            parentSot,
            finalField
        );

        validateListHandlers(handler, fieldType);

        if (valueNode.nodeType == NodeType.DATE_LITERAL) {
            fieldValue = new DateLiteral.Builder()
                .setFieldValue((String) fieldValue)
                .build();
        } else if (valueNode.nodeType != NodeType.VALUE_LIST) {
            fieldValue = adjustForSoqlDateString(fieldValue, fieldType);
        }
        return handler.handle(sObjectFieldValue, fieldValue);
    }

    private ComparisonStrategy getComparisonStrategy(Node fieldNode) {
        String fieldName = fieldNode.id;
        Boolean isParentField = fieldName.contains('.');
        if (AggregateService.isDateFunc(fieldNode.nodeType, fieldNode.id)) {
            return ComparisonStrategy.DATE_FUNC;
        } else if (isParentField) {
            return ComparisonStrategy.PARENT_FIELD;
        } else {
            return ComparisonStrategy.FIELD;
        }
    }

    private Object getFieldValueFromValueNode(Node valueNode) {
        Object fieldValue = getFieldNodeValue(
            valueNode,
            this.record,
            this.params
        );
        if (!(fieldValue instanceof List<Object>)) {
            fieldValue = String.valueOf(fieldValue);
        }
        return fieldValue;
    }

    @SuppressWarnings(
        'PMD.CognitiveComplexity,PMD.NcssMethodCount,PMD.CyclomaticComplexity'
    )
    private Object getFieldNodeValue(
        Node valueNode,
        sObject sObj,
        Map<String, Object> params
    ) {
        Boolean isBindVar = (valueNode.nodeType == NodeType.XBIND_VARIABLE);
        Boolean isParamsNull = (params == null);
        Boolean isValueInParams = (!isParamsNull &&
        params.containsKey(valueNode.id));

        if (isBindVar && isParamsNull || isBindVar && !isValueInParams) {
            throw new QueryException('Missing bind variable: ' + valueNode.id);
        }

        if (isBindVar) {
            return params.get(valueNode.id);
        }

        if (valueNode.nodeType == NodeType.VALUE_LIST) {
            List<Object> values = new List<Object>();
            Node valueListNode = valueNode;
            while (valueListNode != null && valueListNode.left != null) {
                values.add(valueListNode.left);
                valueListNode = valueListNode.left.left;
            }
            return values;
        }

        if (valueNode.nodeType == NodeType.XNULL) {
            return null;
        }

        if (valueNode.nodeType == NodeType.SUBQUERY) {
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

    private Object adjustForSoqlDateString(
        Object fieldValue,
        Schema.DisplayType fieldType
    ) {
        Boolean isString = (fieldValue instanceof String);
        Boolean isDate = (fieldType == Schema.DisplayType.DATE);
        Boolean isDateTime = (fieldType == Schema.DisplayType.DATETIME);
        Boolean isDateOrDateTime = isDate || isDateTime;
        if (!isString && !isDateOrDateTime) {
            return fieldValue;
        }
        return ((String) fieldValue).toUpperCase();
    }

    private void validateListHandlers(
        IOperatorHandler handler,
        Schema.DisplayType fieldType
    ) {
        Boolean isMultiPicklist = (fieldType ==
        Schema.DisplayType.MULTIPICKLIST);
        if (isMultiPicklist) {
            return;
        }

        Boolean isIncludesHandler = (handler instanceof IncludesHandler);
        Boolean isExcludesHandler = (handler instanceof ExcludesHandler);
        if (isIncludesHandler || isExcludesHandler) {
            throw new QueryException(
                'Invalid field type for INCLUDES operator'
            );
        }
    }
}
