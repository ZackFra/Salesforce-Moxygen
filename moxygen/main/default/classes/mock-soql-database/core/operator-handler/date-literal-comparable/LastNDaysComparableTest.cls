@isTest
private class LastNDaysComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isFalse(
            lastNDaysComparable.isEqual(Gmt.today()),
            'Today should not be equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isEqual(Gmt.today().addDays(-7)),
            '7 days ago should be equal to LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isEqual(Gmt.today().addDays(-8)),
            '8 days ago should not be equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isEqual(Gmt.today().addDays(-1)),
            'Yesterday should be equal to LAST_N_DAYS:7'
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isFalse(
            lastNDaysComparable.isLessThan(Gmt.today()),
            'Today should not be less than LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isLessThan(Gmt.today().addDays(-7)),
            '7 days ago should not be less than LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isLessThan(Gmt.today().addDays(-8)),
            '8 days ago should be less than LAST_N_DAYS:7'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isFalse(
            lastNDaysComparable.isGreaterThan(Gmt.today().addDays(-7)),
            '7 days ago should not be greater than LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isGreaterThan(Gmt.today().addDays(-8)),
            '8 days ago should not be greater than LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isGreaterThan(Gmt.today()),
            'Today should be greater than LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isGreaterThan(Gmt.today().addDays(1)),
            'Tomorrow should be greater than LAST_N_DAYS:7'
        );
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isTrue(
            lastNDaysComparable.isLessThanOrEqual(Gmt.today().addDays(-8)),
            '8 days ago should be less than or equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isLessThanOrEqual(Gmt.today().addDays(-7)),
            '7 days ago should be less than or equal to LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isLessThanOrEqual(Gmt.today()),
            'Today should not be less than or equal to LAST_N_DAYS:7'
        );
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isFalse(
            lastNDaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(-8)),
            '8 days ago should not be greater than or equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(-7)),
            '7 days ago should be greater than or equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isGreaterThanOrEqual(Gmt.today()),
            'Today should be greater than or equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isGreaterThanOrEqual(Gmt.today().addDays(1)),
            'Tomorrow should be greater than or equal to LAST_N_DAYS:7'
        );
    }

    @isTest
    static void ensuresIsNotEqualWorks() {
        DateLiteralComparable lastNDaysComparable = new LastNDaysComparable()
            .withToken('last_n_days:7');
        Assert.isTrue(
            lastNDaysComparable.isNotEqual(Gmt.today()),
            'Today should not be equal to LAST_N_DAYS:7'
        );
        Assert.isFalse(
            lastNDaysComparable.isNotEqual(Gmt.today().addDays(-7)),
            '7 days ago should be equal to LAST_N_DAYS:7'
        );
        Assert.isTrue(
            lastNDaysComparable.isNotEqual(Gmt.today().addDays(-8)),
            '8 days ago should not be equal to LAST_N_DAYS:7'
        );
    }
}
