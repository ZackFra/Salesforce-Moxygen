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
@isTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts,PMD.CyclomaticComplexity')
private class MockDatabaseCalendarQuarterTest {

    final static Integer YEAR = 2024;
    final static Integer DAY = 1;

    static final Map<Integer, Integer> RECORDS_BY_QUARTER = new Map<Integer, Integer> {
        1 => 5,
        2 => 3,
        3 => 7,
        4 => 2
    };    

    /**
     * @description Ensure this date function works with Date fields
     */
    @IsTest
    static void useDateForOneRecord() {
        Opportunity opp = new Opportunity(
            Name = 'First Calendar Quarter',
            CloseDate = Date.newInstance(2024, 1, 1)
        );
        DML.doMockInsert(opp);

        Test.startTest();
        List<Opportunity> oppList = Selector.query(
                'SELECT Id, Name' +
                ' FROM Opportunity' +
                ' WHERE CALENDAR_QUARTER(CloseDate) = 1'
        );
        Test.stopTest();

        Assert.areEqual(1, oppList.size(), 'Incorrect number of opportunities');
        Assert.areEqual('First Calendar Quarter', oppList[0].Name, 'Incorrect opportunity');
    }

    /**
     * @description Ensure this works when returning multiple opportunities
     */
    @IsTest
    static void returnMultipleUsingDates() {
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities.addAll(createOpportunitiesInCalendarQuarter(3, 1));
        opportunities.addAll(createOpportunitiesInCalendarQuarter(4, 2));
        opportunities.addAll(createOpportunitiesInCalendarQuarter(3, 3));
        opportunities.addAll(createOpportunitiesInCalendarQuarter(2, 4));
        DML.doMockInsert(opportunities);
        
        Test.startTest();
        List<Opportunity> queriedOpportunities = Selector.query(
                'SELECT Id, Name' +
                ' FROM Opportunity' +
                ' WHERE CALENDAR_QUARTER(CloseDate) = 2'
        );
        Test.stopTest();

        Assert.areEqual(
            	4,
            	queriedOpportunities.size(),
            	'Incorrect number of opportunities'
        );
    }

    /**
     * @description Ensure this date function works with DateTime fields
     */
    @IsTest
    static void useDateTimeForOneRecord() {
        List<Case> cases = createCasesInCalendarQuarter(1, 1);
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = Selector.query(
            'SELECT CaseNumber ' +
            ' FROM Case' +
            ' WHERE CALENDAR_QUARTER(ClosedDate) = 1'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedCases.size(),
            'Expected case to be queried'
        );
    }

    @IsTest
    static void useMultipleDateTimesQuarterOne() {
        testUsingDateTimes(1);
    }

    @IsTest
    static void useMultipleDateTimesQuarterTwo() {
        testUsingDateTimes(2);
    }

    @IsTest
    static void useMultipleDateTimesQuarterThree() {
        testUsingDateTimes(3);
    }

    @IsTest
    static void useMultipleDateTimesQuarterFour() {
        testUsingDateTimes(4);
    }

    @IsTest
    static void useMultipleDatesQuarterOne() {
        testUsingDates(1);
    }

    @IsTest
    static void useMultipleDatesQuarterTwo() {
        testUsingDates(2);
    }

    @IsTest
    static void useMultipleDatesQuarterThree() {
        testUsingDates(3);
    }

    @IsTest
    static void useMultipleDatesQuarterFour() {
        testUsingDates(4);
    }

