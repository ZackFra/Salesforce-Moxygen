@isTest
private class NMonthsAgoStrategyTest {
    @isTest
    static void ensureStrategyWorksWithDateAndDateTime() {
        Assert.isTrue(
            ComplexDateLiteralStrategyTestUtil.ensureStrategyWorksWithDatesAndDateTimes(new NMonthsAgoStrategy(), 'n_months_ago'),
            'Strategy should work with date and date time'
        );
    }
}