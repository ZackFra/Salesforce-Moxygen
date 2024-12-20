@isTest
private class NextNDaysStrategyTest {

    @IsTest
    static void ensureStrategyWorksWithDate() {
        Date expectedDate = GMT.today().addDays(7);
        Date testDate = GMT.today().addDays(7);
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldValue('next_n_days:7')
            .setFieldType(Schema.DisplayType.Date)
            .setRecordFieldValue(null)
            .build();

        ComplexDateLiteralStrategy strategy = new NextNDaysStrategy()
            .setOptions(options);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(expectedDate, testDate, strategy),
            'Last week strategy should return start of last week for date'
        );
    }

    @IsTest
    static void ensureStrategyWorksWithDateTime() {
        Date expectedDate = GMT.today().addDays(7);
        DateTime testDateTime = GMT.now().addDays(7);
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldValue('next_n_days:7')
            .setFieldType(Schema.DisplayType.DateTime)
            .setRecordFieldValue(testDateTime)
            .build();
        ComplexDateLiteralStrategy strategy = new NextNDaysStrategy()
            .setOptions(options);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(expectedDate, testDateTime, strategy),
            'Last week strategy should return start of last week for date time'
        );
    }
}