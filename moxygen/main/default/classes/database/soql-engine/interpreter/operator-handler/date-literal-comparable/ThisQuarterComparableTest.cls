@isTest
private class ThisQuarterComparableTest {
    static Datetime quarterStart = Gmt.startOfThisCalendarQuarter();
    static Datetime firstMonthOfThisQuarter = noon(quarterStart);
    static Datetime secondMonthOfThisQuarter = noon(quarterStart.addMonths(1));
    static Datetime thirdMonthOfThisQuarter = noon(quarterStart.addMonths(2));

    static Datetime monthBeforeThisQuarter = noon(quarterStart.addMonths(-1));
    static Datetime monthAfterThisQuarter = noon(quarterStart.addMonths(3));

    static Datetime noon(Datetime gmtInstant) {
        return Datetime.newInstance(
            gmtInstant.dateGmt(),
            Time.newInstance(12, 0, 0, 0)
        );
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isFalse(
            thisQuarterComparable.isLessThan(firstMonthOfThisQuarter),
            'First month of this quarter should not be less than this quarter'
        );
        Assert.isFalse(
            thisQuarterComparable.isLessThan(secondMonthOfThisQuarter),
            'Second month of this quarter should be less than this quarter'
        );
        Assert.isFalse(
            thisQuarterComparable.isLessThan(thirdMonthOfThisQuarter),
            'Third month of this quarter should be less than this quarter'
        );
        Assert.isTrue(
            thisQuarterComparable.isLessThan(monthBeforeThisQuarter),
            'Month before this quarter should be less than this quarter'
        );
        Assert.isFalse(
            thisQuarterComparable.isLessThan(monthAfterThisQuarter),
            'Month after this quarter should not be less than this quarter'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isFalse(
            thisQuarterComparable.isGreaterThan(firstMonthOfThisQuarter),
            'First month of this quarter should not be greater than this quarter'
        );
        Assert.isFalse(
            thisQuarterComparable.isGreaterThan(secondMonthOfThisQuarter),
            'Second month of this quarter should not be greater than this quarter'
        );
        Assert.isFalse(
            thisQuarterComparable.isGreaterThan(thirdMonthOfThisQuarter),
            'Third month of this quarter should not be greater than this quarter'
        );
        Assert.isFalse(
            thisQuarterComparable.isGreaterThan(monthBeforeThisQuarter),
            'Month before this quarter should not be greater than this quarter'
        );
        Assert.isTrue(
            thisQuarterComparable.isGreaterThan(monthAfterThisQuarter),
            'Month after this quarter should be greater than this quarter'
        );
    }
}
