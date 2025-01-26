@isTest
private class NextNWeeksComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable()
            .withToken('next_n_weeks:5');
        Assert.isTrue(
            nextNWeeksComparable.isLessThan(Gmt.today().toStartOfWeek()),
            'Start of week should be less than NEXT_N_WEEKS:5'
        );
        Assert.isTrue(
            nextNWeeksComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should be less than NEXT_N_WEEKS:5'
        );
        Assert.isTrue(
            nextNWeeksComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should be less than NEXT_N_WEEKS:5'
        );
        Assert.isFalse(
            nextNWeeksComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(35)
            ),
            '5 weeks from now should not be less than NEXT_N_WEEKS:5'
        );
        Assert.isFalse(
            nextNWeeksComparable.isLessThan(
                Gmt.today().toStartOfWeek().addDays(36)
            ),
            '5 weeks + 1 day from now should not be less than NEXT_N_WEEKS:5'
        );
        Assert.isFalse(
            nextNWeeksComparable.isLessThan(Gmt.today().addMonths(5)),
            '5 months from now should not be less than NEXT_N_WEEKS:5'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextNWeeksComparable = new NextNWeeksComparable()
            .withToken('next_n_weeks:5');
        Assert.isFalse(
            nextNWeeksComparable.isGreaterThan(Gmt.today().toStartOfWeek()),
            'Start of week should not be greater than NEXT_N_WEEKS:5'
        );
        Assert.isFalse(
            nextNWeeksComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(1)
            ),
            'Start of week + 1 day should not be greater than NEXT_N_WEEKS:5'
        );
        Assert.isFalse(
            nextNWeeksComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(6)
            ),
            'Start of week + 6 days should not be greater than NEXT_N_WEEKS:5'
        );
        Assert.isFalse(
            nextNWeeksComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(35)
            ),
            '5 weeks from now should not be greater than NEXT_N_WEEKS:5'
        );
        Assert.isTrue(
            nextNWeeksComparable.isGreaterThan(
                Gmt.today().toStartOfWeek().addDays(36)
            ),
            '5 weeks + 1 day from now should be greater than NEXT_N_WEEKS:5'
        );
        Assert.isTrue(
            nextNWeeksComparable.isGreaterThan(Gmt.today().addMonths(5)),
            '5 months from now should be greater than NEXT_N_WEEKS:5'
        );
    }
}
