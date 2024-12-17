@isTest
public inherited sharing class ComplexDateLiteralStrategyTestUtil {
    /**
     * @description Ensures a complex date literal strategy works for a generic date value
     * @param strategy `ComplexDateLiteralStrategy`
     * @param startDate `Date`
     * @param tkn `String`
     * @return  `Boolean`
     */
    private static Boolean ensureStrategyWorksWithDate(ComplexDateLiteralStrategy strategy, Date startDate, String tkn) {
        Integer days = 5;
        IDateFormula dateFormula = strategy.getDateFormula();
        Date expectedDate = startDate.addDays(dateFormula.apply(days));
        Date testDate = GMT.today().addDays(days);
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldValue(tkn + ':' + days)
            .setFieldType(Schema.DisplayType.Date)
            .setRecordFieldValue(null)
            .build();
        strategy.setOptions(options);

        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDate(expectedDate, testDate, strategy),
            'Last week strategy should return start of last week for date'
        );
        return true;
    }

    /**
     * @description Ensures a complex date literal strategy works for a generic date time value
     * @param strategy `ComplexDateLiteralStrategy`
     * @param startDate `Date`
     * @param tkn `String`
     * @return  `Boolean`
     */
    private static Boolean ensureStrategyWorksWithDateTime(ComplexDateLiteralStrategy strategy, Date startDate, String tkn) {
        Integer days = 5;
        IDateFormula dateFormula = strategy.getDateFormula();
        Date expectedDate = startDate.addDays(dateFormula.apply(days));
        DateTime testDateTime = GMT.now().addDays(days);
        DateLiteralOptions options = new DateLiteralOptions.Builder()
            .setFieldValue(tkn + ':' + days)
            .setFieldType(Schema.DisplayType.DateTime)
            .setRecordFieldValue(testDateTime)
            .build();
        strategy.setOptions(options);
        Assert.isTrue(
            DateLiteralStrategyTestUtils.isSuccessForDateTime(expectedDate, testDateTime, strategy),
            'Last week strategy should return start of last week for date time'
        );
        return true;
    }

    /**
     * @description Ensures a complex date literal strategy works for both date and date time values
     * @param strategy `ComplexDateLiteralStrategy`
     * @param tkn `String`
     * @return  `Boolean`
     */
    public static Boolean ensureStrategyWorksWithDatesAndDateTimes(ComplexDateLiteralStrategy strategy, String tkn) {
        Date startDate = GMT.today();
        return ensureStrategyWorksWithDatesAndDateTimes(strategy, startDate, tkn);
    }

    /**
     * @description Ensurve a complex date literal strategy works for both date and date time values, using a start date for the expected value
     * @param strategy `ComplexDateLiteralStrategy`
     * @param startDate `Date`
     * @param tkn `String`
     * @return  `Boolean`
     */
    public static Boolean ensureStrategyWorksWithDatesAndDateTimes(ComplexDateLiteralStrategy strategy, Date startDate, String tkn) {
        return ensureStrategyWorksWithDate(strategy, startDate, tkn) && ensureStrategyWorksWithDateTime(strategy, startDate, tkn);
    }
}