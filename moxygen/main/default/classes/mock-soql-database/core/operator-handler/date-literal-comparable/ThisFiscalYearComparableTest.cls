@isTest
private class ThisFiscalYearComparableTest {

    @isTest
    static void ensureIsEqualWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date endOfThisFiscalYear = startOfThisFiscalYear.addYears(1).addDays(-1);
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isTrue(thisFiscalYearComparable.isEqual(startOfThisFiscalYear), 'Start of this fiscal year should be equal');
        Assert.isTrue(thisFiscalYearComparable.isEqual(endOfThisFiscalYear), 'End of this fiscal year should be equal');
        Assert.isFalse(thisFiscalYearComparable.isEqual(startOfNextFiscalYear), 'Start of next fiscal year should not be equal');
    }

    @IsTest
    static void ensureIsLessThanWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        Date dateBeforeThisFiscalYear = startOfThisFiscalYear.addDays(-1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isTrue(thisFiscalYearComparable.isLessThan(dateBeforeThisFiscalYear), 'End of this fiscal year should be greater');
        Assert.isFalse(thisFiscalYearComparable.isLessThan(startOfThisFiscalYear), 'Start of this fiscal year should not be less');
        Assert.isFalse(thisFiscalYearComparable.isLessThan(startOfNextFiscalYear), 'Start of next fiscal year should not be less');
    }

    @IsTest
    static void ensureIsGreaterThanWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date endOfThisFiscalYear = startOfThisFiscalYear.addYears(1).addDays(-1);
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isFalse(thisFiscalYearComparable.isGreaterThan(startOfThisFiscalYear), 'Start of this fiscal year should be less');
        Assert.isFalse(thisFiscalYearComparable.isGreaterThan(endOfThisFiscalYear), 'End of this fiscal year should not be greater');
        Assert.isTrue(thisFiscalYearComparable.isGreaterThan(startOfNextFiscalYear), 'Start of next fiscal year should not be greater');
    }

    @IsTest
    static void ensureIsLessThanOrEqualWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date endOfThisFiscalYear = startOfThisFiscalYear.addYears(1).addDays(-1);
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isTrue(thisFiscalYearComparable.isLessThanOrEqual(endOfThisFiscalYear), 'End of this fiscal year should be greater');
        Assert.isTrue(thisFiscalYearComparable.isLessThanOrEqual(startOfThisFiscalYear), 'Start of this fiscal year should be less');
        Assert.isFalse(thisFiscalYearComparable.isLessThanOrEqual(startOfNextFiscalYear), 'Start of next fiscal year should not be less');
    }

    @IsTest
    static void ensureIsGreaterThanOrEqualWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date endOfThisFiscalYear = startOfThisFiscalYear.addYears(1).addDays(-1);
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        Date dayBeforeStartOfThisFiscalYear = startOfThisFiscalYear.addDays(-1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isTrue(thisFiscalYearComparable.isGreaterThanOrEqual(startOfThisFiscalYear), 'Start of this fiscal year should be less');
        Assert.isTrue(thisFiscalYearComparable.isGreaterThanOrEqual(endOfThisFiscalYear), 'End of this fiscal year should be greater');
        Assert.isTrue(thisFiscalYearComparable.isGreaterThanOrEqual(startOfNextFiscalYear), 'Start of next fiscal year should not be greater');
        Assert.isFalse(thisFiscalYearComparable.isGreaterThanOrEqual(dayBeforeStartOfThisFiscalYear), 'Day before start of this fiscal year should not be greater');
    }

    @IsTest
    static void ensureIsNotEqualWorks() {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date endOfThisFiscalYear = startOfThisFiscalYear.addYears(1).addDays(-1);
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);

        ThisFiscalYearComparable thisFiscalYearComparable = new ThisFiscalYearComparable();
        Assert.isFalse(thisFiscalYearComparable.isNotEqual(startOfThisFiscalYear), 'Start of this fiscal year should not be not equal');
        Assert.isFalse(thisFiscalYearComparable.isNotEqual(endOfThisFiscalYear), 'End of this fiscal year should not be not equal');
        Assert.isTrue(thisFiscalYearComparable.isNotEqual(startOfNextFiscalYear), 'Start of next fiscal year should be not equal');
    }
}