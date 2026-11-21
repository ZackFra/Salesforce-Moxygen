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

@IsTest
@SuppressWarnings('PMD')
private class ParserDateFuncTest {
    /** calendar quarter **/
    @IsTest
    static void testParseCalendarQuarterInSelectClause() {
        ParserTestUtil.assertStaticResource('CALENDAR_QUARTER_0');
    }

    @IsTest
    static void parseCalendarQuarterInWhereClause() {
        ParserTestUtil.assertStaticResource('CALENDAR_QUARTER_1');
    }

    @IsTest
    static void parseCalendarQuarterInHavingClause() {
        ParserTestUtil.assertStaticResource('CALENDAR_QUARTER_2');
    }

    /** calendar month */
    @IsTest
    static void testCalendarMonthInWhereClauseAST() {
        ParserTestUtil.assertStaticResource('CALENDAR_MONTH_0');
    }

    @IsTest
    static void testCalendarMonthInSelectClause() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name, CALENDAR_MONTH(CreatedDate) FROM Account GROUP BY Name, CALENDAR_MONTH(CreatedDate)'
        );
    }

    @IsTest
    static void testCalendarMonthInWhereClause() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE CALENDAR_MONTH(CreatedDate) = 1'
        );
    }

    /** CALENDAR YEAR **/
    @IsTest
    static void testParseCalendarYearInWhereClause() {
        ParserTestUtil.assertStaticResource('CALENDAR_YEAR_0');
    }

    @IsTest
    static void testParseCalendarYearInSelectClause() {
        ParserTestUtil.assertStaticResource('CALENDAR_YEAR_1');
    }

    @IsTest
    static void testRemainingDateFunctionsParse() {
        List<String> dateFuncs = new List<String>{
            'DAY_IN_MONTH',
            'DAY_IN_WEEK',
            'DAY_IN_YEAR',
            'DAY_ONLY',
            'FISCAL_MONTH',
            'FISCAL_QUARTER',
            'FISCAL_YEAR',
            'HOUR_IN_DAY',
            'WEEK_IN_MONTH',
            'WEEK_IN_YEAR'
        };
        Parser parser = new Parser();
        for (String dateFunc : dateFuncs) {
            parser.parse(
                'SELECT Name FROM Account WHERE ' +
                    dateFunc +
                    '(CreatedDate) = 1'
            );
            parser.parse(
                'SELECT ' +
                    dateFunc +
                    '(CreatedDate) FROM Account GROUP BY ' +
                    dateFunc +
                    '(CreatedDate)'
            );
            parser.parse(
                'SELECT ' +
                    dateFunc +
                    '(CreatedDate) FROM Account GROUP BY ' +
                    dateFunc +
                    '(CreatedDate) HAVING ' +
                    dateFunc +
                    '(CreatedDate) = 1'
            );
        }
    }
}
