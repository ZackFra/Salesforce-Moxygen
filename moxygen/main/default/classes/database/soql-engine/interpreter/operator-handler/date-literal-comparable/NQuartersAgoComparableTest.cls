@isTest
private class NQuartersAgoComparableTest {
    @isTest
    static void ensureIsLessThanWorks() {
        DateLiteralComparable nQuartersAgoComparable = new NQuartersAgoComparable()
            .withToken('n_quarters_ago:2');
        Assert.isFalse(
            nQuartersAgoComparable.isLessThan(Gmt.startOfThisCalendarQuarter()),
            'This quarter should not be less than N_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            nQuartersAgoComparable.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Last quarter should not be less than N_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            nQuartersAgoComparable.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-6)
            ),
            '2 quarters ago should not be less than N_QUARTERS_AGO:2'
        );
        Assert.isTrue(
            nQuartersAgoComparable.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-9)
            ),
            '3 quarters ago should be less than N_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            nQuartersAgoComparable.isLessThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-6).addDays(45)
            ),
            'Middle of 2 quarters ago should not be less than N_QUARTERS_AGO:2'
        );
    }

    @isTest
    static void ensureIsGreaterThanWorks() {
        DateLiteralComparable nQuartersAgoComparable = new NQuartersAgoComparable()
            .withToken('n_quarters_ago:2');
        Assert.isTrue(
            nQuartersAgoComparable.isGreaterThan(
                Gmt.startOfThisCalendarQuarter()
            ),
            'This quarter should be greater than N_QUARTERS_AGO:2'
        );
        Assert.isTrue(
            nQuartersAgoComparable.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-3)
            ),
            'Last quarter should be greater than N_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            nQuartersAgoComparable.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-6)
            ),
            '2 quarters ago should not be greater than N_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            nQuartersAgoComparable.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-9)
            ),
            '3 quarters ago should not be greater than N_QUARTERS_AGO:2'
        );
        Assert.isFalse(
            nQuartersAgoComparable.isGreaterThan(
                Gmt.startOfThisCalendarQuarter().addMonths(-6).addDays(45)
            ),
            'Middle of 2 quarters ago should not be greater than N_QUARTERS_AGO:2'
        );
    }
}
