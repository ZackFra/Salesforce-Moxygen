@isTest
private class ThisQuarterComparableTest {
    static Datetime firstMonthOfThisQuarter = Gmt.startOfThisCalendarQuarter();
    static Datetime secondMonthOfThisQuarter = firstMonthOfThisQuarter.addMonths(1);
    static Datetime thirdMonthOfThisQuarter = firstMonthOfThisQuarter.addMonths(2);

    static Datetime monthBeforeThisQuarter = firstMonthOfThisQuarter.addMonths(-1);
    static Datetime monthAfterThisQuarter = thirdMonthOfThisQuarter.addMonths(1);

    @isTest
    static void ensureIsEqualWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isTrue(thisQuarterComparable.isEqual(firstMonthOfThisQuarter), 'First month of this quarter should be equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isEqual(secondMonthOfThisQuarter), 'Second month of this quarter should be equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isEqual(thirdMonthOfThisQuarter), 'Third month of this quarter should be equal to this quarter');
        Assert.isFalse(thisQuarterComparable.isEqual(monthBeforeThisQuarter), 'Month before this quarter should not be equal to this quarter');
        Assert.isFalse(thisQuarterComparable.isEqual(monthAfterThisQuarter), 'Month after this quarter should not be equal to this quarter');
    }

    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isFalse(thisQuarterComparable.isLessThan(firstMonthOfThisQuarter), 'First month of this quarter should not be less than this quarter');
        Assert.isFalse(thisQuarterComparable.isLessThan(secondMonthOfThisQuarter), 'Second month of this quarter should be less than this quarter');
        Assert.isFalse(thisQuarterComparable.isLessThan(thirdMonthOfThisQuarter), 'Third month of this quarter should be less than this quarter');
        Assert.isTrue(thisQuarterComparable.isLessThan(monthBeforeThisQuarter), 'Month before this quarter should be less than this quarter');
        Assert.isFalse(thisQuarterComparable.isLessThan(monthAfterThisQuarter), 'Month after this quarter should not be less than this quarter');
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isFalse(thisQuarterComparable.isGreaterThan(firstMonthOfThisQuarter), 'First month of this quarter should not be greater than this quarter');
        Assert.isFalse(thisQuarterComparable.isGreaterThan(secondMonthOfThisQuarter), 'Second month of this quarter should not be greater than this quarter');
        Assert.isFalse(thisQuarterComparable.isGreaterThan(thirdMonthOfThisQuarter), 'Third month of this quarter should not be greater than this quarter');
        Assert.isFalse(thisQuarterComparable.isGreaterThan(monthBeforeThisQuarter), 'Month before this quarter should not be greater than this quarter');
        Assert.isTrue(thisQuarterComparable.isGreaterThan(monthAfterThisQuarter), 'Month after this quarter should be greater than this quarter');
    }

    @isTest
    static void ensureIsLessThanOrEqualWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isTrue(thisQuarterComparable.isLessThanOrEqual(firstMonthOfThisQuarter), 'First month of this quarter should be less than or equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isLessThanOrEqual(secondMonthOfThisQuarter), 'Second month of this quarter should be less than or equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isLessThanOrEqual(thirdMonthOfThisQuarter), 'Third month of this quarter should be less than or equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isLessThanOrEqual(monthBeforeThisQuarter), 'Month before this quarter should be less than or equal to this quarter');
        Assert.isFalse(thisQuarterComparable.isLessThanOrEqual(monthAfterThisQuarter), 'Month after this quarter should not be less than or equal to this quarter');
    }

    @isTest
    static void ensureIsGreaterThanOrEqualWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isTrue(thisQuarterComparable.isGreaterThanOrEqual(firstMonthOfThisQuarter), 'First month of this quarter should be greater than or equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isGreaterThanOrEqual(secondMonthOfThisQuarter), 'Second month of this quarter should be greater than or equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isGreaterThanOrEqual(thirdMonthOfThisQuarter), 'Third month of this quarter should be greater than or equal to this quarter');
        Assert.isFalse(thisQuarterComparable.isGreaterThanOrEqual(monthBeforeThisQuarter), 'Month before this quarter should not be greater than or equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isGreaterThanOrEqual(monthAfterThisQuarter), 'Month after this quarter should be greater than or equal to this quarter');
    }

    @isTest
    static void ensureIsNotEqualWorks() {
        DateLiteralComparable thisQuarterComparable = new ThisQuarterComparable();
        Assert.isFalse(thisQuarterComparable.isNotEqual(firstMonthOfThisQuarter), 'First month of this quarter should not be not equal to this quarter');
        Assert.isFalse(thisQuarterComparable.isNotEqual(secondMonthOfThisQuarter), 'Second month of this quarter should not be not equal to this quarter');
        Assert.isFalse(thisQuarterComparable.isNotEqual(thirdMonthOfThisQuarter), 'Third month of this quarter should not be not equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isNotEqual(monthBeforeThisQuarter), 'Month before this quarter should be not equal to this quarter');
        Assert.isTrue(thisQuarterComparable.isNotEqual(monthAfterThisQuarter), 'Month after this quarter should be not equal to this quarter');
    }
}