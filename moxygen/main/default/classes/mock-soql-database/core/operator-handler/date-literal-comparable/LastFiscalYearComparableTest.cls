@isTest
private class LastFiscalYearComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable comparable = new LastFiscalYearComparable();
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfLastFiscalYear = startOfThisFiscalYear.addYears(-1);
        Date startOfFiscalYearBeforeThat = startOfLastFiscalYear.addYears(-1);
        Assert.isTrue(
            comparable.isLessThan(startOfFiscalYearBeforeThat),
            'Should be less than'
        );
        Assert.isFalse(
            comparable.isLessThan(startOfLastFiscalYear),
            'Should not be less than'
        );
        Assert.isFalse(
            comparable.isLessThan(startOfThisFiscalYear),
            'Should not be less than'
        );
    }

    @isTest
    static void ensureIsGreaterThan() {
        DateLiteralComparable comparable = new LastFiscalYearComparable();
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        Date startOfLastFiscalYear = startOfThisFiscalYear.addYears(-1);
        Date startOfFiscalYearBeforeThat = startOfLastFiscalYear.addYears(-1);
        Assert.isFalse(
            comparable.isGreaterThan(startOfFiscalYearBeforeThat),
            'Should not be greater than'
        );
        Assert.isFalse(
            comparable.isGreaterThan(startOfLastFiscalYear),
            'Should not be greater than'
        );
        Assert.isTrue(
            comparable.isGreaterThan(startOfThisFiscalYear),
            'Should not be greater than'
        );
        Assert.isTrue(
            comparable.isGreaterThan(startOfNextFiscalYear),
            'Should be greater than'
        );
    }
}
