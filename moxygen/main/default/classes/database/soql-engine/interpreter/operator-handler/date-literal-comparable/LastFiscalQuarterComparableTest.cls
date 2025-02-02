@isTest
private class LastFiscalQuarterComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        LastFiscalQuarterComparable dateLiteralComparable = new LastFiscalQuarterComparable();
        Date startOfThisFiscalQuarter = Gmt.startOfthisFiscalQuarter();
        Date startOfLastFiscalQuarter = startOfThisFiscalQuarter.addMonths(-3);
        Date startOfLastFiscalQuarterMinusOneDay = startOfLastFiscalQuarter.addDays(
            -1
        );
        Assert.isTrue(
            dateLiteralComparable.isLessThan(
                startOfLastFiscalQuarterMinusOneDay
            ),
            'Start of last fiscal quarter minus one day should be less than the last fiscal quarter'
        );

        Assert.isFalse(
            dateLiteralComparable.isLessThan(startOfLastFiscalQuarter),
            'Start of last fiscal quarter should not be less than the last fiscal quarter'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        LastFiscalQuarterComparable dateLiteralComparable = new LastFiscalQuarterComparable();
        Date startOfThisFiscalQuarter = Gmt.startOfthisFiscalQuarter();
        Date startOfThisFiscalQuarterMinusOne = startOfThisFiscalQuarter.addDays(
            -1
        );

        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(
                startOfThisFiscalQuarterMinusOne
            ),
            'Start of this fiscal quarter minus one day should not be greater than the last fiscal quarter'
        );

        Assert.isTrue(
            dateLiteralComparable.isGreaterThan(startOfThisFiscalQuarter),
            'Start of this fiscal quarter should be greater than the last fiscal quarter'
        );
    }
}
