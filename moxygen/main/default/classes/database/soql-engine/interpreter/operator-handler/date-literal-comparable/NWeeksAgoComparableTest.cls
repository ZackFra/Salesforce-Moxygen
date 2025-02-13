@IsTest
private class NWeeksAgoComparableTest {
    static final Date START_OF_WEEK = Gmt.today().toStartOfWeek();

    @IsTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable comparable = new NWeeksAgoComparable()
            .withToken('n_weeks_ago:3');
        Assert.isTrue(
            comparable.isLessThan(START_OF_WEEK.addDays(-22)),
            'Expected date to be less than 3 weeks ago'
        );
        Assert.isFalse(
            comparable.isLessThan(START_OF_WEEK.addDays(-14)),
            'Expected date to be greater than 2 weeks ago'
        );
    }

    @IsTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable comparable = new NWeeksAgoComparable()
            .withToken('n_weeks_ago:3');
        Assert.isTrue(
            comparable.isGreaterThan(START_OF_WEEK.addDays(-14)),
            'Expected date to be greater than 3 weeks ago'
        );
        Assert.isFalse(
            comparable.isGreaterThan(START_OF_WEEK.addDays(-20)),
            'Expected date to be less than 2 weeks ago'
        );
    }
}
