@isTest
private class LastNYearsComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable dateLiteralComparable = new LastNYearsComparable()
            .withToken('last_n_years:1');
        Date startOfThisYear = Date.newInstance(Gmt.today().year(), 1, 1);
        Date startOfLastYear = startOfThisYear.addYears(-1);
        Date startOfLastYearMinusOneDay = startOfLastYear.addDays(-1);
        Assert.isFalse(
            dateLiteralComparable.isLessThan(startOfThisYear),
            'Start of this year should not be less than the last year'
        );
        Assert.isFalse(
            dateLiteralComparable.isLessThan(startOfLastYear),
            'Start of last year should not be less than the last year'
        );
        Assert.isTrue(
            dateLiteralComparable.isLessThan(startOfLastYearMinusOneDay),
            'Start of last year minus one day should be less than the last year'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable dateLiteralComparable = new LastNYearsComparable()
            .withToken('last_n_years:1');
        Date startOfThisYear = Date.newInstance(Gmt.today().year(), 1, 1);
        Date startOfLastYear = startOfThisYear.addYears(-1);
        Date startOfThisYearMinusOne = startOfThisYear.addDays(-1);

        Assert.isTrue(
            dateLiteralComparable.isGreaterThan(startOfThisYear),
            'Start of this year should be greater than the last year'
        );
        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(startOfLastYear),
            'Start of last year should not be greater than the last year'
        );
        Assert.isFalse(
            dateLiteralComparable.isGreaterThan(startOfThisYearMinusOne),
            'Start of this year minus one day should not be greater than the last year'
        );
    }
}
