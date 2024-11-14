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
 * @description Calculates the average of a set of values. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public inherited sharing class AverageCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    /**
     * @description Constructor for the AverageCalculator class
     * @param options 
     */
    public AverageCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the average of a set of values. 
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
     * @description Calculate the average for the field specified in the `alias` field of options,
     *              of the grouped records of the `aggregateResult` field of options 
     * @return  `Object`
     */
    public Object calculateForField() {
        ProtoAggregate aggregateResult = options.aggregateResult;
        String fieldName = options.alias;
        Decimal sum = 0;
        List<SObject> records = aggregateResult.getRecords();
        Integer size = records.size();
        for(SObject record : records) {
            Object value = record.get(fieldName);
            sum += (Decimal) value;
        }
        return sum / size;
    }

    /**
     * @description Calculates the average of a set of values with an alias.
     * @param aggregateResult 
     * @param alias 
     * @param value 
     * @return  `ProtoAggregate`
     */
    private ProtoAggregate calculate(ProtoAggregate aggregateResult, String alias, Object value) {
        if(value == null) {
            return setAliasToNull(aggregateResult, alias);
        }
        Decimal currValue = (Decimal) aggregateResult.get(alias);
        Decimal newValue = (Decimal) value;
        Decimal n = getValueForN(aggregateResult, alias);

        currValue = calcCurrValue(currValue, newValue, n);

        aggregateResult.put(alias, currValue);
        aggregateResult.put(alias + '__n', n + 1);

        return aggregateResult;
    }

    Decimal getValueForN(ProtoAggregate aggregateResult, String alias) {
        Decimal n = (Decimal) aggregateResult.get(alias + '__n');
        if(n == null) {
            n = 1;
        }
        return n;
    }

    ProtoAggregate setAliasToNull(ProtoAggregate aggregateResult, String alias) {
        // make sure it's explicitly set to null
        if(!aggregateResult.containsKey(alias)) {
            aggregateResult.put(alias, null);
        }
        return aggregateResult;
    }

    Decimal calcCurrValue(Decimal currValue, Decimal newValue, Decimal n) {
        if(currValue == null) {
            currValue = newValue;
        } else {
            currValue = currValue + (newValue - currValue) / n;
        }
        return currValue;
    }
}