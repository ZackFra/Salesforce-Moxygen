@isTest
private class LastQuarterComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();
        Assert.isTrue(
            lastQuarter.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-4)
            ),
            'Should be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-2)
            ),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-1)
            ),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(Gmt.startOfThisCalendarQuarter()),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(1)
            ),
            'Should not be less than the last quarter'
        );
    }

    @isTest
    static void ensuresIsGreaterThanWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();
        Assert.isFalse(
            lastQuarter.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Should not be greater than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-2)
            ),
            'Should not be greater than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-1)
            ),
            'Should not be greater than the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThan(Gmt.startOfThisCalendarQuarter()),
            'Should be greater than the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(1)
            ),
            'Should be greater than the last quarter'
        );
    }
}
