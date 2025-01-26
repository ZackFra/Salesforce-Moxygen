@isTest
private class ThisYearComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isFalse(
            thisYear.isLessThan(Gmt.today()),
            'Today should not be less than THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isLessThan(Gmt.today().addYears(-1)),
            'Last year should be less than THIS_YEAR'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isFalse(
            thisYear.isGreaterThan(Gmt.today()),
            'Today should not be greater than THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isGreaterThan(Gmt.today().addYears(1)),
            'Next year should be greater than THIS_YEAR'
        );
    }
}
