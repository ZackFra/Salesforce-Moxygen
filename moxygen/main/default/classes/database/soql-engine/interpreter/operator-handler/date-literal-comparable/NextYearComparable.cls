/**
 * @description Comparable for NEXT_YEAR
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class NextYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfNextYear = Date.newInstance(Gmt.today().year() + 1, 1, 1);
        return fieldValue < startOfNextYear;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfYearAfterNext = Date.newInstance(
            Gmt.today().year() + 2,
            1,
            1
        );
        return fieldValue >= startOfYearAfterNext;
    }
}
