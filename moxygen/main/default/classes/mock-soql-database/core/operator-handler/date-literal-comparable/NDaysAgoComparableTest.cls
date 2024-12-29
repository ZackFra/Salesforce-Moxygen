@isTest
private class NDaysAgoComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable().withToken('n_days_ago:5');
        Assert.isFalse(nDaysAgoComparable.isEqual(Gmt.today()), 'Today should not be equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isEqual(Gmt.today().addDays(-1)), 'Yesterday should be equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isEqual(Gmt.today().addDays(-5)), '5 days ago should be equal to N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isEqual(Gmt.today().addDays(-6)), '6 days ago should not be equal to N_DAYS_AGO:5');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable().withToken('n_days_ago:5');
        Assert.isFalse(nDaysAgoComparable.isLessThan(Gmt.today()), 'Today should not be less than N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isLessThan(Gmt.today().addDays(-1)), 'Yesterday should not be less than N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isLessThan(Gmt.today().addDays(-5)), '5 days ago should not be less than N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isLessThan(Gmt.today().addDays(-6)), '6 days ago should be less than N_DAYS_AGO:5');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable().withToken('n_days_ago:5');
        Assert.isFalse(nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(-5)), '5 days ago should not be greater than N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(-6)), '6 days ago should not be greater than N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(-1)), 'Yesterday should not be greater than N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isGreaterThan(Gmt.today()), 'Today should be greater than N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(1)), 'Tomorrow should be greater than N_DAYS_AGO:5');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable().withToken('n_days_ago:5');
        Assert.isTrue(nDaysAgoComparable.isLessThanOrEqual(Gmt.today().addDays(-6)), '6 days ago should be less than or equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isLessThanOrEqual(Gmt.today().addDays(-5)), '5 days ago should be less than or equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isLessThanOrEqual(Gmt.today().addDays(-1)), 'Yesterday should be less than or equal to N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isLessThanOrEqual(Gmt.today()), 'Today should not be less than or equal to N_DAYS_AGO:5');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable().withToken('n_days_ago:5');
        Assert.isFalse(nDaysAgoComparable.isGreaterThanOrEqual(Gmt.today().addDays(-6)), '6 days ago should not be greater than or equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isGreaterThanOrEqual(Gmt.today().addDays(-5)), '5 days ago should be greater than or equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isGreaterThanOrEqual(Gmt.today().addDays(-1)), 'Yesterday should be greater than or equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isGreaterThanOrEqual(Gmt.today()), 'Today should be greater than or equal to N_DAYS_AGO:5');
        Assert.isTrue(nDaysAgoComparable.isGreaterThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should be greater than or equal to N_DAYS_AGO:5');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable().withToken('n_days_ago:5');
        Assert.isTrue(nDaysAgoComparable.isNotEqual(Gmt.today()), 'Today should not be equal to N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isNotEqual(Gmt.today().addDays(-1)), 'Yesterday should be equal to N_DAYS_AGO:5');
        Assert.isFalse(nDaysAgoComparable.isNotEqual(Gmt.today().addDays(-5)), '5 days ago should be equal to N_DAYS_AGO:5');
    }
}