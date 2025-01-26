@isTest
private class LastNFiscalYearsComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastNFiscalYearsComparable = new LastNFiscalYearsComparable()
            .withToken('LAST_N_FISCAL_YEARS:5');

        Assert.isFalse(
            lastNFiscalYearsComparable.isLessThan(Gmt.startOfThisFiscalYear()),
            'Should not be less than'
        );
        Assert.isFalse(
            lastNFiscalYearsComparable.isLessThan(
                Gmt.startOfThisFiscalYear().addYears(-5)
            ),
            'Should not be less than'
        );
        Assert.isTrue(
            lastNFiscalYearsComparable.isLessThan(
                Gmt.startOfThisFiscalYear().addYears(-6)
            ),
            'Should be less than'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastNFiscalYearsComparable = new LastNFiscalYearsComparable()
            .withToken('LAST_N_FISCAL_YEARS:5');

        Assert.isTrue(
            lastNFiscalYearsComparable.isGreaterThan(
                Gmt.startOfThisFiscalYear()
            ),
            'Should be greater than'
        );
        Assert.isFalse(
            lastNFiscalYearsComparable.isGreaterThan(
                Gmt.startOfThisFiscalYear().addYears(-5)
            ),
            'Should not be greater than'
        );
        Assert.isFalse(
            lastNFiscalYearsComparable.isGreaterThan(
                Gmt.startOfThisFiscalYear().addYears(-6)
            ),
            'Should not be greater than'
        );
    }
}
