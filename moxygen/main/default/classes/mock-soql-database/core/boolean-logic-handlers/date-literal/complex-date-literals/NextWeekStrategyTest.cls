@isTest
private class NextWeekStrategyTest {

    @isTest
    static void ensureNextWeekStrategyReturnsNextWeekForDate() {
        Date nextWeek = GMT.today().addDays(7).toStartOfWeek();
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(nextWeek, nextWeek, new NextWeekStrategy()),
            'Next week strategy should return next week for date'
        );
    }

    @IsTest
    static void ensureNextWeekStrategyReturnsNextWeekForDateTime() {
        DateTime nextWeek = Gmt.dateTime(Gmt.today().addDays(7).toStartOfWeek());
        Date expectedDate= Gmt.date(nextWeek);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(expectedDate, nextWeek, new NextWeekStrategy()),
            'Next week strategy should return next week for date time'
        );
    }
}