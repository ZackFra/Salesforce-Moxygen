@isTest
private class ThisYearComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isTrue(
            thisYear.isEqual(Gmt.today()),
            'Today should be equal to THIS_YEAR'
        );

        Assert.isFalse(
            thisYear.isEqual(Gmt.today().addYears(1)),
            'Next year should not be equal to THIS_YEAR'
        );
    }

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

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isTrue(
            thisYear.isLessThanOrEqual(Gmt.today()),
            'Today should be less than or equal to THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isLessThanOrEqual(Gmt.today().addYears(-1)),
            'Last year should be less than or equal to THIS_YEAR'
        );

        Assert.isFalse(
            thisYear.isLessThanOrEqual(Gmt.today().addYears(1)),
            'Next year should not be less than or equal to THIS_YEAR'
        );
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isTrue(
            thisYear.isGreaterThanOrEqual(Gmt.today()),
            'Today should be greater than or equal to THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isGreaterThanOrEqual(Gmt.today().addYears(1)),
            'Next year should be greater than or equal to THIS_YEAR'
        );

        Assert.isFalse(
            thisYear.isGreaterThanOrEqual(Gmt.today().addYears(-1)),
            'Last year should not be greater than or equal to THIS_YEAR'
        );
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable thisYear = new ThisYearComparable();

        Assert.isFalse(
            thisYear.isNotEqual(Gmt.today()),
            'Today should be equal to THIS_YEAR'
        );

        Assert.isTrue(
            thisYear.isNotEqual(Gmt.today().addYears(1)),
            'Next year should not be equal to THIS_YEAR'
        );
    }
}