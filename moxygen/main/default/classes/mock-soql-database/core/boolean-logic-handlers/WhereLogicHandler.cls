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
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public with sharing class WhereLogicHandler extends BooleanLogicHandler {

    SObject record;

    /**
     * @description Constructor
     * @param options - the options to be used for the handler
     */
    public WhereLogicHandler(BooleanLogicOptions options) {
        super(options);
        this.record = (SObject) this.obj;
    }

    enum ComparisonStrategy {
        DATE_FUNC,
        PARENT_FIELD,
        FIELD
    }

    Map<ComparisonStrategy, Type> strategyTypeByEnum = new Map<ComparisonStrategy, Type> {
        ComparisonStrategy.DATE_FUNC => WhereLogicDateFuncStrategy.class,
        ComparisonStrategy.PARENT_FIELD => WhereLogicParentFieldStrategy.class,
        ComparisonStrategy.FIELD => WhereLogicRecordFieldStrategy.class
    };

    /**
     * @description Checks if the WHERE clause is met
     * @param operatorNode 
     * @return  `Boolean`
     * @exception QueryException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity, PMD.NcssMethodCount, PMD.CognitiveComplexity')
    public override Boolean isCompareConditionMet(Node operatorNode) {
        Node fieldNode = operatorNode.left;
        Node valueNode = operatorNode.right;
        
        Object fieldValue = getFieldValueFromValueNode(valueNode);
        
        String fieldName = fieldNode.id;
        Object sObjectFieldValue;

        Boolean isParentField = fieldName.contains('.');

        // if the field is a parent field, we need to get the parent record
        // further down, we can't say for sure whether the field is a parent field or not
        // so we'll need to store our object and field name in a variable
        sObject parentRecord = this.record;
        String finalField = fieldName;

        // the Type field on a polymorphic relationship is a special case
        ComparisonStrategy strategy = getStrategy(fieldNode);
        Type strategyType = strategyTypeByEnum.get(strategy);
        IWhereLogicComparisonStrategy comparisonStrategy = (IWhereLogicComparisonStrategy) strategyType.newInstance();
        WhereLogicComparisonResults comparisonResults = comparisonStrategy.getFieldValue(parentRecord, fieldNode);

        OperatorHandlerFactory handlerFactory = new OperatorHandlerFactory();

        IOperatorHandler handler = handlerFactory.getHandler(operatorNode.id);
        if(comparisonResults.getIsPolymorphicTypeField()) {
            return handler.handle(sObjectFieldValue, fieldValue);
        }
        
        Schema.SObjectType parentSot = SchemaService.getSObjectType(parentRecord);
        Schema.DisplayType fieldType = SchemaService.getFieldType(parentSot, finalField);
        
        validateListHandlers(handler, fieldType);

        if(valueNode.nodeType == NodeType.DATE_LITERAL) {
            if(fieldType != Schema.DisplayType.DATE && fieldType != Schema.DisplayType.DATETIME) {
                throw new QueryException('Invalid field type for date literal');
            }

            Map<String, Integer> daysByDateLiteral = new Map<String, Integer>{
                Token.TODAY_LITERAL => 0,
                Token.YESTERDAY_LITERAL => -1,
                Token.TOMORROW_LITERAL => 1
            };
            Set<String> dateLiterals = daysByDateLiteral.keySet();
            for(String dateLiteral : dateLiterals) {
                if(fieldValue != dateLiteral) {
                    continue;
                }

                if(fieldType == Schema.DisplayType.Date || fieldType == Schema.DisplayType.DATETIME) {
                    Integer daysToAdjustBy = daysByDateLiteral.get(dateLiteral);
                    fieldValue = Common.dateToSoqlString(GMT.today().addDays(daysToAdjustBy));
                    if(fieldType == Schema.DisplayType.DATETIME && sObjectFieldValue != null) {
                        sObjectFieldValue = GMT.date((DateTime) sObjectFieldValue);
                    }
                    break;
                }
            }
        }
        fieldValue = adjustForSoqlDateString(fieldValue, fieldType);

        return handler.handle(sObjectFieldValue, fieldValue);
    }

    private Object getFieldValueFromValueNode(Node valueNode) {
        Object fieldValue = MockDatabase.utils.getFieldNodeValue(valueNode, this.record, this.params);
        if(!(fieldValue instanceOf List<Object>)) {
            fieldValue = String.valueOf(fieldValue);
        }
        return fieldValue;
    }

    private Object adjustForSoqlDateString(Object fieldValue, Schema.DisplayType fieldType) {
        Boolean isString = (fieldValue instanceof String);
        Boolean isDate = (fieldType == Schema.DisplayType.DATE);
        Boolean isDateTime = (fieldType == Schema.DisplayType.DATETIME);
        Boolean isDateOrDateTime = isDate || isDateTime;
        if(!isString && !isDateOrDateTime) {
            return fieldValue;
        }
        return ((String) fieldValue).toUpperCase();
    }

    private void validateListHandlers(IOperatorHandler handler, Schema.DisplayType fieldType) {
        Boolean isMultiPicklist = (fieldType == Schema.DisplayType.MULTIPICKLIST);
        if(isMultiPicklist) {
            return;
        }

        Boolean isIncludesHandler = (handler instanceof IncludesHandler);
        Boolean isExcludesHandler = (handler instanceof ExcludesHandler);
        if(isIncludesHandler || isExcludesHandler) {
            throw new QueryException('Invalid field type for INCLUDES operator');
        }
    }
}