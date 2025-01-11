@isTest
private class NextFiscalYearComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextFiscalYearComparable = new NextFiscalYearComparable()
            .withToken('NEXT_FISCAL_YEAR');

        Assert.isTrue(
            nextFiscalYearComparable.isLessThan(Gmt.startOfThisFiscalYear()),
            'Should be less than'
        );
        Assert.isFalse(
            nextFiscalYearComparable.isLessThan(
                Gmt.startOfThisFiscalYear().addYears(1)
            ),
            'Should not be less than'
        );
        Assert.isFalse(
            nextFiscalYearComparable.isLessThan(
                Gmt.startOfThisFiscalYear().addYears(2)
            ),
            'Should not be less than'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextFiscalYearComparable = new NextFiscalYearComparable()
            .withToken('NEXT_FISCAL_YEAR');

        Assert.isFalse(
            nextFiscalYearComparable.isGreaterThan(Gmt.startOfThisFiscalYear()),
            'Should not be greater than'
        );
        Assert.isFalse(
            nextFiscalYearComparable.isGreaterThan(
                Gmt.startOfThisFiscalYear().addYears(1)
            ),
            'Should not be greater than'
        );
        Assert.isTrue(
            nextFiscalYearComparable.isGreaterThan(
                Gmt.startOfThisFiscalYear().addYears(2)
            ),
            'Should be greater than'
        );
    }
}
