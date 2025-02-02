@isTest
private class ThisFiscalQuarterComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfThisFiscalQuarterMinusOneDay = startOfThisFiscalQuarter.addDays(
            -1
        );

        ThisFiscalQuarterComparable dateLiteralComparable = new ThisFiscalQuarterComparable();

        Assert.isTrue(
            dateLiteralComparable.isLessThan(
                startOfThisFiscalQuarterMinusOneDay
            ),
            'Start of this fiscal quarter minus one day should be less than the this fiscal quarter'
        );

        Assert.isFalse(
            dateLiteralComparable.isLessThan(startOfThisFiscalQuarter),
            'Start of this fiscal quarter should not be less than the this fiscal quarter'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);

        ThisFiscalQuarterComparable dateLiteralComparable = new ThisFiscalQuarterComparable();

        Assert.isTrue(
            dateLiteralComparable.isGreaterThan(startOfNextFiscalQuarter),
            'Start of next fiscal quarter should be greater than the this fiscal quarter'
        );

        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(startOfThisFiscalQuarter),
            'Start of this fiscal quarter should not be greater than the this fiscal quarter'
        );
    }
}
