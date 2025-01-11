@isTest
private class NextMonthComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable nextMonthComparable = new NextMonthComparable();
        Assert.isFalse(
            nextMonthComparable.isEqual(Gmt.today().toStartOfMonth()),
            'Start of month should not be equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isEqual(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should not be equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isEqual(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should not be equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isEqual(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should be equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isEqual(
                Gmt.today().toStartOfMonth().addMonths(1).addDays(15)
            ),
            'Middle of next month should be equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isEqual(
                Gmt.today().toStartOfMonth().addMonths(2)
            ),
            'Start of month after next should not be equal to NEXT_MONTH'
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nextMonthComparable = new NextMonthComparable();
        Assert.isTrue(
            nextMonthComparable.isLessThan(Gmt.today().toStartOfMonth()),
            'Start of month should be less than NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isLessThan(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should be less than NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isLessThan(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should be less than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isLessThan(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should not be less than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isLessThan(
                Gmt.today().toStartOfMonth().addMonths(1).addDays(15)
            ),
            'Middle of next month should not be less than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isLessThan(
                Gmt.today().toStartOfMonth().addMonths(2)
            ),
            'Start of month after next should not be less than NEXT_MONTH'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nextMonthComparable = new NextMonthComparable();
        Assert.isFalse(
            nextMonthComparable.isGreaterThan(Gmt.today().toStartOfMonth()),
            'Start of month should not be greater than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isGreaterThan(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should not be greater than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isGreaterThan(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should not be greater than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isGreaterThan(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should not be greater than NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isGreaterThan(
                Gmt.today().toStartOfMonth().addMonths(1).addDays(15)
            ),
            'Middle of next month should not be greater than NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isGreaterThan(
                Gmt.today().toStartOfMonth().addMonths(2)
            ),
            'Start of month after next should be greater than NEXT_MONTH'
        );
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable nextMonthComparable = new NextMonthComparable();
        Assert.isTrue(
            nextMonthComparable.isLessThanOrEqual(Gmt.today().toStartOfMonth()),
            'Start of month should be less than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isLessThanOrEqual(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should be less than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isLessThanOrEqual(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should be less than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isLessThanOrEqual(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should be less than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isLessThanOrEqual(
                Gmt.today().toStartOfMonth().addMonths(1).addDays(15)
            ),
            'Middle of next month should be less than or equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isLessThanOrEqual(
                Gmt.today().toStartOfMonth().addMonths(2)
            ),
            'Start of month after next should not be less than or equal to NEXT_MONTH'
        );
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable nextMonthComparable = new NextMonthComparable();
        Assert.isFalse(
            nextMonthComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfMonth()
            ),
            'Start of month should not be greater than or equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should not be greater than or equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should not be greater than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should be greater than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfMonth().addMonths(1).addDays(15)
            ),
            'Middle of next month should be greater than or equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isGreaterThanOrEqual(
                Gmt.today().toStartOfMonth().addMonths(2)
            ),
            'Start of month after next should be greater than or equal to NEXT_MONTH'
        );
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable nextMonthComparable = new NextMonthComparable();
        Assert.isTrue(
            nextMonthComparable.isNotEqual(Gmt.today().toStartOfMonth()),
            'Start of month should not be equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isNotEqual(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should not be equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isNotEqual(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should not be equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isNotEqual(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should not be equal to NEXT_MONTH'
        );
        Assert.isFalse(
            nextMonthComparable.isNotEqual(
                Gmt.today().toStartOfMonth().addMonths(1).addDays(15)
            ),
            'Middle of next month should not be equal to NEXT_MONTH'
        );
        Assert.isTrue(
            nextMonthComparable.isNotEqual(
                Gmt.today().toStartOfMonth().addMonths(2)
            ),
            'Start of month after next should not be equal to NEXT_MONTH'
        );
    }
}
