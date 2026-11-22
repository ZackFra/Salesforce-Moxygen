@isTest
private class ThisYearComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isFalse(
            thisYear.isLessThan(Date.today()),
            'Today should not be less than THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isLessThan(Date.today().addYears(-1)),
            'Last year should be less than THIS_YEAR'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isFalse(
            thisYear.isGreaterThan(Date.today()),
            'Today should not be greater than THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isGreaterThan(Date.today().addYears(1)),
            'Next year should be greater than THIS_YEAR'
        );
    }
}
