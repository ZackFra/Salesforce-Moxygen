@isTest
private class ThisMonthComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isTrue(thisMonthComparator.isEqual(Gmt.today().toStartOfMonth()), 'This month should be equal to start of month');
        Assert.isTrue(thisMonthComparator.isEqual(Gmt.today().toStartOfMonth().addDays(1)), 'This month should be equal to start of month + 1 day');
        Assert.isTrue(thisMonthComparator.isEqual(Gmt.today().toStartOfMonth().addDays(25)), 'This month should be equal to start of month + 29 days');
        Assert.isFalse(thisMonthComparator.isEqual(Gmt.today().toStartOfMonth().addMonths(1)), 'This month should not be equal to start of next month');
        Assert.isFalse(thisMonthComparator.isEqual(Gmt.today().toStartOfMonth().addDays(-1)), 'This month should not be equal to start of last month');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isFalse(thisMonthComparator.isLessThan(Gmt.today().toStartOfMonth()), 'Start of month should not be less than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isLessThan(Gmt.today().toStartOfMonth().addDays(1)), 'Start of month + 1 day should not be less than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isLessThan(Gmt.today().toStartOfMonth().addDays(25)), 'Start of month + 25 days should not be less than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isLessThan(Gmt.today().toStartOfMonth().addMonths(1)), 'Start of next month should not be less than THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isLessThan(Gmt.today().toStartOfMonth().addMonths(-1)), 'Start of last month should be less than THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isLessThan(Gmt.today().addYears(-1)), 'Last year should be less than THIS_MONTH');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isFalse(thisMonthComparator.isGreaterThan(Gmt.today().toStartOfMonth()), 'Start of month should not be greater than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isGreaterThan(Gmt.today().toStartOfMonth().addDays(1)), 'Start of month + 1 day should not be greater than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isGreaterThan(Gmt.today().toStartOfMonth().addDays(25)), 'Start of month + 25 days should not be greater than THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isGreaterThan(Gmt.today().toStartOfMonth().addMonths(1)), 'Start of next month should be greater than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isGreaterThan(Gmt.today().toStartOfMonth().addMonths(-1)), 'Start of last month should not be greater than THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isGreaterThan(Gmt.today().addYears(-1)), 'Last year should not be greater than THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isGreaterThan(Gmt.today().addYears(1)), 'Next year should be greater than THIS_MONTH');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isTrue(thisMonthComparator.isLessThanOrEqual(Gmt.today().toStartOfMonth()), 'Start of month should be less than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isLessThanOrEqual(Gmt.today().toStartOfMonth().addDays(1)), 'Start of month + 1 day should be less than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isLessThanOrEqual(Gmt.today().toStartOfMonth().addDays(25)), 'Start of month + 25 days should be less than or equal to THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isLessThanOrEqual(Gmt.today().toStartOfMonth().addMonths(1)), 'Start of next month should not be less than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isLessThanOrEqual(Gmt.today().toStartOfMonth().addMonths(-1)), 'Start of last month should be less than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isLessThanOrEqual(Gmt.today().addYears(-1)), 'Last year should be less than or equal to THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isLessThanOrEqual(Gmt.today().addYears(1)), 'Next year should not be less than or equal to THIS_MONTH');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isTrue(thisMonthComparator.isGreaterThanOrEqual(Gmt.today().toStartOfMonth()), 'Start of month should be greater than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isGreaterThanOrEqual(Gmt.today().toStartOfMonth().addDays(1)), 'Start of month + 1 day should be greater than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isGreaterThanOrEqual(Gmt.today().toStartOfMonth().addDays(25)), 'Start of month + 25 days should be greater than or equal to THIS_MONTH');
        Assert.isTrue(thisMonthComparator.isGreaterThanOrEqual(Gmt.today().toStartOfMonth().addMonths(1)), 'Start of next month should be greater than or equal to THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isGreaterThanOrEqual(Gmt.today().toStartOfMonth().addMonths(-1)), 'Start of last month should not be greater than or equal to THIS_MONTH');
        Assert.isFalse(thisMonthComparator.isGreaterThanOrEqual(Gmt.today().addYears(-1)), 'Last year should not be greater than or equal to THIS_MONTH');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isFalse(thisMonthComparator.isNotEqual(Gmt.today().toStartOfMonth()), 'This month should not be not equal to start of month');
        Assert.isFalse(thisMonthComparator.isNotEqual(Gmt.today().toStartOfMonth().addDays(1)), 'This month should not be not equal to start of month + 1 day');
        Assert.isFalse(thisMonthComparator.isNotEqual(Gmt.today().toStartOfMonth().addDays(25)), 'This month should not be not equal to start of month + 25 days');
        Assert.isTrue(thisMonthComparator.isNotEqual(Gmt.today().toStartOfMonth().addMonths(1)), 'This month should be not equal to start of next month');
        Assert.isTrue(thisMonthComparator.isNotEqual(Gmt.today().toStartOfMonth().addDays(-1)), 'This month should be not equal to start of last month');
    }
}