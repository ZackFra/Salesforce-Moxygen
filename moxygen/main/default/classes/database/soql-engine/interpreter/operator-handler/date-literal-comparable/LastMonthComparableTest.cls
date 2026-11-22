@isTest
private class LastMonthComparableTest {
    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable lastMonthComparable = new LastMonthComparable();
        Assert.isTrue(
            lastMonthComparable.isEqual(Date.today().addMonths(-1)),
            '1 month ago should be equal to LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isEqual(Date.today()),
            'Today should not be equal to LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isEqual(Date.today().addMonths(1)),
            '1 month from now should not be equal to LAST_MONTH'
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastMonthComparable = new LastMonthComparable();
        Assert.isTrue(
            lastMonthComparable.isLessThan(Date.today().addMonths(-2)),
            '2 months ago should be less than LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isLessThan(Date.today().addMonths(-1)),
            '1 month ago should not be less than LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isLessThan(Date.today()),
            'Today should not be less than LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isLessThan(Date.today().addMonths(1)),
            '1 month from now should not be less than LAST_MONTH'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastMonthComparable = new LastMonthComparable();
        Assert.isTrue(
            lastMonthComparable.isGreaterThan(Date.today().addMonths(1)),
            '1 month from now should be greater than LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isGreaterThan(Date.today().addMonths(-1)),
            '1 month ago should not be greater than LAST_MONTH'
        );
        Assert.isTrue(
            lastMonthComparable.isGreaterThan(Date.today()),
            'Today should be greater than LAST_MONTH'
        );
    }

    @isTest
    static void ensuresIsLessThanOrEqualWorks() {
        DateLiteralComparable lastMonthComparable = new LastMonthComparable();
        Assert.isTrue(
            lastMonthComparable.isLessThanOrEqual(Date.today().addMonths(-2)),
            '2 months ago should be less than or equal to LAST_MONTH'
        );
        Assert.isTrue(
            lastMonthComparable.isLessThanOrEqual(Date.today().addMonths(-1)),
            '1 month ago should be less than or equal to LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isLessThanOrEqual(Date.today().addMonths(1)),
            '1 month from now should not be less than or equal to LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isLessThanOrEqual(Date.today()),
            'Today should not be less than or equal to LAST_MONTH'
        );
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable lastMonthComparable = new LastMonthComparable();
        Assert.isTrue(
            lastMonthComparable.isGreaterThanOrEqual(Date.today().addMonths(1)),
            '1 month from now should be greater than or equal to LAST_MONTH'
        );
        Assert.isTrue(
            lastMonthComparable.isGreaterThanOrEqual(
                Date.today().addMonths(-1)
            ),
            '1 month ago should be greater than or equal to LAST_MONTH'
        );
        Assert.isTrue(
            lastMonthComparable.isGreaterThanOrEqual(Date.today()),
            'Today should be greater than or equal to LAST_MONTH'
        );
        Assert.isFalse(
            lastMonthComparable.isGreaterThanOrEqual(
                Date.today().addMonths(-2)
            ),
            '2 months ago should not be greater than or equal to LAST_MONTH'
        );
    }

    @isTest
    static void ensuresIsNotEqualWorks() {
        DateLiteralComparable lastMonthComparable = new LastMonthComparable();
        Assert.isFalse(
            lastMonthComparable.isNotEqual(Date.today().addMonths(-1)),
            '1 month ago should not be equal to LAST_MONTH'
        );
        Assert.isTrue(
            lastMonthComparable.isNotEqual(Date.today()),
            'Today should not be equal to LAST_MONTH'
        );
        Assert.isTrue(
            lastMonthComparable.isNotEqual(Date.today().addMonths(1)),
            '1 month from now should be equal to LAST_MONTH'
        );
    }
}
