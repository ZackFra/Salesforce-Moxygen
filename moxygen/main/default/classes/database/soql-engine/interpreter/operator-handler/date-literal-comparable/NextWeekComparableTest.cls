@isTest
private class NextWeekComparableTest {
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
}
