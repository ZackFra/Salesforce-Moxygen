@isTest
private class NDaysAgoStrategyTest {

    @isTest
    static void ensureStrategyWorksWithDateAndDateTime() {
        Assert.isTrue(
            ComplexDateLiteralStrategyTestUtil.ensureStrategyWorksWithDatesAndDateTimes(new NDaysAgoStrategy(), 'n_days_ago'),
            'Strategy should work with date and date time'
        );
    }
}