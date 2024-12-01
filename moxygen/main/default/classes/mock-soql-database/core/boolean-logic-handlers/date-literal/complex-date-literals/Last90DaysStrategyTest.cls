@isTest
private class Last90DaysStrategyTest {

    @IsTest
    static void ensureStrategyWorksWithDate() {
        Last90DaysStrategy strategy = new Last90DaysStrategy();
        Date dt = Gmt.today().addDays(-90);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(dt, Gmt.today(), strategy), 
            'This week strategy should return start of this week for date'
        );
    }

    @IsTest
    static void ensureStrategyWorksWithDateTime() {
        Last90DaysStrategy strategy = new Last90DaysStrategy();
        Date dt = Gmt.today().addDays(-90);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(dt, GMT.now(), strategy), 
            'This week strategy should return start of this week for date time'
        );
    }
}