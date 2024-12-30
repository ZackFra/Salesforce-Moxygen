@isTest
private class ThisWeekComparableTest {

    @isTest
    static void ensureEqualWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isTrue(thisWeekComparator.isEqual(Gmt.today().toStartOfWeek()), 'This week should be equal to start of week');
        Assert.isTrue(thisWeekComparator.isEqual(Gmt.today().toStartOfWeek().addDays(1)), 'This week should be equal to start of week + 1 day');
        Assert.isTrue(thisWeekComparator.isEqual(Gmt.today().toStartOfWeek().addDays(6)), 'This week should be equal to start of week + 6 days');
        Assert.isFalse(thisWeekComparator.isEqual(Gmt.today().toStartOfWeek().addDays(7)), 'This week should not be equal to start of next week');
        Assert.isFalse(thisWeekComparator.isEqual(Gmt.today().toStartOfWeek().addDays(-1)), 'This week should not be equal to start of last week');
    }

    @isTest
    static void ensureLessThanWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isFalse(thisWeekComparator.isLessThan(Gmt.today().toStartOfWeek()), 'Start of week should not be less than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isLessThan(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should not be less than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isLessThan(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should not be less than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isLessThan(Gmt.today().toStartOfWeek().addDays(7)), 'Start of next week should not be less than THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isLessThan(Gmt.today().toStartOfWeek().addDays(-7)), 'Start of last week should be less than THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isLessThan(Gmt.today().addMonths(-1)), 'Last month should be less than THIS_WEEK');
    }

    @isTest
    static void ensureGreaterThanWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isFalse(thisWeekComparator.isGreaterThan(Gmt.today().toStartOfWeek()), 'Start of week should not be greater than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isGreaterThan(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should not be greater than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isGreaterThan(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should not be greater than THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isGreaterThan(Gmt.today().toStartOfWeek().addDays(7)), 'Start of next week should be greater than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isGreaterThan(Gmt.today().toStartOfWeek().addDays(-7)), 'Start of last week should not be greater than THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isGreaterThan(Gmt.today().addMonths(-1)), 'Last month should not be greater than THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isGreaterThan(Gmt.today().addMonths(1)), 'Next month should be greater than THIS_WEEK');
    }

    @isTest
    static void ensureLessThanOrEqualWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isTrue(thisWeekComparator.isLessThanOrEqual(Gmt.today().toStartOfWeek()), 'Start of week should be less than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should be less than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should be less than or equal to THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(7)), 'Start of next week should not be less than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isLessThanOrEqual(Gmt.today().toStartOfWeek().addDays(-7)), 'Start of last week should be less than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isLessThanOrEqual(Gmt.today().addMonths(-1)), 'Last month should be less than or equal to THIS_WEEK');
    }

    @isTest
    static void ensureGreaterThanOrEqualWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isTrue(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().toStartOfWeek()), 'Start of week should be greater than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(1)), 'Start of week + 1 day should be greater than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(6)), 'Start of week + 6 days should be greater than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(7)), 'Start of next week should be greater than or equal to THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().toStartOfWeek().addDays(-7)), 'Start of last week should not be greater than or equal to THIS_WEEK');
        Assert.isFalse(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().addMonths(-1)), 'Last month should not be greater than or equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isGreaterThanOrEqual(Gmt.today().addMonths(1)), 'Next month should be greater than or equal to THIS_WEEK');
    }

    @isTest
    static void ensureNotEqualWorks() {
        DateLiteralComparable thisWeekComparator = new ThisWeekComparable();
        Assert.isFalse(thisWeekComparator.isNotEqual(Gmt.today().toStartOfWeek()), 'This week should not be equal to start of week');
        Assert.isFalse(thisWeekComparator.isNotEqual(Gmt.today().toStartOfWeek().addDays(1)), 'This week should not be equal to start of week + 1 day');
        Assert.isTrue(thisWeekComparator.isNotEqual(Gmt.today().toStartOfWeek().addDays(7)), 'Start of next week should not be equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isNotEqual(Gmt.today().toStartOfWeek().addDays(-7)), 'Start of last week should not be equal to THIS_WEEK');
        Assert.isTrue(thisWeekComparator.isNotEqual(Gmt.today().addMonths(-1)), 'Last month should not be equal to THIS_WEEK');
    }
}