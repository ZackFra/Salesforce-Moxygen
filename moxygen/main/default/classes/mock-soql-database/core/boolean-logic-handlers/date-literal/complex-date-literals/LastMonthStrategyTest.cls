@isTest
private class LastMonthStrategyTest {
    @IsTest
    static void ensureLastMonthStrategyWorksWithDate() {
        LastMonthStrategy strategy = new LastMonthStrategy();
        Date expectedDate = Gmt.today().addMonths(-1).toStartOfMonth();
        Date testDate = Gmt.today().addMonths(-1);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(expectedDate, testDate, strategy),
            'Last week strategy should return start of last week for date'
        );
    }

    @IsTest
    static void ensureLastMonthStrategyWorksWithDateTime() {
        LastMonthStrategy strategy = new LastMonthStrategy();
        Date expectedDate = Gmt.today().addMonths(-1).toStartOfMonth();
        DateTime testDateTime = Gmt.now().addMonths(-1);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(expectedDate, testDateTime, strategy),
            'Last week strategy should return start of last week for date time'
        );
    }
}