@isTest
private class ThisMonthComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isFalse(
            thisMonthComparator.isLessThan(Gmt.today().toStartOfMonth()),
            'Start of month should not be less than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isLessThan(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should not be less than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isLessThan(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should not be less than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isLessThan(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should not be less than THIS_MONTH'
        );
        Assert.isTrue(
            thisMonthComparator.isLessThan(
                Gmt.today().toStartOfMonth().addMonths(-1)
            ),
            'Start of last month should be less than THIS_MONTH'
        );
        Assert.isTrue(
            thisMonthComparator.isLessThan(Gmt.today().addYears(-1)),
            'Last year should be less than THIS_MONTH'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable thisMonthComparator = new ThisMonthComparable();
        Assert.isFalse(
            thisMonthComparator.isGreaterThan(Gmt.today().toStartOfMonth()),
            'Start of month should not be greater than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isGreaterThan(
                Gmt.today().toStartOfMonth().addDays(1)
            ),
            'Start of month + 1 day should not be greater than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isGreaterThan(
                Gmt.today().toStartOfMonth().addDays(25)
            ),
            'Start of month + 25 days should not be greater than THIS_MONTH'
        );
        Assert.isTrue(
            thisMonthComparator.isGreaterThan(
                Gmt.today().toStartOfMonth().addMonths(1)
            ),
            'Start of next month should be greater than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isGreaterThan(
                Gmt.today().toStartOfMonth().addMonths(-1)
            ),
            'Start of last month should not be greater than THIS_MONTH'
        );
        Assert.isFalse(
            thisMonthComparator.isGreaterThan(Gmt.today().addYears(-1)),
            'Last year should not be greater than THIS_MONTH'
        );
        Assert.isTrue(
            thisMonthComparator.isGreaterThan(Gmt.today().addYears(1)),
            'Next year should be greater than THIS_MONTH'
        );
    }
}
