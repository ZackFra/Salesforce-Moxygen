/**
 * @description Unit tests for SOQL date functions
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
@IsTest
private class DateFuncTest {
    @IsTest
    static void testDayAndWeekFunctions() {
        Date monday = Date.newInstance(2024, 1, 1);
        Date saturday = Date.newInstance(2024, 1, 6);
        Date sunday = Date.newInstance(2024, 1, 7);
        Date marchFirst = Date.newInstance(2024, 3, 1);
        Datetime mondayEvening = Datetime.newInstanceGmt(2024, 1, 1, 23, 15, 0);

        Assert.areEqual(1, new DayInMonthFunc().calculate(monday));
        Assert.areEqual(2, new DayInWeekFunc().calculate(monday));
        Assert.areEqual(7, new DayInWeekFunc().calculate(saturday));
        Assert.areEqual(1, new DayInWeekFunc().calculate(sunday));
        Assert.areEqual(61, new DayInYearFunc().calculate(marchFirst));
        Assert.areEqual(1, new WeekInMonthFunc().calculate(saturday));
        Assert.areEqual(2, new WeekInMonthFunc().calculate(sunday));
        Assert.areEqual(1, new WeekInYearFunc().calculate(monday));
        Assert.areEqual(2, new WeekInYearFunc().calculate(sunday));
        Assert.areEqual(
            53,
            new WeekInYearFunc().calculate(Date.newInstance(2024, 12, 31))
        );
        Assert.areEqual(monday, new DayOnlyFunc().calculate(mondayEvening));
        Assert.areEqual(
            15,
            new HourInDayFunc()
                .calculate(Datetime.newInstanceGmt(2024, 5, 9, 15, 30, 0))
        );
        Assert.areEqual(0, new HourInDayFunc().calculate(monday));
    }

    @IsTest
    static void testNullAndInvalidValues() {
        Assert.isNull(new DayInMonthFunc().calculate(null));
        Assert.isNull(new DayOnlyFunc().calculate(null));
        Assert.isNull(new HourInDayFunc().calculate(null));

        Boolean threw = false;
        try {
            new DayInYearFunc().calculate('not a date');
        } catch (QueryException e) {
            threw = true;
        }
        Assert.isTrue(threw, 'Expected a query exception for a non-date value');
    }

    @IsTest
    static void testFiscalFunctionsFollowStandardFiscalYear() {
        Integer startMonth = OrganizationSingleton.getInstance()
            .FiscalYearStartMonth;
        List<Date> samples = new List<Date>{
            Date.newInstance(2024, 1, 15),
            Date.newInstance(2024, 8, 2)
        };

        for (Date sample : samples) {
            Integer monthsFromStart = sample.month() - startMonth;
            if (monthsFromStart < 0) {
                monthsFromStart += 12;
            }
            Integer expectedMonth = monthsFromStart + 1;
            Integer expectedQuarter = ((expectedMonth - 1) / 3) + 1;
            Integer expectedYear = sample.month() >= startMonth
                ? (startMonth == 1 ? sample.year() : sample.year() + 1)
                : sample.year();

            Assert.areEqual(
                expectedMonth,
                new FiscalMonthFunc().calculate(sample)
            );
            Assert.areEqual(
                expectedQuarter,
                new FiscalQuarterFunc().calculate(sample)
            );
            Assert.areEqual(
                expectedYear,
                new FiscalYearFunc().calculate(sample)
            );
        }
    }
}
