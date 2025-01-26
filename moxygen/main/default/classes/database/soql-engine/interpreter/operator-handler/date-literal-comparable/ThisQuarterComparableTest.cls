@isTest
private class ThisQuarterComparableTest {
    static Datetime firstMonthOfThisQuarter = Gmt.startOfThisCalendarQuarter();
    static Datetime secondMonthOfThisQuarter = firstMonthOfThisQuarter.addMonths(
        1
    );
    static Datetime thirdMonthOfThisQuarter = firstMonthOfThisQuarter.addMonths(
        2
    );

    static Datetime monthBeforeThisQuarter = firstMonthOfThisQuarter.addMonths(
        -1
    );
    static Datetime monthAfterThisQuarter = thirdMonthOfThisQuarter.addMonths(
        1
    );

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
