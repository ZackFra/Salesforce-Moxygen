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
 * @description Generates an instance of an aggregate calculator based on the type provided
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class AggregateCalculatorFactory {
    private class AggregateCalculatorException extends Exception {
    }

    /**
     * @description Generates an instance of an aggregate calculator based on the type provided
     * @param type
     * @param options
     * @return  `IAggregateCalculator`
     * @exception AggregateCalculatorException
     */
    public static IAggregateCalculator getCalculator(
        String type,
        AggregateCalculatorOptions options
    ) {
        Map<String, IAggregateCalculator> calculators = new Map<String, IAggregateCalculator>{
            'sum' => new SumCalculator(options),
            'avg' => new AverageCalculator(options),
            'max' => new MaxCalculator(options),
            'min' => new MinCalculator(options),
            'count_distinct' => new CountDistinctCalculator(options),
            'count' => new CountCalculator(options),
            'calendar_month' => new CalendarMonthCalculator(options),
            'calendar_year' => new CalendarYearCalculator(options),
            'calendar_quarter' => new CalendarQuarterCalculator(options)
        };
        IAggregateCalculator calculator = calculators.get(type);
        if (calculator == null) {
            throw new AggregateCalculatorException('Invalid type');
        }
        return calculator;
    }
}
