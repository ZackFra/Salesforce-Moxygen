@isTest
private class NextWeekComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable nextWeekComparable = new NextWeekComparable();
        Assert.isFalse(
            nextWeekComparable.isEqual(Gmt.today().toStartOfWeek()),
            'Start of week should not be equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isEqual(Gmt.today().toStartOfWeek().addDays(1)),
            'Start of week + 1 day should not be equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isEqual(Gmt.today().toStartOfWeek().addDays(6)),
            'Start of week + 6 days should not be equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isEqual(Gmt.today().toStartOfWeek().addDays(7)),
            'Start of next week should be equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isEqual(Gmt.today().toStartOfWeek().addDays(8)),
            'Start of next week + 1 day should be equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isEqual(Gmt.today().toStartOfWeek().addDays(13)),
            'The week after should not be equal to NEXT_WEEK'
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextWeekComparable = new NextWeekComparable();
        Assert.isTrue(
            nextWeekComparable.isLessThan(Gmt.today().toStartOfWeek()),
            'Start of week should be less than NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should be less than NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should be less than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should not be less than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(8)
            ),
            'Start of next week + 1 day should not be less than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(13)
            ),
            'The week after should not be less than NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThan(Gmt.today().addMonths(-1)),
            'Last month should be less than NEXT_WEEK'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextWeekComparable = new NextWeekComparable();
        Assert.isFalse(
            nextWeekComparable.isGreaterThan(Gmt.today().toStartOfWeek()),
            'Start of week should not be greater than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should not be greater than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should not be greater than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should not be greater than NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(8)
            ),
            'Start of next week + 1 day should not be greater than NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(15)
            ),
            'The week after should be greater than NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isGreaterThan(Gmt.today().addMonths(2)),
            'Two months from now should be greater than NEXT_WEEK'
        );
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nextWeekComparable = new NextWeekComparable();
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(Gmt.today().toStartOfWeek()),
            'Start of week should be less than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should be less than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should be less than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should be less than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(8)
            ),
            'Start of next week + 1 day should be less than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(13)
            ),
            'The week after should be less than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isLessThanOrEqual(Gmt.today().addMonths(-1)),
            'Last month should be less than or equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isLessThanOrEqual(Gmt.today().addMonths(1)),
            'Next month should not be less than or equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isLessThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(15)
            ),
            'Two weeks from now should not be less than or equal to NEXT_WEEK'
        );
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nextWeekComparable = new NextWeekComparable();
        Assert.isFalse(
            nextWeekComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfWeek()
            ),
            'Start of week should not be greater than or equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should not be greater than or equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should not be greater than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should be greater than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(8)
            ),
            'Start of next week + 1 day should be greater than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfWeek().addDays(13)
            ),
            'The week after should be greater than or equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isGreaterThanOrEqual(Gmt.today().addMonths(-1)),
            'Last month should not be greater than or equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isGreaterThanOrEqual(Gmt.today().addMonths(1)),
            'Next month should be greater than or equal to NEXT_WEEK'
        );
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nextWeekComparable = new NextWeekComparable();
        Assert.isTrue(
            nextWeekComparable.isNotEqual(Gmt.today().toStartOfWeek()),
            'Start of week should be not equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isNotEqual(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should be not equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isNotEqual(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should be not equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isNotEqual(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should not be not equal to NEXT_WEEK'
        );
        Assert.isFalse(
            nextWeekComparable.isNotEqual(
                Gmt.today().toStartOfWeek().addDays(8)
            ),
            'Start of next week + 1 day should not be not equal to NEXT_WEEK'
        );
        Assert.isTrue(
            nextWeekComparable.isNotEqual(
                Gmt.today().toStartOfWeek().addDays(15)
            ),
            'The week after should be not equal to NEXT_WEEK'
        );
    }
}
