@isTest
private class NextNDaysComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable()
            .withToken('next_n_days:5');
        Assert.isTrue(
            nextNDaysComparable.isLessThan(Gmt.today().addDays(-7)),
            'Last week should be less than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isLessThan(Gmt.today().addDays(-1)),
            'Yesterday should be less than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isLessThan(Gmt.today()),
            'Date should be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Gmt.today().addDays(1)),
            'Date + 1 day should not be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Gmt.today().addDays(4)),
            'Date + 4 days should not be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Gmt.today().addDays(5)),
            '5 days from now should not be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Gmt.today().addDays(6)),
            '5 days + 1 day from now should not be less than NEXT_N_DAYS:5'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable()
            .withToken('next_n_days:5');
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Gmt.today()),
            'Date should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Gmt.today().addDays(1)),
            'Date + 1 day should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Gmt.today().addDays(4)),
            'Date + 4 days should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Gmt.today().addDays(5)),
            '5 days from now should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isGreaterThan(Gmt.today().addDays(6)),
            '5 days + 1 day from now should be greater than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isGreaterThan(Gmt.today().addMonths(5)),
            '5 months from now should be greater than NEXT_N_DAYS:5'
        );
    }
}
