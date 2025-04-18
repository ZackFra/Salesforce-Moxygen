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
 * @description Calculates the calendar month from a date value
 * @author Zackary Frazier
 * @since 4/28/2024
 * @group Soql Engine
 */
public with sharing class CalendarMonthCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;

    /**
     * @description Constructor for the CalendarMonthCalculator class
     * @param options
     */
    public CalendarMonthCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the average of a set of values.
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(options.aggregateResult, options.alias, options.value);
    }

    /**
     * @description Calculate the calendar month of field passed in as `alias` in options,
     *              for the grouped records of the `aggregateResult` passed into options
     * @return  `Object`
     */
    public Object calculateForField() {
        String fieldName = options.alias;
        ProtoAggregate aggregateResult = options.aggregateResult;
        SObject firstRecord = aggregateResult.getRecords()[0];
        Object value = firstRecord.get(fieldName);
        return calendarMonth(value);
    }

    /**
     * @description Calculates the average of a set of values with an alias.
     * @param aggregateResult
     * @param alias
     * @param value
     * @return  `ProtoAggregate`
     */
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
        Integer calendarMonth = calendarMonth(value);

        aggregateResult.put(alias, calendarMonth);
        return aggregateResult;
    }

    private Integer calendarMonth(Object value) {
        IDateFunc calendarMonthFunc = new CalendarMonthFunc();
        Integer calendarMonth = calendarMonthFunc.calculate(value);
        return calendarMonth;
    }
}
