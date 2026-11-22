@isTest
private class NextNQuartersComparableTest {
    static Datetime noon(Datetime gmtInstant) {
        return Datetime.newInstance(
            gmtInstant.dateGmt(),
            Time.newInstance(12, 0, 0, 0)
        );
    }

    @isTest
    static void ensuresIsLessThanWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');

        Assert.isTrue(
            nextNQuarters.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(3).addDays(-1)
            ),
            'isLessThan should return true when fieldValue is not in the next quarter'
        );

        Assert.isFalse(
            nextNQuarters.isLessThan(
                noon(Gmt.startOfThisCalendarQuarter()).addMonths(3 * 5)
            ),
            'isLessThan should return false when fieldValue is in the next 5 quarters'
        );
    }

    @isTest
    static void ensuresIsGreaterThanWorks() {
        DateLiteralComparable nextNQuarters = new NextNQuartersComparable()
            .withToken('NEXT_N_QUARTERS:5');
        Datetime startOfNextQuarter = noon(Gmt.startOfThisCalendarQuarter())
            .addMonths(3);
        Assert.isTrue(
            nextNQuarters.isGreaterThan(startOfNextQuarter.addMonths(3 * 5)),
            'isGreaterThan should return true when fieldValue is not in the next 5 quarters'
        );

        Assert.isFalse(
            nextNQuarters.isGreaterThan(
                startOfNextQuarter.addMonths(3 * 5).addDays(-1)
            ),
            'isGreaterThan should return false when fieldValue is in the next 5 quarters'
        );
    }
}