    @IsTest
    static void useInvalidCalendarQuarterWithDates() {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Opportunity> queriedOpps = queryOpportunitiesByCalendarQuarter(5);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedOpps.size(), 
            'Expected no opportunities to be returned when querying by invalid calendar quarter'
        );
    }

    @IsTest
    static void useNegativeCalendarQuarterWithDates() {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Opportunity> queriedOpps = queryOpportunitiesByCalendarQuarter(-50);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedOpps.size(), 
            'Expected no opportunities to be returned when querying by invalid calendar quarter'
        );
    }

    @IsTest
    static void useInvalidCalendarQuarterWithDatetimes() {
        List<Case> cases = buildTestCases();
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = queryCasesByCalendarQuarter(5);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedCases.size(), 
            'Expected no cases to be returned when querying by invalid calendar quarter'
        );        
    }

    @IsTest
    static void useNegativeCalendarQuarterWithDatetimes() {
        List<Case> cases = buildTestCases();
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = queryCasesByCalendarQuarter(-50);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedCases.size(), 
            'Expected no cases to be returned when querying by invalid calendar quarter'
        );        
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterOne() {
        testHavingUsingDates(1);
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterTwo() {
        testHavingUsingDates(2);
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterThree() {
        testHavingUsingDates(3);
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterFour() {
        testHavingUsingDates(4);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedOne() {
        testHavingUsingDatesUnselected(1);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedTwo() {
        testHavingUsingDatesUnselected(2);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedThree() {
        testHavingUsingDatesUnselected(3);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedFour() {
        testHavingUsingDatesUnselected(4);
    }

    static void testHavingUsingDatesUnselected(Integer targetCalendarQuarter) {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Aggregate> queriedOpportunities = queryOpportunitiesHavingCalendarQuarterUnselected(targetCalendarQuarter);
        Test.stopTest();
        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedOpportunities.size(),
            'Expected ' + targetRecords + ' Aggregates to be returned'
        );
    }

    static void testHavingUsingDates(Integer targetCalendarQuarter) {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Aggregate> queriedOpportunities = queryOpportunitiesHavingCalendarQuarter(targetCalendarQuarter);
        Test.stopTest();
        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedOpportunities.size(),
            'Expected ' + targetRecords + ' Aggregates to be returned'
        );
    }

    static void testUsingDates(Integer targetCalendarQuarter) {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Opportunity> queriedOpportunities = queryOpportunitiesByCalendarQuarter(targetCalendarQuarter);
        Test.stopTest();

        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedOpportunities.size(),
            'Expected case to be queried'
        );
    }

    static List<Opportunity> buildTestOpportunities() {
        List<Opportunity> opps = new List<Opportunity>();
        opps.addAll(createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(1), 1));
        opps.addAll(createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(2), 2));
        opps.addAll(createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(3), 3));
        opps.addAll(createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(4), 4));
        return opps;
    }

    static List<Aggregate> queryOpportunitiesHavingCalendarQuarter(Integer targetCalendarQuarter) {
        Map<String, Object> binds = new Map<String, Object> {
            'targetCalendarQuarter' => targetCalendarQuarter
        };
        return Selector.aggregateQueryWithBinds(
            'SELECT Name, CALENDAR_QUARTER(CloseDate)' +
            ' FROM Opportunity' +
            ' GROUP BY Name, CloseDate' +
            ' HAVING CALENDAR_QUARTER(CloseDate) = :targetCalendarQuarter', 
            binds, 
            AccessLevel.SYSTEM_MODE
        );
    }

    static List<Aggregate> queryOpportunitiesHavingCalendarQuarterUnselected(Integer targetCalendarQuarter) {
        Map<String, Object> binds = new Map<String, Object> {
            'targetCalendarQuarter' => targetCalendarQuarter
        };
        // the difference here is that CALENDAR_QUARTER(CloseDate) is not in the SELECT clause,
        // but this is a valid query that should return the same result, except with the CloseDate selected
        return Selector.aggregateQueryWithBinds(
            'SELECT Name, CloseDate' +
            ' FROM Opportunity' +
            ' GROUP BY Name, CloseDate' +
            ' HAVING CALENDAR_QUARTER(CloseDate) = :targetCalendarQuarter', 
            binds, 
            AccessLevel.SYSTEM_MODE
        );
    }

    static List<Opportunity> queryOpportunitiesByCalendarQuarter(Integer targetCalendarQuarter) {
        Map<String, Object> binds = new Map<String, Object> {
            'targetCalendarQuarter' => targetCalendarQuarter
        };
        return Selector.queryWithBinds(
            'SELECT Id ' +
            ' FROM Opportunity' +
            ' WHERE CALENDAR_QUARTER(CloseDate) = :targetCalendarQuarter',
            binds,
            AccessLevel.SYSTEM_MODE 
        );
    }

    static void testUsingDateTimes(Integer targetCalendarQuarter) {
        List<Case> cases = buildTestCases();
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = queryCasesByCalendarQuarter(targetCalendarQuarter);
        Test.stopTest();

        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedCases.size(),
            'Expected case to be queried'
        );
    }

    static List<Case> buildTestCases() {
        List<Case> cases = new List<Case>(); 
        cases.addAll(createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(1), 1));
        cases.addAll(createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(2), 2));
        cases.addAll(createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(3), 3));
        cases.addAll(createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(4), 4));
        return cases;
    }

    static List<Case> queryCasesByCalendarQuarter(Integer calendarQuarter) {
        Map<String, Object> binds = new Map<String, Object> {
            'targetCalendarQuarter' => calendarQuarter
        };
        return Selector.queryWithBinds(
            'SELECT Id ' +
            ' FROM Case' +
            ' WHERE CALENDAR_QUARTER(ClosedDate) = :targetCalendarQuarter',
            binds,
            AccessLevel.SYSTEM_MODE 
        );
    }

    static List<Case> createCasesInCalendarQuarter(Integer numberOfCases, Integer calendarQuarter) {
        List<Integer> calendarQuarters = new List<Integer> { 1, 2, 3, 4};
        if(!calendarQuarters.contains(calendarQuarter)) {
            throw new IllegalArgumentException('Invalid calendar quarter');
        }
        List<Case> cases = new List<Case>();
        Integer month = calendarQuarter * 3 - 1;
        for(Integer i = 0; i < numberOfCases; i++) {
            Case newCase = (Case) Common.putReadOnlyField(
                new Case(), 
                'ClosedDate', 
                DateTime.newInstance(YEAR, month, DAY, 0, 0, 0)
            );
            cases.add(newCase);
        }
        return cases;        
    }

    static List<Opportunity> createOpportunitiesInCalendarQuarter(Integer numberOfOpps, Integer calendarQuarter) {
        List<Integer> calendarQuarters = new List<Integer> { 1, 2, 3, 4};
        if(!calendarQuarters.contains(calendarQuarter)) {
            throw new IllegalArgumentException('Invalid calendar quarter');
        }
        List<Opportunity> opportunities = new List<Opportunity>();
        Integer month = calendarQuarter * 3 - 1;
        for(Integer i = 0; i < numberOfOpps; i++) {
            Opportunity newOpp = new Opportunity(
                Name = 'Test Opportunity ' + String.valueOf(Math.random()).left(8),
                CloseDate = Date.newInstance(YEAR, month, DAY)
            );
            opportunities.add(newOpp);
        }
        return opportunities;
    }
}