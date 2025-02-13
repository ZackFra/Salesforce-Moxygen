@isTest
private class NextNMonthsComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNMonthsComparable = new NextNMonthsComparable()
            .withToken('next_n_months:1');

        Date startOfThisMonth = Gmt.today().toStartOfMonth();
        Date startOfNextMonth = startOfThisMonth.addMonths(1);
        Date startOfMonthAfterNext = startOfNextMonth.addMonths(1);

        Assert.isTrue(
            nextNMonthsComparable.isLessThan(startOfThisMonth),
            'Should be less than'
        );
        Assert.isFalse(
            nextNMonthsComparable.isLessThan(startOfNextMonth),
            'Should not be less than'
        );
        Assert.isFalse(
            nextNMonthsComparable.isLessThan(startOfMonthAfterNext),
            'Should not be less than'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNMonthsComparable = new NextNMonthsComparable()
            .withToken('next_n_months:1');

        Date startOfThisMonth = Gmt.today().toStartOfMonth();
        Date startOfNextMonth = startOfThisMonth.addMonths(1);
        Date startOfMonthAfterNext = startOfNextMonth.addMonths(1);

        Assert.isFalse(
            nextNMonthsComparable.isGreaterThan(startOfThisMonth),
            'Should not be greater than'
        );
        Assert.isFalse(
            nextNMonthsComparable.isGreaterThan(startOfNextMonth),
            'Should not be greater than'
        );
        Assert.isTrue(
            nextNMonthsComparable.isGreaterThan(startOfMonthAfterNext),
            'Should be greater than'
        );
    }
}
