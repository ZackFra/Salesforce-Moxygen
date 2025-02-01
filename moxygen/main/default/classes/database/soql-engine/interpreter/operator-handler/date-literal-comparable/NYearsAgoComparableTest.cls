@isTest
private class NYearsAgoComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nYearsAgoComparable = new NYearsAgoComparable()
            .withToken('n_years_ago:2');
        Date fieldValue = Date.newInstance(Gmt.today().year() - 2, 1, 1)
            .addDays(-1);
        Assert.isTrue(
            nYearsAgoComparable.isLessThan(fieldValue),
            'Expected ' + fieldValue + ' to be less than ' + nYearsAgoComparable
        );
        fieldValue = fieldValue.addDays(1);
        Assert.isFalse(
            nYearsAgoComparable.isLessThan(fieldValue),
            'Expected ' +
                fieldValue +
                ' to not be less than ' +
                nYearsAgoComparable
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nYearsAgoComparable = new NYearsAgoComparable()
            .withToken('n_years_ago:2');
        Date fieldValue = Date.newInstance(Gmt.today().year() - 2, 1, 1)
            .addDays(-1);
        Assert.isFalse(
            nYearsAgoComparable.isGreaterThan(fieldValue),
            'Expected ' +
                fieldValue +
                ' to not be greater than ' +
                nYearsAgoComparable
        );
        fieldValue = fieldValue.addDays(1).addYears(1);
        Assert.isTrue(
            nYearsAgoComparable.isGreaterThan(fieldValue),
            'Expected ' +
                fieldValue +
                ' to be greater than ' +
                nYearsAgoComparable
        );
    }
}
