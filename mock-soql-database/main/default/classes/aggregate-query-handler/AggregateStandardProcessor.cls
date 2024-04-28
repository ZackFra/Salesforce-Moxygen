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
 * @description Standard processor for aggregate queries 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public inherited sharing class AggregateStandardProcessor extends AggregateProcessor {
    private List<ProtoAggregate> aggregateResults = new List<ProtoAggregate>();

    public override void processRecord(SObject databaseRecord) {
        Node selectNode = topLevelNodes.selectNode;

        Map<String, List<String>> aggrFields = AggregateService.getAggregateFields(topLevelNodes);
        List<String> groupByFields = aggrFields.get('groupByFields');

        ProtoAggregate aggregateResult = findGroupedAggregate(databaseRecord, groupByFields);
        if(aggregateResult == null) {
            aggregateResult = createGroupedAggregate(databaseRecord, groupByFields);
            aggregateResults.add(aggregateResult);
        }

        
        Integer exprNumber = 0;
        for(Node currSelect = selectNode.left; currSelect != null; currSelect = currSelect.left) {
            Boolean isAggregateFunc = (currSelect.nodeType == 'aggregate function');

            if(!isAggregateFunc) {
                continue;
            }


            Node fieldNode = currSelect.right;
            Node aliasNode = fieldNode.left;
            String fieldName = fieldNode.id;

            Map<String, Object> comparableInfo = MockDatabase.getComparables(databaseRecord, fieldName);
            sObject comparableRecord = (SObject) comparableInfo.get('comparableRecord');
            String comparableField = (String) comparableInfo.get('comparableField');

            Schema.SObjectType sot = SchemaService.getSObjectType(comparableRecord);
            Schema.DisplayType fieldType = SchemaService.getFieldType(sot, comparableField);
            
            String alias = 'expr' + exprNumber;

            if(aliasNode != null) {
                alias = aliasNode.id;
            } else {
                exprNumber++;
            }

            Boolean isFieldNumeric = SchemaService.isFieldNumeric(fieldType);

            List<String> numericFuncs = new List<String> {
                'sum', 'max', 'min', 'avg'
            };

            Boolean isExpectingNumeric = (numericFuncs.contains(currSelect.id));
            if(isExpectingNumeric && !isFieldNumeric) {
                throw new QueryException('Invalid field type');
            }

            calculateAggregate(
                currSelect, 
                alias, 
                aggregateResult,
                comparableRecord.get(comparableField)
            );
        }
    }

    public override List<ProtoAggregate> finish() {
        return aggregateResults;
    }

    /**
     * @description create a new aggregate result for the grouped aggregate
     * @param databaseRecord the database record
     * @param groupByFields the fields to group by
     * @return the new aggregate result
     */
    private ProtoAggregate createGroupedAggregate(SObject databaseRecord, List<String> groupByFields) {
        ProtoAggregate aggregateResult = new ProtoAggregate();
        for(String groupByField : groupByFields) {
            System.debug(groupByField);
            Map<String, Object> comparableInfo = MockDatabase.getComparables(databaseRecord, groupByField);
            sObject comparableRecord = (sObject) comparableInfo.get('comparableRecord');
            String comparableField = (String) comparableInfo.get('comparableField');

            Boolean isPolymorphic = (Boolean) comparableInfo.get('isPolymorphic');
            Boolean isType = (comparableField == 'Type');
            if(isPolymorphic && isType) {
                String type = SchemaService.getSObjectName(comparableRecord);
                aggregateResult.put(comparableField, type);
            } else if(isPolymorphic) {
                try {
                    aggregateResult.put(comparableField, comparableRecord.get(comparableField));
                } catch(System.SObjectException e) {
                    aggregateResult.put(comparableField, null);
                } catch(Exception e) {
                    throw e;
                }
            } else {
                aggregateResult.put(comparableField, comparableRecord.get(comparableField));
            }
        }
        return aggregateResult; 
    }


    /**
     * @description Find the grouped aggregate
     * @param databaseRecord 
     * @param groupByFields 
     * @return  `ProtoAggregate`
     */
    private ProtoAggregate findGroupedAggregate(SObject databaseRecord, List<String> groupByFields) {
        for(ProtoAggregate ar : aggregateResults) {
            Boolean isSame = true;
            for(String groupByField : groupByFields) {
                Map<String, Object> comparableInfo = MockDatabase.getComparables(databaseRecord, groupByField);
                sObject comparableRecord = (sObject) comparableInfo.get('comparableRecord');
                String comparableField = (String) comparableInfo.get('comparableField');

                Boolean isPolymorphic = (Boolean) comparableInfo.get('isPolymorphic');
                Boolean isType = (comparableField == 'Type');
                if(isPolymorphic && isType) {
                    String type = SchemaService.getSObjectName(comparableRecord);
                    isSame = (isSame && (type == ar.get(comparableField)));
                } else {
                    isSame = (isSame && (comparableRecord.get(comparableField) == ar.get(comparableField)));
                }
            }
            if(isSame) {
                return ar;
            }
        }
        return null;
    }
}