@isTest
private class LastYearComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        LastYearComparable lastYearComparable = new LastYearComparable();
        Date startOfThisYear = Date.newInstance(Gmt.today().year(), 1, 1);
        Date startOfLastYear = startOfThisYear.addYears(-1);
        Date startOfLastYearMinusOne = startOfLastYear.addDays(-1);

        Assert.isTrue(
            lastYearComparable.isLessThan(startOfLastYearMinusOne),
            'LastYearComparable.isLessThan should return true when fieldValue is less than startOfLastYear'
        );

        Assert.isFalse(
            lastYearComparable.isLessThan(startOfLastYear),
            'LastYearComparable.isLessThan should return false when fieldValue is equal to startOfLastYear'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        LastYearComparable lastYearComparable = new LastYearComparable();
        Date startOfThisYear = Date.newInstance(Gmt.today().year(), 1, 1);
        Date startOfThisYearMinusOne = startOfThisYear.addDays(-1);

        Assert.isFalse(
            lastYearComparable.isGreaterThan(startOfThisYearMinusOne),
            'LastYearComparable.isGreaterThan should return false when fieldValue is less than startOfLastYear'
        );

        Assert.isTrue(
            lastYearComparable.isGreaterThan(startOfThisYear),
            'LastYearComparable.isGreaterThan should return true when fieldValue is equal to startOfLastYear'
        );
    }
}
