@isTest
private class Last90DaysComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable last90DaysComparable = new Last90DaysComparable();
        Assert.isTrue(last90DaysComparable.isEqual(Gmt.today().addDays(-1)), 'Yesterday should be equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isEqual(Gmt.today().addDays(-90)), '90 days ago should be equal to LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isEqual(Gmt.today().addDays(-91)), '91 days ago should not be equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isEqual(Gmt.today()), 'Today should be equal to LAST_90_DAYS');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable last90DaysComparable = new Last90DaysComparable();
        Assert.isTrue(last90DaysComparable.isLessThan(Gmt.today().addDays(-91)), '91 days ago should be less than LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isLessThan(Gmt.today().addDays(-90)), '90 days ago should not be less than LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isLessThan(Gmt.today()), 'Today should not be less than LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isLessThan(Gmt.today().addDays(1)), 'Tomorrow should not be less than LAST_90_DAYS');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable last90DaysComparable = new Last90DaysComparable();
        Assert.isFalse(last90DaysComparable.isGreaterThan(Gmt.today().addDays(-91)), '91 days ago should not be greater than LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isGreaterThan(Gmt.today().addDays(-90)), '90 days ago should not be greater than LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isGreaterThan(Gmt.today()), 'Today should not be greater than LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isGreaterThan(Gmt.today().addDays(1)), 'Tomorrow should be greater than LAST_90_DAYS');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable last90DaysComparable = new Last90DaysComparable();
        Assert.isTrue(last90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(-91)), '91 days ago should be less than or equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(-90)), '90 days ago should be less than or equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isLessThanOrEqual(Gmt.today()), 'Today should be less than or equal to LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should not be less than or equal to LAST_90_DAYS');
    }

    @isTest
    static void ensuresIsGreaterThanOrEqualWorks() {
        DateLiteralComparable last90DaysComparable = new Last90DaysComparable();
        Assert.isFalse(last90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(-91)), '91 days ago should not be greater than or equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(-90)), '90 days ago should be greater than or equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isGreaterThanOrEqual(Gmt.today()), 'Today should be greater than or equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should be greater than or equal to LAST_90_DAYS');
    }

    @isTest
    static void ensuresIsNotEqualWorks() {
        DateLiteralComparable last90DaysComparable = new Last90DaysComparable();
        Assert.isFalse(last90DaysComparable.isNotEqual(Gmt.today().addDays(-1)), 'Yesterday should not be equal to LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isNotEqual(Gmt.today().addDays(-90)), '90 days ago should not be equal to LAST_90_DAYS');
        Assert.isTrue(last90DaysComparable.isNotEqual(Gmt.today().addDays(-91)), '91 days ago should be equal to LAST_90_DAYS');
        Assert.isFalse(last90DaysComparable.isNotEqual(Gmt.today()), 'Today should not be equal to LAST_90_DAYS');
    }
}