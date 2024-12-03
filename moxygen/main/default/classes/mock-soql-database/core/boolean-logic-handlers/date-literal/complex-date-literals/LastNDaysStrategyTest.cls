@isTest
private class LastNDaysStrategyTest {

    @IsTest
    static void ensureStrategyWorksWithDate() {
        Date expectedDate = GMT.today().addDays(-8);
        Date testDate = GMT.today().addDays(-8);
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldValue('last_n_days:7')
            .setFieldType(Schema.DisplayType.Date)
            .setRecordFieldValue(null)
            .build();

        ComplexDateLiteralStrategy strategy = new LastNDaysStrategy()
            .setOptions(options);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(expectedDate, testDate, strategy),
            'Last week strategy should return start of last week for date'
        );
    }

    @IsTest
    static void ensureStrategyWorksWithDateTime() {
        Date expectedDate = GMT.today().addDays(-8);
        DateTime testDateTime = GMT.now().addDays(-8);
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldValue('last_n_days:7')
            .setFieldType(Schema.DisplayType.DateTime)
            .setRecordFieldValue(testDateTime)
            .build();
        ComplexDateLiteralStrategy strategy = new LastNDaysStrategy()
            .setOptions(options);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(expectedDate, testDateTime, strategy),
            'Last week strategy should return start of last week for date time'
        );
    }
}