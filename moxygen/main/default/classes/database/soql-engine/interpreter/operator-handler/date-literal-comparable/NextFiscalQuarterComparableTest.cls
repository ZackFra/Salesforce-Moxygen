@isTest
private class NextFiscalQuarterComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextFiscalQuarterComparable = new NextFiscalQuarterComparable();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        Date startOfNextFiscalQuarterMinus1Day = startOfNextFiscalQuarter.addDays(
            -1
        );

        Assert.isTrue(
            nextFiscalQuarterComparable.isLessThan(
                startOfNextFiscalQuarterMinus1Day
            ),
            'isLessThan should return true'
        );

        Assert.isFalse(
            nextFiscalQuarterComparable.isLessThan(startOfNextFiscalQuarter),
            'isLessThan should return false'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextFiscalQuarterComparable = new NextFiscalQuarterComparable();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        Date startOfNextFiscalQuarterPlus3Months = startOfNextFiscalQuarter.addMonths(
            3
        );

        Assert.isFalse(
            nextFiscalQuarterComparable.isGreaterThan(startOfNextFiscalQuarter),
            'isGreaterThan should return false'
        );

        Assert.isTrue(
            nextFiscalQuarterComparable.isGreaterThan(
                startOfNextFiscalQuarterPlus3Months
            ),
            'isGreaterThan should return true'
        );
    }
}
