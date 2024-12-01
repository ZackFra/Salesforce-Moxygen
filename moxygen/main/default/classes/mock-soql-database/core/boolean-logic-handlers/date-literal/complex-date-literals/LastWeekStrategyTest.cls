@isTest
private class LastWeekStrategyTest {

    @IsTest
    static void ensureLastWeekStrategyWorksWithDate() {
        LastWeekStrategy strategy = new LastWeekStrategy();
        Date expectedDate = GMT.today().addDays(-7).toStartOfWeek();
        Date testDate = GMT.today().addDays(-7);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(expectedDate, testDate, strategy),
            'Last week strategy should return start of last week for date'
        );
    }

    @IsTest
    static void ensureLastWeekStrategyWorksWithDateTime() {
        LastWeekStrategy strategy = new LastWeekStrategy();
        Date expectedDate = GMT.today().addDays(-7).toStartOfWeek();
        DateTime testDateTime = GMT.now().addDays(-7);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(expectedDate, testDateTime, strategy),
            'Last week strategy should return start of last week for date time'
        );
    }
}