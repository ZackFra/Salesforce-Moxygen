@isTest
private class Next90DaysStrategyTest {
    @IsTest
    static void ensureStrategyWorksWithDate() {
        Next90DaysStrategy strategy = new Next90DaysStrategy();
        Date dt = Gmt.today().addDays(90);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(dt, Gmt.today(), strategy), 
            'This week strategy should return start of this week for date'
        );
    }

    @IsTest
    static void ensureStrategyWorksWithDateTime() {
        Next90DaysStrategy strategy = new Next90DaysStrategy();
        Date dt = Gmt.today().addDays(90);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(dt, GMT.now(), strategy), 
            'This week strategy should return start of this week for date time'
        );
    }
}