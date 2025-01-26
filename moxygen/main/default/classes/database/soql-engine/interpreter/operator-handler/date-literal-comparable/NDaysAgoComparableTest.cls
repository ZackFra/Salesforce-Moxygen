@isTest
private class NDaysAgoComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable()
            .withToken('n_days_ago:5');
        Assert.isFalse(
            nDaysAgoComparable.isLessThan(Gmt.today()),
            'Today should not be less than N_DAYS_AGO:5'
        );
        Assert.isFalse(
            nDaysAgoComparable.isLessThan(Gmt.today().addDays(-1)),
            'Yesterday should not be less than N_DAYS_AGO:5'
        );
        Assert.isFalse(
            nDaysAgoComparable.isLessThan(Gmt.today().addDays(-5)),
            '5 days ago should not be less than N_DAYS_AGO:5'
        );
        Assert.isTrue(
            nDaysAgoComparable.isLessThan(Gmt.today().addDays(-6)),
            '6 days ago should be less than N_DAYS_AGO:5'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nDaysAgoComparable = new NDaysAgoComparable()
            .withToken('n_days_ago:5');
        Assert.isFalse(
            nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(-5)),
            '5 days ago should not be greater than N_DAYS_AGO:5'
        );
        Assert.isFalse(
            nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(-6)),
            '6 days ago should not be greater than N_DAYS_AGO:5'
        );
        Assert.isFalse(
            nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(-1)),
            'Yesterday should not be greater than N_DAYS_AGO:5'
        );
        Assert.isTrue(
            nDaysAgoComparable.isGreaterThan(Gmt.today()),
            'Today should be greater than N_DAYS_AGO:5'
        );
        Assert.isTrue(
            nDaysAgoComparable.isGreaterThan(Gmt.today().addDays(1)),
            'Tomorrow should be greater than N_DAYS_AGO:5'
        );
    }
}
