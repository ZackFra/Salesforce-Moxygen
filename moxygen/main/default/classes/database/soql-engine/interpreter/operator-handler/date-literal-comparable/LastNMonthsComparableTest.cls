@isTest
private class LastNMonthsComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastNMonthsComparable = new LastNMonthsComparable()
            .withToken('last_n_months:2');

        Date startOfThisMonth = Gmt.today().toStartOfMonth();
        Date startOfLastMonth = startOfThisMonth.addMonths(-1);
        Date startOfTwoMonthsAgo = startOfThisMonth.addMonths(-2);
        Date startOfThreeMonthsAgo = startOfThisMonth.addMonths(-3);

        Assert.isFalse(
            lastNMonthsComparable.isLessThan(startOfThisMonth),
            'This month should not be less than LAST_N_MONTHS:2'
        );
        Assert.isFalse(
            lastNMonthsComparable.isLessThan(startOfLastMonth),
            'Last month should not be less than LAST_N_MONTHS:2'
        );
        Assert.isFalse(
            lastNMonthsComparable.isLessThan(startOfTwoMonthsAgo),
            'Two months ago should not be less than LAST_N_MONTHS:2'
        );
        Assert.isTrue(
            lastNMonthsComparable.isLessThan(startOfThreeMonthsAgo),
            'Three months ago should be less than LAST_N_MONTHS:2'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastNMonthsComparable = new LastNMonthsComparable()
            .withToken('last_n_months:2');

        Date startOfThisMonth = Gmt.today().toStartOfMonth();
        Date startOfLastMonth = startOfThisMonth.addMonths(-1);
        Date startOfTwoMonthsAgo = startOfThisMonth.addMonths(-2);
        Date startOfThreeMonthsAgo = startOfThisMonth.addMonths(-3);

        Assert.isTrue(
            lastNMonthsComparable.isGreaterThan(startOfThisMonth),
            'This month should be greater than LAST_N_MONTHS:2'
        );
        Assert.isFalse(
            lastNMonthsComparable.isGreaterThan(startOfLastMonth),
            'Last month should not be greater than LAST_N_MONTHS:2'
        );
        Assert.isFalse(
            lastNMonthsComparable.isGreaterThan(startOfTwoMonthsAgo),
            'Two months ago should not be greater than LAST_N_MONTHS:2'
        );
        Assert.isFalse(
            lastNMonthsComparable.isGreaterThan(startOfThreeMonthsAgo),
            'Three months ago should not be greater than LAST_N_MONTHS:2'
        );
    }
}
