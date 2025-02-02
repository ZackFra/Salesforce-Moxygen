@isTest
private class LastNFiscalQuartersComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastNFiscalQuartersComparable = new LastNFiscalQuartersComparable()
            .withToken('last_n_fiscal_quarters:1');
        Date nFiscalQuartersAgo = Gmt.startOfThisFiscalQuarter().addMonths(-3);
        Date nFiscalQuartersAgoMinus1Day = nFiscalQuartersAgo.addDays(-1);

        Assert.isTrue(
            lastNFiscalQuartersComparable.isLessThan(
                nFiscalQuartersAgoMinus1Day
            ),
            'isLessThan should return true'
        );

        Assert.isFalse(
            lastNFiscalQuartersComparable.isLessThan(nFiscalQuartersAgo),
            'isLessThan should return false'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastNFiscalQuartersComparable = new LastNFiscalQuartersComparable()
            .withToken('last_n_fiscal_quarters:1');
        Date nFiscalQuartersAgo = Gmt.startOfThisFiscalQuarter().addMonths(-3);
        Date nFiscalQuartersAgoPlus3Months = nFiscalQuartersAgo.addMonths(3);

        Assert.isFalse(
            lastNFiscalQuartersComparable.isGreaterThan(nFiscalQuartersAgo),
            'isGreaterThan should return false'
        );

        Assert.isTrue(
            lastNFiscalQuartersComparable.isGreaterThan(
                nFiscalQuartersAgoPlus3Months
            ),
            'isGreaterThan should return true'
        );
    }
}
