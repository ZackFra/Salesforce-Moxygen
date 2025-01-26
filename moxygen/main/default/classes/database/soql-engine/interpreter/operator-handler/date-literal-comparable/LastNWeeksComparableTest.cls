@isTest
private class LastNWeeksComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastWeekComparable = new LastNWeeksComparable()
            .withToken('last_n_weeks:1');
        Assert.isFalse(
            lastWeekComparable.isLessThan(Gmt.today()),
            'Today should not be less than LAST_N_WEEKS:1'
        );
        Assert.isFalse(
            lastWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(-7)
            ),
            'Last week should not be less than LAST_N_WEEKS:1'
        );
        Assert.isTrue(
            lastWeekComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(-8)
            ),
            '8 days ago should be less than LAST_N_WEEKS:1'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastWeekComparable = new LastNWeeksComparable()
            .withToken('last_n_weeks:1');
        Assert.isFalse(
            lastWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(-7)
            ),
            'Last week should not be greater than LAST_N_WEEKS:1'
        );
        Assert.isFalse(
            lastWeekComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(-8)
            ),
            '8 days ago should not be greater than LAST_N_WEEKS:1'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThan(Gmt.today()),
            'Today should be greater than LAST_N_WEEKS:1'
        );
        Assert.isTrue(
            lastWeekComparable.isGreaterThan(Gmt.today().addDays(1)),
            'Tomorrow should be greater than LAST_N_WEEKS:1'
        );
    }
}
