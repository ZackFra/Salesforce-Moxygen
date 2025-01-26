@isTest
private class Next90DaysComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isTrue(
            next90DaysComparable.isLessThan(Gmt.today().addDays(-1)),
            'Yesterday should be less than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isLessThan(Gmt.today()),
            'Today should not be less than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isLessThan(Gmt.today().addDays(1)),
            'Tomorrow should not be less than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isLessThan(Gmt.today().addDays(89)),
            '89 days from now should not be less than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isLessThan(Gmt.today().addDays(90)),
            '90 days from now should not be less than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isLessThan(Gmt.today().addDays(91)),
            '91 days from now should not be less than NEXT_90_DAYS'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable next90DaysComparable = new Next90DaysComparable();
        Assert.isFalse(
            next90DaysComparable.isGreaterThan(Gmt.today().addDays(-1)),
            'Yesterday should not be greater than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isGreaterThan(Gmt.today()),
            'Today should not be greater than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isGreaterThan(Gmt.today().addDays(1)),
            'Tomorrow should not be greater than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isGreaterThan(Gmt.today().addDays(89)),
            '89 days from now should not be greater than NEXT_90_DAYS'
        );
        Assert.isFalse(
            next90DaysComparable.isGreaterThan(Gmt.today().addDays(90)),
            '90 days from now should not be greater than NEXT_90_DAYS'
        );
        Assert.isTrue(
            next90DaysComparable.isGreaterThan(Gmt.today().addDays(91)),
            '91 days from now should be greater than NEXT_90_DAYS'
        );
    }
}
