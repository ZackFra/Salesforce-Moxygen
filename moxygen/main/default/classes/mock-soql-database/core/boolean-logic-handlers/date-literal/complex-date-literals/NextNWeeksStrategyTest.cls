@isTest
private class NextNWeeksStrategyTest {

    @isTest
    static void ensureStrategyWorksWithDateAndDateTime() {
        Date startDate = GMT.today().toStartOfWeek();
        Assert.isTrue(
            ComplexDateLiteralStrategyTestUtil.ensureStrategyWorksWithDatesAndDateTimes(new NextNWeeksStrategy(), startDate, 'next_n_weeks'),
            'Strategy should work with date and date time'
        );
    }
}