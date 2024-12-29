@isTest
private class LastWeekComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isTrue(lastWeekComparable.isEqual(Gmt.today().addDays(-7)), '7 days ago should be equal to LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isEqual(Gmt.today()), 'Today should not be equal to LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isEqual(Gmt.today().addDays(1)), 'Tomorrow should not be equal to LAST_WEEK');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(lastWeekComparable.isLessThan(Gmt.today().addDays(-7)), '7 days ago should not be less than LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThan(Gmt.today()), 'Today should not be less than LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThan(Gmt.today().addDays(1)), 'Tomorrow should not be less than LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThan(Gmt.today().addDays(7)), '7 days from now should not be less than LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isLessThan(Gmt.today().addMonths(-2)), '2 months ago should be less than LAST_WEEK');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(lastWeekComparable.isGreaterThan(Gmt.today().addDays(-7)), '7 days ago should not be greater than LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThan(Gmt.today()), 'Today should not be greater than LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThan(Gmt.today().addDays(1)), 'Tomorrow should not be greater than LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThan(Gmt.today().addDays(7)), '7 days from now should not be greater than LAST_WEEK');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isTrue(lastWeekComparable.isLessThanOrEqual(Gmt.today().addDays(-7)), '7 days ago should be less than or equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isLessThanOrEqual(Gmt.today().addMonths(-2)), '2 months ago should be less than or equal to LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThanOrEqual(Gmt.today()), 'Today should not be less than or equal to LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should not be less than or equal to LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThanOrEqual(Gmt.today().addDays(7)), '7 days from now should not be less than or equal to LAST_WEEK');
        Assert.isFalse(lastWeekComparable.isLessThanOrEqual(Gmt.today().addDays(8)), '8 days from now should not be less than or equal to LAST_WEEK');
    }

    @isTest
    static void ensuresIsGreaterThanOrEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(lastWeekComparable.isGreaterThanOrEqual(Gmt.today().addMonths(-2)), '2 months ago should not be greater than or equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThanOrEqual(Gmt.today().addDays(-7)), '7 days ago should be greater than or equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThanOrEqual(Gmt.today()), 'Today should be greater than or equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should be greater than or equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isGreaterThanOrEqual(Gmt.today().addDays(7)), '7 days from now should be greater than or equal to LAST_WEEK');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable lastWeekComparable = new LastWeekComparable();
        Assert.isFalse(lastWeekComparable.isNotEqual(Gmt.today().addDays(-7)), '7 days ago should not be equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isNotEqual(Gmt.today()), 'Today should not be equal to LAST_WEEK');
        Assert.isTrue(lastWeekComparable.isNotEqual(Gmt.today().addDays(1)), 'Tomorrow should be equal to LAST_WEEK');
    }
}