@isTest
private class LastQuarterComparableTest {
    static Datetime noon(Datetime gmtInstant) {
        return Datetime.newInstance(
            gmtInstant.dateGmt(),
            Time.newInstance(12, 0, 0, 0)
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();
        Assert.isTrue(
            lastQuarter.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-4)
            ),
            'Should be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-3)
            ),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-2)
            ),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-1)
            ),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(noon(Gmt.startOfThisCalendarQuarter())),
            'Should not be less than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(1)
            ),
            'Should not be less than the last quarter'
        );
    }

    @isTest
    static void ensuresIsGreaterThanWorks() {
        DateLiteralComparable lastQuarter = new LastQuarterComparable();
        Assert.isFalse(
            lastQuarter.isGreaterThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-3)
            ),
            'Should not be greater than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isGreaterThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-2)
            ),
            'Should not be greater than the last quarter'
        );

        Assert.isFalse(
            lastQuarter.isGreaterThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(-1)
            ),
            'Should not be greater than the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThan(noon(Gmt.startOfThisCalendarQuarter())),
            'Should be greater than the last quarter'
        );

        Assert.isTrue(
            lastQuarter.isGreaterThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(1)
            ),
            'Should be greater than the last quarter'
        );
    }
}
