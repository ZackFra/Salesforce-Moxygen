@isTest
private class NMonthsAgoComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable()
            .withToken('n_months_ago:5');
        Assert.isFalse(
            nMonthsAgoComparable.isLessThan(Date.today().addMonths(-1)),
            'Last month should not be less than N_MONTHS_AGO:5'
        );
        Assert.isFalse(
            nMonthsAgoComparable.isLessThan(Date.today().addMonths(-5)),
            '5 months ago should not be less than N_MONTHS_AGO:5'
        );
        Assert.isTrue(
            nMonthsAgoComparable.isLessThan(Date.today().addMonths(-6)),
            '6 months ago should be less than N_MONTHS_AGO:5'
        );
        Assert.isFalse(
            nMonthsAgoComparable.isLessThan(
                Date.today().toStartOfMonth().addMonths(-5).addDays(15)
            ),
            'Middle of 5 months ago should not be less than N_MONTHS_AGO:5'
        );
        Assert.isFalse(
            nMonthsAgoComparable.isLessThan(Date.today().addMonths(-4)),
            '4 months ago should not be less than N_MONTHS_AGO:5'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nMonthsAgoComparable = new NMonthsAgoComparable()
            .withToken('n_months_ago:5');
        Assert.isTrue(
            nMonthsAgoComparable.isGreaterThan(Date.today().addMonths(-1)),
            'Last month should be greater than N_MONTHS_AGO:5'
        );
        Assert.isFalse(
            nMonthsAgoComparable.isGreaterThan(Date.today().addMonths(-5)),
            '5 months ago should not be greater than N_MONTHS_AGO:5'
        );
        Assert.isFalse(
            nMonthsAgoComparable.isGreaterThan(Date.today().addMonths(-6)),
            '6 months ago should not be greater than N_MONTHS_AGO:5'
        );
        Assert.isFalse(
            nMonthsAgoComparable.isGreaterThan(
                Date.today().toStartOfMonth().addMonths(-5).addDays(15)
            ),
            'Middle of 5 months ago should not be greater than N_MONTHS_AGO:5'
        );
        Assert.isTrue(
            nMonthsAgoComparable.isGreaterThan(Date.today().addMonths(-4)),
            '4 months ago should be greater than N_MONTHS_AGO:5'
        );
    }
}
