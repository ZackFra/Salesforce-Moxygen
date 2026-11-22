@isTest
private class LastNDaysComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isFalse(
            lastNDaysComparable.isLessThan(Date.today()),
            'Today should not be less than LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isLessThan(Date.today().addDays(-7)),
            '7 days ago should not be less than LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isLessThan(Date.today().addDays(-8)),
            '8 days ago should be less than LAST_N_DAYS:7'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isFalse(
            lastNDaysComparable.isGreaterThan(Date.today().addDays(-7)),
            '7 days ago should not be greater than LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isGreaterThan(Date.today().addDays(-8)),
            '8 days ago should not be greater than LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isGreaterThan(Date.today()),
            'Today should not be greater than LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isGreaterThan(Date.today().addDays(1)),
            'Tomorrow should be greater than LAST_N_DAYS:7'
        );
    }
}
