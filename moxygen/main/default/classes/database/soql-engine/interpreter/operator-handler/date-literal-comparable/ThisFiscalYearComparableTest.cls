@isTest
private class ThisFiscalYearComparableTest {
    @IsTest
    static void ensureIsLessThanWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        Date dateBeforeThisFiscalYear = startOfThisFiscalYear.addDays(-1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isTrue(
            thisFiscalYearComparable.isLessThan(dateBeforeThisFiscalYear),
            'End of this fiscal year should be greater'
        );
        Assert.isFalse(
            thisFiscalYearComparable.isLessThan(startOfThisFiscalYear),
            'Start of this fiscal year should not be less'
        );
        Assert.isFalse(
            thisFiscalYearComparable.isLessThan(startOfNextFiscalYear),
            'Start of next fiscal year should not be less'
        );
    }

    @IsTest
    static void ensureIsGreaterThanWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date endOfThisFiscalYear = startOfThisFiscalYear.addYears(1)
            .addDays(-1);
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isFalse(
            thisFiscalYearComparable.isGreaterThan(startOfThisFiscalYear),
            'Start of this fiscal year should be less'
        );
        Assert.isFalse(
            thisFiscalYearComparable.isGreaterThan(endOfThisFiscalYear),
            'End of this fiscal year should not be greater'
        );
        Assert.isTrue(
            thisFiscalYearComparable.isGreaterThan(startOfNextFiscalYear),
            'Start of next fiscal year should not be greater'
        );
    }
}
