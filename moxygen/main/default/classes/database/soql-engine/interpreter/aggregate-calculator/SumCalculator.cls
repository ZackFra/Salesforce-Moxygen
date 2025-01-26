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
 * @description Calculates the sum of a field
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class SumCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    /**
     * @description Constructor
     * @param options
     */
    public SumCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the sum of a field
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(options.aggregateResult, options.alias, options.value);
    }

    /**
     * @description return the sum of the `alias` field passed into options
     *              for the records in `aggregateResult` passed into options
     * @return  `Object`
     */
    public Object calculateForField() {
        ProtoAggregate aggregateResult = options.aggregateResult;
        String fieldName = options.alias;
        Decimal sum = 0;
        List<SObject> records = aggregateResult.getRecords();
        for (SObject record : records) {
            Object value = record.get(fieldName);
            if (value != null) {
                sum += (Decimal) value;
            }
        }
        return sum;
    }

    private ProtoAggregate calculate(
        ProtoAggregate aggregateResult,
        String alias,
        Object value
    ) {
        if (value == null) {
            // make sure it's explicitly set to null
            if (!aggregateResult.containsKey(alias)) {
                aggregateResult.put(alias, null);
            }
            return aggregateResult;
        }

        Decimal currValue = (Decimal) aggregateResult.get(alias);
        Decimal newValue = (Decimal) value;
        Decimal sum;
        if (currValue == null) {
            sum = newValue;
        } else {
            sum = currValue + newValue;
        }

        aggregateResult.put(alias, sum);
        return aggregateResult;
    }
}
