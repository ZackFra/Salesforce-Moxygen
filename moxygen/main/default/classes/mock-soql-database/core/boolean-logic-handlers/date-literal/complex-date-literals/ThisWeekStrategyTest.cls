@IsTest
private class ThisWeekStrategyTest {
    @IsTest
    static void ensureThisWeekStrategyWorksWithDate() {
        ThisWeekStrategy strategy = new ThisWeekStrategy();
        Test.startTest();
        DateLiteral dl = strategy.resolve(Schema.DisplayType.DATE, GMT.today());
        Test.stopTest();

        String expectedFieldValue = Common.dateToSoqlString(GMT.today().toStartOfWeek());
        String fieldValue = dl.getFieldValue();
        Assert.areEqual(expectedFieldValue, fieldValue, 'Record field value should be start of this week');
        Assert.isFalse(dl.hasNewRecordFieldValue(), 'Has new record field value should be false');
    }

    @IsTest
    static void ensureThisWeekStrategyWorksWithDateTime() {
        ThisWeekStrategy strategy = new ThisWeekStrategy();
        Test.startTest();
        DateLiteral dl = strategy.resolve(Schema.DisplayType.DATETIME, GMT.now());
        Test.stopTest();

        String expectedFieldValue = Common.dateToSoqlString(GMT.today().toStartOfWeek());
        String fieldValue = dl.getFieldValue();
        Assert.areEqual(expectedFieldValue, fieldValue, 'Record field value should be start of this week');
        Assert.isTrue(dl.hasNewRecordFieldValue(), 'Has new record field value should be true');
    }
}