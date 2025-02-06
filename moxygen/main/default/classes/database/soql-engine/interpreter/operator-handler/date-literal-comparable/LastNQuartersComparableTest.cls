@isTest
private class LastNQuartersComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable lastNQuartersComparable = new LastNQuartersComparable()
            .withToken('last_n_quarters:1');
        Datetime fieldValue = Gmt.today().addMonths(-6);
        Assert.isTrue(
            lastNQuartersComparable.isLessThan(fieldValue),
            'Expected to be less than'
        );

        fieldValue = Gmt.today();
        Assert.isFalse(
            lastNQuartersComparable.isLessThan(fieldValue),
            'Expected to be greater than'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable lastNQuartersComparable = new LastNQuartersComparable()
            .withToken('last_n_quarters:1');
        Datetime fieldValue = Gmt.today().addMonths(-6);
        Assert.isFalse(
            lastNQuartersComparable.isGreaterThan(fieldValue),
            'Expected to be less than'
        );

        fieldValue = Gmt.today();
        Assert.isTrue(
            lastNQuartersComparable.isGreaterThan(fieldValue),
            'Expected to be greater than'
        );
    }
}
