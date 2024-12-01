@IsTest
public class DateLiteralStrategyTestUtils {

    /**
     * @description Asserts that the strategy is successful for the given date
     * @param expectedDate `Date`
     * @param testDate `Date`
     * @param strategy `ComplexDateLiteralStrategy`
     * @return  `Boolean`
     */
    public static Boolean isSuccessForDate(Date expectedDate, Date testDate, ComplexDateLiteralStrategy strategy) {
        String expected = Common.dateToSoqlString(expectedDate);
        String dAsSoqlStr = Common.dateToSoqlString(testDate);

        Test.startTest();
        DateLiteral result = strategy.resolve(Schema.DisplayType.DATE, testDate);
        Test.stopTest();

        Assert.areEqual(expected, result.getFieldValue(), 'Field value should match next week');
        Assert.isFalse(result.hasNewRecordFieldValue(), 'New record field value should be null');
        return true;
    }

    /**
     * @description Asserts that the strategy is successful for the given date time
     * @param expectedDate `Date`
     * @param dt `Datetime`
     * @param strategy `ComplexDateLiteralStrategy` 
     * @return  `Boolean`
     */
    public static Boolean isSuccessForDateTime(Date expectedDate, DateTime dt, ComplexDateLiteralStrategy strategy) {
        String expected = Common.dateToSoqlString(expectedDate);

        Test.startTest();
        DateLiteral result = strategy.resolve(Schema.DisplayType.DATETIME, dt);
        Test.stopTest();

        Assert.areEqual(expected, result.getFieldValue(), 'Field value should be next week');
        Assert.isTrue(result.hasNewRecordFieldValue(), 'New record field value should not be null');

        return true;
    }
}