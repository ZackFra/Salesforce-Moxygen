@IsTest
public class DateLiteralStrategyTestUtils {

    public static Boolean isSuccessForDate(Date expectedDate, Date testDate, IComplexDateLiteralStrategy strategy) {
        String expected = Common.dateToSoqlString(expectedDate);
        String dAsSoqlStr = Common.dateToSoqlString(testDate);

        Test.startTest();
        DateLiteral result = strategy.resolve(Schema.DisplayType.DATE, testDate);
        Test.stopTest();

        Assert.areEqual(expected, result.getFieldValue(), 'Field value should match next week');
        Assert.isFalse(result.hasNewRecordFieldValue(), 'New record field value should be null');
        return true;
    }

    public static Boolean isSuccessForDateTime(Date expectedDate, DateTime dt, IComplexDateLiteralStrategy strategy) {
        String expected = Common.dateToSoqlString(expectedDate);
        String dtAsSoqlStr = Common.dateToSoqlString(Gmt.date(dt));

        Test.startTest();
        DateLiteral result = strategy.resolve(Schema.DisplayType.DATETIME, dt);
        Test.stopTest();

        Assert.areEqual(expected, result.getFieldValue(), 'Field value should be next week');
        Assert.isTrue(result.hasNewRecordFieldValue(), 'New record field value should not be null');

        return true;
    }
}