/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class LastNDaysStrategyTest {

    @IsTest
    static void ensureStrategyWorksWithDate() {
        Date expectedDate = GMT.today().addDays(-7);
        Date testDate = GMT.today().addDays(-7);
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
        Date expectedDate = GMT.today().addDays(-7);
        DateTime testDateTime = GMT.now().addDays(-7);
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