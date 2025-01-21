@isTest
private class NFiscalYearsAgoComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable comparable = new NFiscalYearsAgoComparable()
            .withToken('n_fiscal_years_ago:1');
        Datetime fieldValue = gmt.startOfThisFiscalYear().addYears(-1);
        Assert.isFalse(
            comparable.isLessThan(fieldValue),
            'Should not be less than'
        );
        Assert.isTrue(
            comparable.isLessThan(fieldValue.addDays(-1)),
            'Should be less than'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable comparable = new NFiscalYearsAgoComparable()
            .withToken('n_fiscal_years_ago:1');
        Datetime fieldValue = gmt.startOfThisFiscalYear().addYears(-1);
        Assert.isFalse(
            comparable.isGreaterThan(fieldValue),
            'Should not be greater than'
        );
        Assert.isFalse(
            comparable.isGreaterThan(fieldValue.addYears(1).addDays(-1)),
            'Should not be greater than'
        );
        Assert.isTrue(
            comparable.isGreaterThan(fieldValue.addYears(1)),
            'Should be greater than'
        );
    }
}
