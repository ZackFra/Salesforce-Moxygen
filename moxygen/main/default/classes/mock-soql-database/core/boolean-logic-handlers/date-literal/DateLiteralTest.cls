@isTest
private class DateLiteralTest {

    @isTest
    static void ensureLastWeekWorksCorrectlyWithDate() {
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldType(Schema.DisplayType.DATE)
            .setFieldValue(Token.LAST_WEEK_LITERAL)
            .build();
        
        Test.startTest();
        DateLiteral dl = DateLiteral.resolve(options);
        Test.stopTest();

        String fieldValue = dl.getFieldValue();

        String startOfLastWeek = Common.dateToSoqlString(GMT.today().addDays(-7).toStartOfWeek());
        Assert.areEqual(startOfLastWeek, fieldValue, 'Record field value should be start of last week');
        Assert.isFalse(dl.hasNewRecordFieldValue(), 'Has new record field value should be false');
    }

    @isTest
    static void ensureLastWeekWorksCorrectlyWithDateTime() {
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldType(Schema.DisplayType.DATETIME)
            .setFieldValue(Token.LAST_WEEK_LITERAL)
            .setRecordFieldValue(GMT.now())
            .build();
        
        Test.startTest();
        DateLiteral dl = DateLiteral.resolve(options);
        Test.stopTest();

        String fieldValue = dl.getFieldValue();

        String startOfLastWeek = Common.dateToSoqlString(GMT.today().addDays(-7).toStartOfWeek());
        Assert.areEqual(startOfLastWeek, fieldValue, 'Record field value should be start of last week');
        Assert.isTrue(dl.hasNewRecordFieldValue(), 'Has new record field value should be true');
    }
}