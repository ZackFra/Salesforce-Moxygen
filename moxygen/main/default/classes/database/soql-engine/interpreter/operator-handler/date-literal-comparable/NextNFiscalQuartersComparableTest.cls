@isTest
private class NextNFiscalQuartersComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable dateLiteralComparable = new NextNFiscalQuartersComparable()
            .withToken('next_n_fiscal_quarters:1');
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        Date startOfNextFiscalQuarterMinusOneDay = startOfNextFiscalQuarter.addDays(
            -1
        );
        Assert.isTrue(
            dateLiteralComparable.isLessThan(startOfThisFiscalQuarter),
            'Start of this fiscal quarter should be less than the next fiscal quarter'
        );
        Assert.isFalse(
            dateLiteralComparable.isLessThan(startOfNextFiscalQuarter),
            'Start of next fiscal quarter should not be less than the next fiscal quarter'
        );
        Assert.isTrue(
            dateLiteralComparable.isLessThan(
                startOfNextFiscalQuarterMinusOneDay
            ),
            'Start of next fiscal quarter minus one day should be less than the next fiscal quarter'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable dateLiteralComparable = new NextNFiscalQuartersComparable()
            .withToken('next_n_fiscal_quarters:1');
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        Date startOfFiscalQuarterAfterNext = startOfNextFiscalQuarter.addMonths(
            3
        );
        Date startOfFiscalQuarterAfterNextMinusOneDay = startOfFiscalQuarterAfterNext.addDays(
            -1
        );

        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(startOfThisFiscalQuarter),
            'Start of this fiscal quarter should not be greater than the next fiscal quarter'
        );
        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(startOfNextFiscalQuarter),
            'Start of next fiscal quarter should not be greater than the next fiscal quarter'
        );
        Assert.isTrue(
            dateLiteralComparable.isGreaterThan(startOfFiscalQuarterAfterNext),
            'Start of fiscal quarter after next should be greater than the next fiscal quarter'
        );
        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(
                startOfFiscalQuarterAfterNextMinusOneDay
            ),
            'Start of fiscal quarter after next minus one day should be greater than the next fiscal quarter'
        );
    }
}
