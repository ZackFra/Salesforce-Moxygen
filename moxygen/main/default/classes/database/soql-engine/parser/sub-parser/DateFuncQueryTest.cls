/**
 * @description Query tests for the newly supported date functions, date literals, and ignored UPDATE clauses
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
@IsTest
private class DateFuncQueryTest {
    @IsTest
    static void testDayInMonthFiltersCloseDate() {
        MockDatabase.doInsert(
            new List<Opportunity>{
                new Opportunity(
                    Name = 'Match',
                    CloseDate = Date.newInstance(2024, 5, 15)
                ),
                new Opportunity(
                    Name = 'Miss',
                    CloseDate = Date.newInstance(2024, 5, 16)
                )
            },
            true
        );

        List<Opportunity> matches = (List<Opportunity>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE DAY_IN_MONTH(CloseDate) = :day',
            new Map<String, Object>{ 'day' => 15 },
            AccessLevel.SYSTEM_MODE
        );

        Assert.areEqual(1, matches.size(), 'Expected the 15th to match');
        Assert.areEqual('Match', matches[0].Name);
    }

    @IsTest
    static void testDayOnlyAndHourInDayUseGmt() {
        MockDatabase.doInsert(new Account(Name = 'Today'), true);
        String today = soqlDate(Gmt.today());

        List<Account> matches = (List<Account>) MockDatabase.query(
            'SELECT Name FROM Account WHERE DAY_ONLY(CreatedDate) = ' + today
        );
        Assert.areEqual(
            1,
            matches.size(),
            'Expected DAY_ONLY to match today in GMT'
        );

        List<Aggregate> hours = MockDatabase.aggregateQuery(
            'SELECT HOUR_IN_DAY(CreatedDate) FROM Account GROUP BY HOUR_IN_DAY(CreatedDate)'
        );
        Assert.areEqual(Gmt.now().hourGmt(), hours[0].get('expr0'));
    }

    @IsTest
    static void testHavingDayInWeek() {
        MockDatabase.doInsert(
            new List<Opportunity>{
                new Opportunity(
                    Name = 'Sunday',
                    CloseDate = Date.newInstance(2024, 1, 7)
                ),
                new Opportunity(
                    Name = 'Monday',
                    CloseDate = Date.newInstance(2024, 1, 8)
                )
            },
            true
        );

        List<Aggregate> sunday = MockDatabase.aggregateQueryWithBinds(
            'SELECT Name, CloseDate FROM Opportunity GROUP BY Name, CloseDate HAVING DAY_IN_WEEK(CloseDate) = :day',
            new Map<String, Object>{ 'day' => 1 },
            AccessLevel.SYSTEM_MODE
        );

        Assert.areEqual(1, sunday.size(), 'Expected Sunday only');
        Assert.areEqual('Sunday', sunday[0].get('Name'));
    }

    @IsTest
    static void testNextYearAndFiscalQuartersAgo() {
        Date startOfNextYear = Date.newInstance(Date.today().year() + 1, 6, 1);
        Date twoFiscalQuartersAgo = Gmt.startOfthisFiscalQuarter()
            .addMonths(-6);
        MockDatabase.doInsert(
            new List<Opportunity>{
                new Opportunity(Name = 'Next', CloseDate = startOfNextYear),
                new Opportunity(Name = 'Ago', CloseDate = twoFiscalQuartersAgo),
                new Opportunity(Name = 'Now', CloseDate = Date.today())
            },
            true
        );

        List<Opportunity> nextYear = (List<Opportunity>) MockDatabase.query(
            'SELECT Name FROM Opportunity WHERE CloseDate = NEXT_YEAR'
        );
        Assert.areEqual(1, nextYear.size());
        Assert.areEqual('Next', nextYear[0].Name);

        List<Opportunity> ago = (List<Opportunity>) MockDatabase.query(
            'SELECT Name FROM Opportunity WHERE CloseDate = N_FISCAL_QUARTERS_AGO:2'
        );
        Assert.areEqual(1, ago.size());
        Assert.areEqual('Ago', ago[0].Name);
    }

    @IsTest
    static void testUpdateTrackingAndViewStatAreIgnored() {
        MockDatabase.doInsert(new Account(Name = 'Tracked'), true);

        List<Account> tracked = (List<Account>) MockDatabase.query(
            'SELECT Name FROM Account UPDATE TRACKING'
        );
        List<Account> viewed = (List<Account>) MockDatabase.query(
            'SELECT Name FROM Account UPDATE VIEWSTAT'
        );

        Assert.areEqual(1, tracked.size());
        Assert.areEqual(1, viewed.size());
        Assert.areEqual('Tracked', tracked[0].Name);
        Assert.areEqual('Tracked', viewed[0].Name);
    }

    private static String soqlDate(Date value) {
        return value.year() +
            '-' +
            twoDigits(value.month()) +
            '-' +
            twoDigits(value.day());
    }

    private static String twoDigits(Integer value) {
        return value < 10 ? '0' + value : String.valueOf(value);
    }
}
