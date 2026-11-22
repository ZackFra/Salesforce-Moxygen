@isTest
private class NextNYearsComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable comparable = new NextNYearsComparable()
            .withToken('next_n_years:1');
        Datetime fieldValue = noonOn(
            Date.newInstance(Date.today().year(), 1, 1)
        );

        Assert.isTrue(
            comparable.isLessThan(fieldValue),
            'Expected the field value to be less than the next n years'
        );

        fieldValue = fieldValue.addYears(1);

        Assert.isFalse(
            comparable.isLessThan(fieldValue),
            'Expected the field value not to be less than the next n years'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable comparable = new NextNYearsComparable()
            .withToken('next_n_years:1');
        Datetime fieldValue = noonOn(
            Date.newInstance(Date.today().year(), 1, 1)
        );

        Assert.isFalse(
            comparable.isGreaterThan(fieldValue),
            'Expected the field value not to be greater than the next n years'
        );

        fieldValue = fieldValue.addYears(2);

        Assert.isTrue(
            comparable.isGreaterThan(fieldValue),
            'Expected the field value to be greater than the next n years'
        );
    }

    static Datetime noonOn(Date day) {
        return Datetime.newInstance(day, Time.newInstance(12, 0, 0, 0));
    }
}
