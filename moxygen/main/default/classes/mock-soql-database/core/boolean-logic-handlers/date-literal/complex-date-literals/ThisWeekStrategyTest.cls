@IsTest
private class ThisWeekStrategyTest {
    @IsTest
    static void ensureThisWeekStrategyWorksWithDate() {
        ThisWeekStrategy strategy = new ThisWeekStrategy();
        Date thisWeek = Gmt.today().toStartOfWeek();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(thisWeek, Gmt.today(), strategy), 
            'This week strategy should return start of this week for date'
        );
    }

    @IsTest
    static void ensureThisWeekStrategyWorksWithDateTime() {
        ThisWeekStrategy strategy = new ThisWeekStrategy();
        Date thisWeek = Gmt.today().toStartOfWeek();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(thisWeek, GMT.now(), strategy), 
            'This week strategy should return start of this week for date time'
        );
    }
}