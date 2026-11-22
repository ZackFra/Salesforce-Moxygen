@isTest
private class NextNDaysComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable()
            .withToken('next_n_days:5');
        Assert.isTrue(
            nextNDaysComparable.isLessThan(Date.today().addDays(-7)),
            'Last week should be less than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isLessThan(Date.today().addDays(-1)),
            'Yesterday should be less than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isLessThan(Date.today()),
            'Date should be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Date.today().addDays(1)),
            'Date + 1 day should not be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Date.today().addDays(4)),
            'Date + 4 days should not be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Date.today().addDays(5)),
            '5 days from now should not be less than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isLessThan(Date.today().addDays(6)),
            '5 days + 1 day from now should not be less than NEXT_N_DAYS:5'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNDaysComparable = new NextNDaysComparable()
            .withToken('next_n_days:5');
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Date.today()),
            'Date should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Date.today().addDays(1)),
            'Date + 1 day should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Date.today().addDays(4)),
            'Date + 4 days should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isFalse(
            nextNDaysComparable.isGreaterThan(Date.today().addDays(5)),
            '5 days from now should not be greater than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isGreaterThan(Date.today().addDays(6)),
            '5 days + 1 day from now should be greater than NEXT_N_DAYS:5'
        );
        Assert.isTrue(
            nextNDaysComparable.isGreaterThan(Date.today().addMonths(5)),
            '5 months from now should be greater than NEXT_N_DAYS:5'
        );
    }
}
