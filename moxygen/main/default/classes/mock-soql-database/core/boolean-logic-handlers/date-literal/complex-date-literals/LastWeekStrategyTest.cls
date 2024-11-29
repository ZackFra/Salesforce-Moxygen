@isTest
private class LastWeekStrategyTest {

    @IsTest
    static void ensureLastWeekStrategyWorksWithDate() {
        LastWeekStrategy strategy = new LastWeekStrategy();
        Test.startTest();
        DateLiteral dl = strategy.resolve(Schema.DisplayType.DATE, GMT.today().addDays(-7));
        Test.stopTest();

        String expectedFieldValue = Common.dateToSoqlString(GMT.today().addDays(-7).toStartOfWeek());
        String fieldValue = dl.getFieldValue();
        Assert.areEqual(expectedFieldValue, fieldValue, 'Record field value should be start of this week');
        Assert.isFalse(dl.hasNewRecordFieldValue(), 'Has new record field value should be false');
    }

    @IsTest
    static void ensureLastWeekStrategyWorksWithDateTime() {
        LastWeekStrategy strategy = new LastWeekStrategy();
        Test.startTest();
        DateLiteral dl = strategy.resolve(Schema.DisplayType.DATETIME, GMT.now().addDays(-7));
        Test.stopTest();

        String expectedFieldValue = Common.dateToSoqlString(GMT.today().addDays(-7).toStartOfWeek());
        String fieldValue = dl.getFieldValue();
        Assert.areEqual(expectedFieldValue, fieldValue, 'Record field value should be start of this week');
        Assert.isTrue(dl.hasNewRecordFieldValue(), 'Has new record field value should be true');
    }
}