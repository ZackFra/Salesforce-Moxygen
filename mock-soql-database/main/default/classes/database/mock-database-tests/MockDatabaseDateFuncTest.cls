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
private class MockDatabaseDateFuncTest {
    
    @IsTest
    static void testCalendarMonthIsCorrect() {
        Account acct1 = new Account(
            Name = 'Test'
        );

        Account acct2 = new Account(
            Name = 'Test2'
        );

        List<Account> acctList = new List<Account>{acct1, acct2};
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery('SELECT Name, CALENDAR_MONTH(CreatedDate) FROM Account GROUP BY Name, CALENDAR_MONTH(CreatedDate)');
        Test.stopTest();
        Integer calendarMonth = System.today().month();
        Assert.areEqual(calendarMonth, queriedAccountAggregates[0].get('expr0'), 'Incorrect Month');
        Assert.areEqual(calendarMonth, queriedAccountAggregates[1].get('expr0'), 'Incorrect Month');
    }

    @IsTest
    static void testCalendarMonthIsCorrectWithAlias() {
        Account acct1 = new Account(
            Name = 'Test'
        );

        Account acct2 = new Account(
            Name = 'Test2'
        );

        List<Account> acctList = new List<Account>{acct1, acct2};
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery('SELECT Name, CALENDAR_MONTH(CreatedDate) month FROM Account GROUP BY Name, CALENDAR_MONTH(CreatedDate)');
        Test.stopTest();
        Integer calendarMonth = System.today().month();
        Assert.areEqual(calendarMonth, queriedAccountAggregates[0].get('month'), 'Incorrect Month');
        Assert.areEqual(calendarMonth, queriedAccountAggregates[1].get('month'), 'Incorrect Month');
    }

    @IsTest
    static void testCalendarMonthIsCorrectWithAliasFail() {
        Account acct1 = new Account(
            Name = 'Test'
        );

        Account acct2 = new Account(
            Name = 'Test2'
        );

        List<Account> acctList = new List<Account>{acct1, acct2};
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery('SELECT Name, CALENDAR_MONTH(CreatedDate) month FROM Account GROUP BY Name, month');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
        
    }
}