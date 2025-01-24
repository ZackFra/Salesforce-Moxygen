@isTest
private class NextNQuartersComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Assert.isFalse(
            nextNQuarters.isEqual(Gmt.today()),
            'Today should not be equal to NEXT_N_QUARTERS:5'
        );

        Assert.isTrue(
            nextNQuarters.isEqual(
                startOfNextQuarter.addMonths(3 * 5).addDays(-1)
            ),
            'isEqual should return true when fieldValue is in the next 5 quarters'
        );

        Assert.isFalse(
            nextNQuarters.isEqual(startOfNextQuarter.addMonths(3 * 6)),
            'isEqual should return false when fieldValue is not in the next 5 quarters'
        );
    }

    @isTest
    static void ensuresIsLessThanWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');

        Assert.isTrue(
            nextNQuarters.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(3).addDays(-1)
            ),
            'isLessThan should return true when fieldValue is not in the next quarter'
        );

        Assert.isFalse(
            nextNQuarters.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(3 * 5)
            ),
            'isLessThan should return false when fieldValue is in the next 5 quarters'
        );
    }

    @isTest
    static void ensuresIsGreaterThanWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Assert.isTrue(
            nextNQuarters.isGreaterThan(startOfNextQuarter.addMonths(3 * 5)),
            'isGreaterThan should return true when fieldValue is not in the next 5 quarters'
        );

        Assert.isFalse(
            nextNQuarters.isGreaterThan(
                startOfNextQuarter.addMonths(3 * 5).addDays(-1)
            ),
            'isGreaterThan should return false when fieldValue is in the next 5 quarters'
        );
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);

        Assert.isTrue(
            nextNQuarters.isLessThanOrEqual(startOfNextQuarter.addDays(-1)),
            'isLessThanOrEqual should return true when fieldValue is not in the next quarter'
        );

        Assert.isTrue(
            nextNQuarters.isLessThanOrEqual(
                startOfNextQuarter.addMonths(3 * 5).addDays(-1)
            ),
            'isLessThanOrEqual should return true when fieldValue is in the next 5 quarters'
        );

        Assert.isFalse(
            nextNQuarters.isLessThanOrEqual(
                startOfNextQuarter.addMonths(3 * 5)
            ),
            'isLessThanOrEqual should return false when fieldValue is not in the next 5 quarters'
        );
    }

    @isTest
    static void ensuresIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');
        Datetime nextCalendarQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);

        Assert.isTrue(
            nextNQuarters.isGreaterThanOrEqual(
                nextCalendarQuarter.addMonths(3 * 6)
            ),
            'isGreaterThanOrEqual should return true when fieldValue is in the next 5 quarters'
        );

        Assert.isTrue(
            nextNQuarters.isGreaterThanOrEqual(
                nextCalendarQuarter.addMonths(3 * 5).addMonths(1)
            ),
            'isGreaterThanOrEqual should return true when fieldValue is in the next 5 quarters'
        );

        Assert.isFalse(
            nextNQuarters.isGreaterThanOrEqual(
                Gmt.startOfThisCalendarQuarter()
            ),
            'isGreaterThanOrEqual should return false when fieldValue is not in the next 5 quarters'
        );
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');

        Assert.isTrue(
            nextNQuarters.isNotEqual(Gmt.today()),
            'Today should not be equal to NEXT_N_QUARTERS:5'
        );

        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);

        Assert.isFalse(
            nextNQuarters.isNotEqual(
                startOfNextQuarter.addMonths(3 * 5).addDays(-1)
            ),
            'isNotEqual should return false when fieldValue is in the next 5 quarters'
        );

        Assert.isTrue(
            nextNQuarters.isNotEqual(startOfNextQuarter.addMonths(3 * 5)),
            'isNotEqual should return true when fieldValue is not in the next 5 quarters'
        );
    }
}
