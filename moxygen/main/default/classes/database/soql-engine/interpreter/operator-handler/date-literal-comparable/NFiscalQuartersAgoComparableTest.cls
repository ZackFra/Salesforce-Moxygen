@IsTest
private class NFiscalQuartersAgoComparableTest {
    @IsTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable comparable = new NFiscalQuartersAgoComparable()
            .withToken('n_fiscal_quarters_ago:2');
        Date thisQuarter = Gmt.startOfthisFiscalQuarter();

        Assert.isFalse(
            comparable.isLessThan(thisQuarter),
            'This fiscal quarter should not be less than N_FISCAL_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            comparable.isLessThan(thisQuarter.addMonths(-6)),
            'Two fiscal quarters ago should not be less than N_FISCAL_QUARTERS_AGO:2'
        );
        Assert.isTrue(
            comparable.isLessThan(thisQuarter.addMonths(-9)),
            'Three fiscal quarters ago should be less than N_FISCAL_QUARTERS_AGO:2'
        );
    }

    @IsTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable comparable = new NFiscalQuartersAgoComparable()
            .withToken('n_fiscal_quarters_ago:2');
        Date thisQuarter = Gmt.startOfthisFiscalQuarter();

        Assert.isTrue(
            comparable.isGreaterThan(thisQuarter),
            'This fiscal quarter should be greater than N_FISCAL_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            comparable.isGreaterThan(thisQuarter.addMonths(-6)),
            'Two fiscal quarters ago should not be greater than N_FISCAL_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            comparable.isGreaterThan(thisQuarter.addMonths(-9)),
            'Three fiscal quarters ago should not be greater than N_FISCAL_QUARTERS_AGO:2'
        );
    }
}
