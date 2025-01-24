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
 * @description CountDistinctCalculator is a class that implements the IAggregateCalculator interface. It calculates the distinct count of a field.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class CountDistinctCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    /**
     * @description Constructor for the CountDistinctCalculator class.
     * @param options
     */
    public CountDistinctCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description This method calculates the distinct count of a field.
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(options.aggregateResult, options.alias, options.value);
    }

    /**
     * @description Returns the distinct count of the records passed in as `aggregateResult` in options
     * @return  `Object`
     */
    public Object calculateForField() {
        return this.options.aggregateResult.getRecords().size();
    }

    private ProtoAggregate calculate(
        ProtoAggregate aggregateResult,
        String alias,
        Object value
    ) {
        Integer currValue = (Integer) aggregateResult.get(alias);
        if (currValue == null) {
            currValue = 0;
        }
        Set<Object> distinctValues = (Set<Object>) aggregateResult.get(
            alias + '__distinct'
        );
        if (distinctValues == null) {
            distinctValues = new Set<Object>();
        }
        aggregateResult.put(alias + '__distinct', distinctValues);
        if (value != null) {
            distinctValues.add(value);
        }
        aggregateResult.put(alias, distinctValues.size());
        return aggregateResult;
    }
}
