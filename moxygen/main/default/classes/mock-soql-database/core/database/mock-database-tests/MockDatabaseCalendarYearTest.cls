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
private class MockDatabaseCalendarYearTest {
    @IsTest
    static void testCalendarYearIsCorrect() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_YEAR(CreatedDate) FROM Account GROUP BY Name, CALENDAR_YEAR(CreatedDate)'
        );
        Test.stopTest();
        Integer calendarYear = GMT.today().year();
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[0].get('expr0'),
            'Incorrect Year'
        );
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[1].get('expr0'),
            'Incorrect Year'
        );
    }

    @IsTest
    static void testCalendarYearIsCorrectWithAlias() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_YEAR(CreatedDate) year FROM Account GROUP BY Name, CALENDAR_YEAR(CreatedDate)'
        );
        Test.stopTest();
        Integer calendarYear = GMT.today().year();
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[0].get('year'),
            'Incorrect Year'
        );
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[1].get('year'),
            'Incorrect Year'
        );
    }

    @IsTest
    static void testCalendarYearIsCorrectWithAliasFail() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, CALENDAR_YEAR(CreatedDate) year FROM Account GROUP BY Name, year'
            );
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testCalendarYearInWhereClause() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);
        Integer year = GMT.today().year();
        Map<String, Object> binds = new Map<String, Object>{ 'year' => year };
        Test.startTest();
        List<Account> queriedAccountAggregates = (List<Account>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Account WHERE CALENDAR_YEAR(CreatedDate) = :year',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            2,
            queriedAccountAggregates.size(),
            'Incorrect number of records returned'
        );
    }

    @IsTest
    static void testCalendarYearInWhereClauseWithOpportunityCloseDate() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today() - 366
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Integer year = GMT.today().year();
        Map<String, Object> binds = new Map<String, Object>{ 'year' => year };
        Test.startTest();
        List<Account> queriedOpportunities = (List<Account>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE CALENDAR_YEAR(CloseDate) = :year',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedOpportunities.size(),
            'Incorrect number of records returned'
        );
    }

    @IsTest
    static void testCalendarYearInWhereClauseWithOpportunityCloseDateLessThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today() - 366
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Integer year = GMT.today().year();
        Map<String, Object> binds = new Map<String, Object>{ 'year' => year };
        Test.startTest();
        List<Opportunity> queriedOpportunities = (List<Opportunity>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE CALENDAR_YEAR(CloseDate) < :year',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedOpportunities.size(),
            'Incorrect number of records returned'
        );
        Assert.areEqual(
            'Test2',
            queriedOpportunities[0].Name,
            'Incorrect record returned'
        );
    }

    @IsTest
    static void testCalendarYearWeirdDateTimeException() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, CALENDAR_YEAR(CreatedDate) year FROM Account GROUP BY Name, CreatedDate'
            );
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testCalendarYearWeirdDateException() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today()
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Aggregate> queriedOpportunityAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_YEAR(CloseDate) FROM Opportunity GROUP BY Name, CloseDate'
        );
        Test.stopTest();
        Integer calendarMonth = GMT.today().year();
        Assert.areEqual(
            calendarMonth,
            queriedOpportunityAggregates[0].get('expr0'),
            'Incorrect Year'
        );
        Assert.areEqual(
            calendarMonth,
            queriedOpportunityAggregates[1].get('expr0'),
            'Incorrect Year'
        );
    }

    /**
     * @description This is to test using the CALENDAR_YEAR method in the HAVING clause of a query
     */
    @IsTest
    static void testCalendarYearInHavingClause() {
        Opportunity testOpp = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );
        DML.doMockInsert(testOpp);

        Test.startTest();
        List<Aggregate> ar = Selector.aggregateQuery(
            String.join(
                new List<String>{
                    'SELECT Name, CALENDAR_YEAR(CloseDate)',
                    'FROM Opportunity GROUP BY Name, CALENDAR_YEAR(CloseDate)',
                    'HAVING CALENDAR_YEAR(CloseDate) > 2010'
                },
                ' '
            )
        );
        Test.stopTest();

        Assert.areEqual(1, ar.size(), 'Incorrect number of records returned');
    }

    /**
     * @description Should still select the opportunity via the HAVING clause
     */
    @IsTest
    static void testCalendarYearInHavingClauseUnselected() {
        Opportunity testOpp = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );
        DML.doMockInsert(testOpp);

        Test.startTest();
        List<Aggregate> ar = Selector.aggregateQuery(
            'SELECT Name, CloseDate' +
                ' FROM Opportunity GROUP BY Name, CloseDate' +
                ' HAVING CALENDAR_YEAR(CloseDate) > 2010'
        );
        Test.stopTest();

        Assert.areEqual(1, ar.size(), 'Incorrect number of records returned');
    }

    /**
     * @description Bulkified test of calendar year logic
     */
    @IsTest
    static void testCalendarYearInHacingClauseMultipleOpps() {
        List<Opportunity> oppList = new List<Opportunity>();

        // 50 opportunities, each with a close date of a year prior
        for (Integer i = 0; i < 50; i++) {
            Date closeDate = Gmt.today().addYears(-i);
            Opportunity newOpp = new Opportunity(
                Name = 'Test Opp' + i,
                CloseDate = closeDate
            );
            oppList.add(newOpp);
        }
        DML.doMockInsert(oppList);

        Test.startTest();
        Map<String, Object> binds = new Map<String, Object>{
            'year' => Gmt.today().addYears(-10).year()
        };
        List<Aggregate> ar = Selector.aggregateQueryWithBinds(
            String.join(
                new List<String>{
                    'SELECT Name, CALENDAR_YEAR(CloseDate)',
                    'FROM Opportunity GROUP BY Name, CALENDAR_YEAR(CloseDate)',
                    'HAVING CALENDAR_YEAR(CloseDate) > :year'
                },
                ' '
            ),
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        Assert.areEqual(
            10,
            ar.size(),
            'Expected 10 opportunities, but got ' + ar.size() + ' instead.'
        );
    }
}
