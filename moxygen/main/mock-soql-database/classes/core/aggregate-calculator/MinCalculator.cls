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
 * @description Calculates the minimum value of a field 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class MinCalculator implements IAggregateCalculator {

    AggregateCalculatorOptions options;
    /**
     * @description Constructor
     * @param options 
     */
    public MinCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the minimum value of a field 
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(
            options.aggregateResult,
            options.alias,
            options.value
        );
    }

    /**
     * @description calculate the min of the `alias` field passed into options,
     *              for the records associated with the `aggregateResult` passed into options
     * @return  `Object`
     */
    public Object calculateForField() {
        ProtoAggregate aggregateResult = options.aggregateResult;
        List<SObject> records = aggregateResult.getRecords();
        SObject firstRecord = records[0];

        String fieldName = options.alias;
        Decimal min = (Decimal) firstRecord.get(fieldName);

        for(Integer i = 1; i < records.size(); i++) {
            SObject record = records[i];
            Object value = record.get(fieldName);
            if(value != null) {
                Decimal decimalValue = (Decimal) value;
                min = Math.min(min, decimalValue);
            }
        }
        return min;        
    }
    
    private ProtoAggregate calculate(ProtoAggregate aggregateResult, String alias, Object value) {
        if(value == null) {
            // make sure it's explicitly set to null
            if(!aggregateResult.containsKey(alias)) {
                aggregateResult.put(alias, null);
            }
            return aggregateResult;
        }
        Decimal currValue = (Decimal) aggregateResult.get(alias);
        Decimal newValue = (Decimal) value;

        if(currValue == null) {
            currValue = newValue;
        } else {
            currValue = Math.min(currValue, newValue);
        }

        aggregateResult.put(alias, currValue);
        return aggregateResult;
    }
}