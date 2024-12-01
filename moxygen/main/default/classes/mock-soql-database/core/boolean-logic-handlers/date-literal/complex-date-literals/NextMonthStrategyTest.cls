@isTest
private class NextMonthStrategyTest {

    @IsTest
    static void ensureStrategyWorksWithDate() {
        NextMonthStrategy strategy = new NextMonthStrategy();
        Date dt = Gmt.today().addMonths(1).toStartOfMonth();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(dt, Gmt.today(), strategy), 
            'This week strategy should return start of this week for date'
        );
    }

    @IsTest
    static void ensureStrategyWorksWithDateTime() {
        NextMonthStrategy strategy = new NextMonthStrategy();
        Date dt = Gmt.today().addMonths(1).toStartOfMonth();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(dt, GMT.now(), strategy), 
            'This week strategy should return start of this week for date time'
        );
    }
}