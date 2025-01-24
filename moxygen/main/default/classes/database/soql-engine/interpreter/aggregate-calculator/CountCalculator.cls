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
 * @description CountCalculator is a concrete implementation of IAggregateCalculator that calculates the count of records.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class CountCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;

    /**
     * @description Constructor for CountCalculator
     * @param options
     */
    public CountCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the count of records
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(options.aggregateResult, options.alias);
    }

    /**
     * @description Returns the count of records for the `aggregateResult` passed into options
     * @return  `Object`
     */
    public Object calculateForField() {
        return options.aggregateResult.getRecords().size();
    }

    /**
     * @description Calculates the count of records
     * @param aggregateResult
     * @param alias
     * @return  `ProtoAggregate`
     */
    private ProtoAggregate calculate(
        ProtoAggregate aggregateResult,
        String alias
    ) {
        Integer currValue = (Integer) aggregateResult.get(alias);
        if (currValue == null) {
            currValue = 0;
        }
        aggregateResult.put(alias, currValue + 1);
        return aggregateResult;
    }
}
