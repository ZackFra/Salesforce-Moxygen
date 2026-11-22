@isTest
private class LastWeekComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isTrue(
            lastWeekComparable.isEqual(Date.today().addDays(-7)),
            '7 days ago should be equal to LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isEqual(Date.today()),
            'Today should not be equal to LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isEqual(Date.today().addDays(1)),
            'Tomorrow should not be equal to LAST_WEEK'
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(
            lastWeekComparable.isLessThan(Date.today().addDays(-7)),
            '7 days ago should not be less than LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThan(Date.today()),
            'Today should not be less than LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThan(Date.today().addDays(1)),
            'Tomorrow should not be less than LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThan(Date.today().addDays(7)),
            '7 days from now should not be less than LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isLessThan(Date.today().addMonths(-2)),
            '2 months ago should be less than LAST_WEEK'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(
            lastWeekComparable.isGreaterThan(Date.today().addDays(-7)),
            '7 days ago should not be greater than LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThan(Date.today()),
            'Today should not be greater than LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThan(Date.today().addDays(1)),
            'Tomorrow should not be greater than LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThan(Date.today().addDays(7)),
            '7 days from now should not be greater than LAST_WEEK'
        );
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isTrue(
            lastWeekComparable.isLessThanOrEqual(Date.today().addDays(-7)),
            '7 days ago should be less than or equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isLessThanOrEqual(Date.today().addMonths(-2)),
            '2 months ago should be less than or equal to LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThanOrEqual(Date.today()),
            'Today should not be less than or equal to LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThanOrEqual(Date.today().addDays(1)),
            'Tomorrow should not be less than or equal to LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThanOrEqual(Date.today().addDays(7)),
            '7 days from now should not be less than or equal to LAST_WEEK'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThanOrEqual(Date.today().addDays(8)),
            '8 days from now should not be less than or equal to LAST_WEEK'
        );
    }

    @isTest
    static void ensuresIsGreaterThanOrEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(
            lastWeekComparable.isGreaterThanOrEqual(Date.today().addMonths(-2)),
            '2 months ago should not be greater than or equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThanOrEqual(Date.today().addDays(-7)),
            '7 days ago should be greater than or equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThanOrEqual(Date.today()),
            'Today should be greater than or equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThanOrEqual(Date.today().addDays(1)),
            'Tomorrow should be greater than or equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThanOrEqual(Date.today().addDays(7)),
            '7 days from now should be greater than or equal to LAST_WEEK'
        );
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(
            lastWeekComparable.isNotEqual(Date.today().addDays(-7)),
            '7 days ago should not be equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isNotEqual(Date.today()),
            'Today should not be equal to LAST_WEEK'
        );
        Assert.isTrue(
            lastWeekComparable.isNotEqual(Date.today().addDays(1)),
            'Tomorrow should be equal to LAST_WEEK'
        );
    }
}
