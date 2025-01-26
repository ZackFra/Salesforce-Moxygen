@isTest
private class ThisWeekComparableTest {
    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isFalse(
            thisWeekComparator.isLessThan(Gmt.today().toStartOfWeek()),
            'Start of week should not be less than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isLessThan(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should not be less than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isLessThan(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should not be less than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isLessThan(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should not be less than THIS_WEEK'
        );
        Assert.isTrue(
            thisWeekComparator.isLessThan(
                Gmt.today().toStartOfWeek().addDays(-7)
            ),
            'Start of last week should be less than THIS_WEEK'
        );
        Assert.isTrue(
            thisWeekComparator.isLessThan(Gmt.today().addMonths(-1)),
            'Last month should be less than THIS_WEEK'
        );
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isFalse(
            thisWeekComparator.isGreaterThan(Gmt.today().toStartOfWeek()),
            'Start of week should not be greater than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should not be greater than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should not be greater than THIS_WEEK'
        );
        Assert.isTrue(
            thisWeekComparator.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(7)
            ),
            'Start of next week should be greater than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(-7)
            ),
            'Start of last week should not be greater than THIS_WEEK'
        );
        Assert.isFalse(
            thisWeekComparator.isGreaterThan(Gmt.today().addMonths(-1)),
            'Last month should not be greater than THIS_WEEK'
        );
        Assert.isTrue(
            thisWeekComparator.isGreaterThan(Gmt.today().addMonths(1)),
            'Next month should be greater than THIS_WEEK'
        );
    }
}
