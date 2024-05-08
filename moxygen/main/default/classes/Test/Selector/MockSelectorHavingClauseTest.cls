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
private class MockSelectorHavingClauseTest {

    @IsTest
    static void testCalendarMonthInHavingClause() {
        Opportunity opp = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 1, 1), // January 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );
        DML.doInsert(opp, true);

        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQuery(
            'SELECT CALENDAR_MONTH(CloseDate) month, SUM(Amount) total' +
            ' FROM Opportunity' +
            ' GROUP BY CALENDAR_MONTH(CloseDate)' +
            ' HAVING CALENDAR_MONTH(CloseDate) = 1'
        );
        Aggregate ar = arList[0];
        Test.stopTest();
        Assert.areEqual(
            1,
            arList[0].get('month'),
            'Should have 1 result'
        );
    }

    @IsTest
    static void testCalendarMonthLessThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 1, 1), // January 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );
        Opportunity opp2 = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 2, 1), // February 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );

        Opportunity opp3 = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 3, 1), // March 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );
        List<Opportunity> oppList = new List<Opportunity> {
            opp1,
            opp2,
            opp3
        };
        DML.doInsert(oppList, true);

        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQuery(
            'SELECT CALENDAR_MONTH(CloseDate) month, SUM(Amount) total' +
            ' FROM Opportunity' +
            ' GROUP BY CALENDAR_MONTH(CloseDate)' +
            ' HAVING CALENDAR_MONTH(CloseDate) < 12'
        );
        Test.stopTest();
        Assert.areEqual(
            3,
            arList.size(),
            'Should have 1 result'
        );        
    }

    @IsTest
    static void testCalendarMonthGreaterThanOrEqual() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 1, 1), // January 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );
        Opportunity opp2 = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 2, 1), // February 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );

        Opportunity opp3 = new Opportunity(
            Name = 'Test',
            CloseDate = Date.newInstance(2024, 3, 1), // March 1, 2024
            StageName = 'Closed Won',
            Amount = 1000
        );
        List<Opportunity> oppList = new List<Opportunity> {
            opp1,
            opp2,
            opp3
        };
        DML.doInsert(oppList, true);

        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQuery(
            'SELECT CALENDAR_MONTH(CloseDate) month, SUM(Amount) total' +
            ' FROM Opportunity' +
            ' GROUP BY CALENDAR_MONTH(CloseDate)' +
            ' HAVING CALENDAR_MONTH(CloseDate) >= 2'
        );
        Test.stopTest();
        Assert.areEqual(
            2,
            arList.size(),
            'Should have 1 result'
        );        
    }
}