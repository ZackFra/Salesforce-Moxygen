@isTest
private class NextQuarterComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter().addMonths(3);

        Assert.isFalse(nextQuarter.isEqual(startOfNextQuarter.addDays(-1)), 'Start of next quarter should not be equal to the day before');
        Assert.isTrue(nextQuarter.isEqual(startOfNextQuarter), 'Start of next quarter should be equal to itself');
        Assert.isTrue(nextQuarter.isEqual(startOfNextQuarter.addDays(1)), 'Start of next quarter should be equal to the day after');
        Assert.isTrue(nextQuarter.isEqual(startOfNextQuarter.addMonths(1)), 'Start of next quarter should be equal to a month after');
        Assert.isTrue(nextQuarter.isEqual(startOfNextQuarter.addMonths(2)), 'Start of next quarter should be equal to two months after');
        Assert.isFalse(nextQuarter.isEqual(startOfNextQuarter.addMonths(3)), 'Start of next quarter should not be equal to three months after');

    }

    @isTest
    static void ensuresIsLessThanWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter().addMonths(3);
        Assert.isTrue(nextQuarter.isLessThan(startOfNextQuarter.addMonths(-1)), 'One month before should be less than NEXT_QUARTER');
        Assert.isFalse(nextQuarter.isLessThan(startOfNextQuarter), 'Start of next quarter should not be less than itself');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter().addMonths(3);
        Assert.isFalse(nextQuarter.isGreaterThan(startOfNextQuarter.addMonths(-1)), 'One month before should not be greater than NEXT_QUARTER');
        Assert.isFalse(nextQuarter.isGreaterThan(startOfNextQuarter), 'Start of next quarter should not be greater than itself');
        Assert.isTrue(nextQuarter.isGreaterThan(startOfNextQuarter.addMonths(3).addDays(1)), 'One month after should be greater than NEXT_QUARTER');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter().addMonths(3);
        Assert.isTrue(nextQuarter.isLessThanOrEqual(startOfNextQuarter.addMonths(-1)), 'One month before should be less than or equal to NEXT_QUARTER');
        Assert.isTrue(nextQuarter.isLessThanOrEqual(startOfNextQuarter), 'Start of next quarter should be less than or equal to itself');
        Assert.isFalse(nextQuarter.isLessThanOrEqual(startOfNextQuarter.addMonths(3)), 'Three months after should not be less than or equal to NEXT_QUARTER');
    }

    @isTest
    static void ensuresIsGreaterThanOrEqualWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter().addMonths(3);
        Assert.isFalse(nextQuarter.isGreaterThanOrEqual(startOfNextQuarter.addMonths(-1)), 'One month before should not be greater than or equal to NEXT_QUARTER');
        Assert.isTrue(nextQuarter.isGreaterThanOrEqual(startOfNextQuarter), 'Start of next quarter should be greater than or equal to itself');
        Assert.isTrue(nextQuarter.isGreaterThanOrEqual(startOfNextQuarter.addMonths(3)), 'Three months after should be greater than or equal to NEXT_QUARTER');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        NextQuarterComparable nextQuarter = new NextQuarterComparable();
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter().addMonths(3);
        Assert.isTrue(nextQuarter.isNotEqual(startOfNextQuarter.addMonths(-1)), 'One month before should not be equal to NEXT_QUARTER');
        Assert.isFalse(nextQuarter.isNotEqual(startOfNextQuarter), 'Start of next quarter should be equal to itself');
        Assert.isTrue(nextQuarter.isNotEqual(startOfNextQuarter.addMonths(3)), 'Three months after should not be equal to NEXT_QUARTER');
    }
}