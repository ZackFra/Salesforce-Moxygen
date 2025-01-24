@isTest
private class LastQuarterComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();
        Assert.isTrue(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter().addMonths(-3)),
            'Should be equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter().addMonths(-2)),
            'Should be equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter().addMonths(-1)),
            'Should be equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter().addDays(-1)),
            'Should be equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter()),
            'Should not be equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter().addMonths(-4)),
            'Should not be equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isEqual(Gmt.startOfThisCalendarQuarter().addMonths(1)),
            'Should not be equal to the last quarter'
        );
    }

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

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();

        Assert.isTrue(
            lastQuarter.isLessThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-4)
            ),
            'Should be less than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isLessThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Should be less than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isLessThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-2)
            ),
            'Should be less than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isLessThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-1)
            ),
            'Should be less than or equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThanOrEqual(Gmt.startOfThisCalendarQuarter()),
            'Should not be less than or equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(1)
            ),
            'Should not be less than or equal to the last quarter'
        );
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();

        Assert.isFalse(
            lastQuarter.isGreaterThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-4)
            ),
            'Should not be greater than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Should be greater than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-2)
            ),
            'Should be greater than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-1)
            ),
            'Should be greater than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThanOrEqual(Gmt.startOfThisCalendarQuarter()),
            'Should be greater than or equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThanOrEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(1)
            ),
            'Should be greater than or equal to the last quarter'
        );
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();

        Assert.isTrue(
            lastQuarter.isNotEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-4)
            ),
            'Should be not equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isNotEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Should not be not equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isNotEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-2)
            ),
            'Should not be not equal to the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isNotEqual(
                Gmt.startOfThisCalendarQuarter().addMonths(-1)
            ),
            'Should not be not equal to the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isNotEqual(Gmt.startOfThisCalendarQuarter()),
            'Should be not equal to the last quarter'
        );
    }
}
