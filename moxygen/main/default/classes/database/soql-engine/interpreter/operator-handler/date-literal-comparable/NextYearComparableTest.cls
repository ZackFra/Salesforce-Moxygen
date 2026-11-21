@IsTest
private class NextYearComparableTest {
    @IsTest
    static void ensureIsLessThanWorks() {
        NextYearComparable comparable = new NextYearComparable();
        Date startOfNextYear = Date.newInstance(Gmt.today().year() + 1, 1, 1);

        Assert.isTrue(
            comparable.isLessThan(startOfNextYear.addDays(-1)),
            'This year should be less than NEXT_YEAR'
        );
        Assert.isFalse(
            comparable.isLessThan(startOfNextYear),
            'The first day of next year should not be less than NEXT_YEAR'
        );
    }

    @IsTest
    static void ensureIsGreaterThanWorks() {
        NextYearComparable comparable = new NextYearComparable();
        Date startOfYearAfterNext = Date.newInstance(
            Gmt.today().year() + 2,
            1,
            1
        );

        Assert.isFalse(
            comparable.isGreaterThan(startOfYearAfterNext.addDays(-1)),
            'Next year should not be greater than NEXT_YEAR'
        );
        Assert.isTrue(
            comparable.isGreaterThan(startOfYearAfterNext),
            'The year after next should be greater than NEXT_YEAR'
        );
    }
}
