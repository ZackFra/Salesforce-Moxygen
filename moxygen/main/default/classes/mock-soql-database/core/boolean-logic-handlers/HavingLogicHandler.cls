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
 * @description This class is used to handle the having clause logic
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class HavingLogicHandler extends BooleanLogicHandler {

    /**
     * @description Constructor
     * @param options 
     */
    public HavingLogicHandler(BooleanLogicOptions options) {
        super(options);
    }

    /**
     * @description This method is used to check if the having condition is met
     * @param operatorNode The operator node
     * @return Boolean
     * @throws Exception
     * @see MockDatabaseUtils.OperatorHandlerFactory
     */
    public override Boolean isCompareConditionMet(Node operatorNode) {
        ProtoAggregate aggr = (ProtoAggregate) this.obj;

        Node aggrNode = operatorNode.left;
        
        Object value = getGroupByFieldValue(aggr, aggrNode);

        Node valueNode = operatorNode.right;
        Object expectedValue = getExpectedValueFrom(valueNode);
        
        OperatorHandlerFactory handlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = handlerFactory.getHandler(operatorNode.id);
        return handler.handle(value, DynamicCast.castTo(TypeOf.forObject(value), expectedValue));
    }


    Object getGroupByFieldValue(ProtoAggregate aggr, Node aggrNode) {
        if(aggrNode.nodeType == NodeType.AGGREGATE_FUNCTION) {
           return getGroupByFieldValueWhenAggregateFunc(aggr, aggrNode);
        } else {
            return getGroupByFieldValueWhenField(aggr, aggrNode);
        }
    }

    Object getGroupByFieldValueWhenAggregateFunc(ProtoAggregate aggr, Node aggrNode) {
        SObject groupedRecord = aggr.getRecords()[0];
        String groupedFieldApiName = SchemaService.getFieldName(
            groupedRecord.getSObjectType(), 
            aggrNode.right.id
        );
        AggregateCalculatorOptions options = new AggregateCalculatorOptions()
            .setAggregateResult(aggr)
            .setAlias(groupedFieldApiName);
        IAggregateCalculator calculator = AggregateCalculatorFactory.getCalculator(aggrNode.id, options);
        Object value = calculator.calculateForField();
        return value;        
    }

    Object getGroupByFieldValueWhenField(ProtoAggregate aggr, Node aggrNode) {
        SObject groupedRecord = aggr.getRecords()[0];
        String fieldName = aggrNode.id;
        Map<String, Object> comparableInfo = ComparableService.getComparables(groupedRecord, fieldName);
        String comparableField = (String) comparableInfo.get('comparableField');
        SObject comparableRecord = (SObject) comparableInfo.get('comparableRecord');
        Boolean isPolymorphic = (Boolean) comparableInfo.get('isPolymorphic');
        Boolean isType = comparableField == 'Type';
        if(isPolymorphic && isType) {
            return SchemaService.getSObjectName(comparableRecord);
        } 
        return comparableRecord.get(comparableField);  
    }

    Object getExpectedValueFrom(Node valueNode) {
        if(valueNode.nodeType == NodeType.BIND_VAR) {
            return String.valueOf(params.get(valueNode.id));
        }
        return valueNode.id;
    }
}