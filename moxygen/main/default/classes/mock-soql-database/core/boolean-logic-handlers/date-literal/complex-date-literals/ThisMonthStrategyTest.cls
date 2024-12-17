@isTest
private class ThisMonthStrategyTest {

    @IsTest
    static void ensureStrategyWorksWithDate() {
        ThisMonthStrategy strategy = new ThisMonthStrategy();
        Date dt = Gmt.today().toStartOfMonth();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(dt, Gmt.today(), strategy), 
            'This week strategy should return start of this week for date'
        );
    }

    @IsTest
    static void ensureStrategyWorksWithDateTime() {
        ThisMonthStrategy strategy = new ThisMonthStrategy();
        Date dt = Gmt.today().toStartOfMonth();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(dt, GMT.now(), strategy), 
            'This week strategy should return start of this week for date time'
        );
    }
}