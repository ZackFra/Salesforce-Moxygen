@isTest
private class NextNFiscalYearsComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNFiscalYearsComparable = new NextNFiscalYearsComparable()
            .withToken('NEXT_N_FISCAL_YEARS:1');

        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        Date startOfFiscalYearAfterNext = startOfNextFiscalYear.addYears(1);

        Assert.isTrue(
            nextNFiscalYearsComparable.isLessThan(startOfThisFiscalYear),
            'Should be less than'
        );
        Assert.isFalse(
            nextNFiscalYearsComparable.isLessThan(startOfNextFiscalYear),
            'Should not be less than'
        );
        Assert.isFalse(
            nextNFiscalYearsComparable.isLessThan(startOfFiscalYearAfterNext),
            'Should not be less than'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNFiscalYearsComparable = new NextNFiscalYearsComparable()
            .withToken('NEXT_N_FISCAL_YEARS:1');

        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        Date startOfFiscalYearAfterNext = startOfNextFiscalYear.addYears(1);

        Assert.isFalse(
            nextNFiscalYearsComparable.isGreaterThan(startOfThisFiscalYear),
            'Should not be greater than'
        );
        Assert.isFalse(
            nextNFiscalYearsComparable.isGreaterThan(startOfNextFiscalYear),
            'Should not be greater than'
        );
        Assert.isTrue(
            nextNFiscalYearsComparable.isGreaterThan(
                startOfFiscalYearAfterNext
            ),
            'Should be greater than'
        );
    }
}
