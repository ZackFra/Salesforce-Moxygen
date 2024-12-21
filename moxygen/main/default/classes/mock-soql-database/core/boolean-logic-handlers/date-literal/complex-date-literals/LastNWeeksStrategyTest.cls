@isTest
public with sharing class LastNWeeksStrategyTest {
    @isTest
    static void ensureStrategyWorksWithDateAndDateTime() {
        Assert.isTrue(
            ComplexDateLiteralStrategyTestUtil.ensureStrategyWorksWithDatesAndDateTimes(new LastNWeeksStrategy(), 'last_n_weeks'),
            'Strategy should work with date and date time'
        );
    }
}