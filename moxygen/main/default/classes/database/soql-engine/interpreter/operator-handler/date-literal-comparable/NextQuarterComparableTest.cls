@isTest
private class NextQuarterComparableTest {
    @isTest
    static void ensuresIsLessThanWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Assert.isTrue(
            nextQuarter.isLessThan(startOfNextQuarter.addMonths(-1)),
            'One month before should be less than NEXT_QUARTER'
        );
        Assert.isFalse(
            nextQuarter.isLessThan(startOfNextQuarter),
            'Start of next quarter should not be less than itself'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Assert.isFalse(
            nextQuarter.isGreaterThan(startOfNextQuarter.addMonths(-1)),
            'One month before should not be greater than NEXT_QUARTER'
        );
        Assert.isFalse(
            nextQuarter.isGreaterThan(startOfNextQuarter),
            'Start of next quarter should not be greater than itself'
        );
        Assert.isTrue(
            nextQuarter.isGreaterThan(
                startOfNextQuarter.addMonths(3).addDays(1)
            ),
            'One month after should be greater than NEXT_QUARTER'
        );
    }
}
