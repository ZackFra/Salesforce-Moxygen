@isTest
private class Next90DaysComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isFalse(next90DaysComparable.isEqual(Gmt.today().addDays(-1)), 'Yesterday should not be equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isEqual(Gmt.today()), 'Today should be equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isEqual(Gmt.today().addDays(1)), 'Tomorrow should be equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isEqual(Gmt.today().addDays(89)), '89 days from now should be equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isEqual(Gmt.today().addDays(90)), '90 days day from now should be equal to NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isEqual(Gmt.today().addDays(91)), '91 days from now should not be equal to NEXT_90_DAYS');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isTrue(next90DaysComparable.isLessThan(Gmt.today().addDays(-1)), 'Yesterday should be less than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isLessThan(Gmt.today()), 'Today should not be less than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isLessThan(Gmt.today().addDays(1)), 'Tomorrow should not be less than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isLessThan(Gmt.today().addDays(89)), '89 days from now should not be less than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isLessThan(Gmt.today().addDays(90)), '90 days from now should not be less than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isLessThan(Gmt.today().addDays(91)), '91 days from now should not be less than NEXT_90_DAYS');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isFalse(next90DaysComparable.isGreaterThan(Gmt.today().addDays(-1)), 'Yesterday should not be greater than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isGreaterThan(Gmt.today()), 'Today should not be greater than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isGreaterThan(Gmt.today().addDays(1)), 'Tomorrow should not be greater than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isGreaterThan(Gmt.today().addDays(89)), '89 days from now should not be greater than NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isGreaterThan(Gmt.today().addDays(90)), '90 days from now should not be greater than NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isGreaterThan(Gmt.today().addDays(91)), '91 days from now should be greater than NEXT_90_DAYS');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isTrue(next90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(-1)), 'Yesterday should be less than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isLessThanOrEqual(Gmt.today()), 'Today should be less than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should be less than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(89)), '89 days from now should be less than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(90)), '90 days from now should be less than or equal to NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isLessThanOrEqual(Gmt.today().addDays(91)), '91 days from now should not be less than or equal to NEXT_90_DAYS');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isFalse(next90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(-1)), 'Yesterday should not be greater than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isGreaterThanOrEqual(Gmt.today()), 'Today should be greater than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(1)), 'Tomorrow should be greater than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(89)), '89 days from now should be greater than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(90)), '90 days from now should be greater than or equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(91)), '91 days from now should be greater than or equal to NEXT_90_DAYS');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isTrue(next90DaysComparable.isNotEqual(Gmt.today().addDays(-1)), 'Yesterday should not be equal to NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isNotEqual(Gmt.today()), 'Today should be equal to NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isNotEqual(Gmt.today().addDays(1)), 'Tomorrow should be equal to NEXT_90_DAYS');
        Assert.isFalse(next90DaysComparable.isNotEqual(Gmt.today().addDays(90)), '90 days from now should be equal to NEXT_90_DAYS');
        Assert.isTrue(next90DaysComparable.isNotEqual(Gmt.today().addDays(91)), '91 days from now should not be equal to NEXT_90_DAYS');
    }
}