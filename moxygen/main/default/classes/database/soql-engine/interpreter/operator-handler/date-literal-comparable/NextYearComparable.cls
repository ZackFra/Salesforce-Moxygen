/**
 * @description Comparable for NEXT_YEAR
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class NextYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNextYear = Date.newInstance(Date.today().year() + 1, 1, 1);
        return fieldValue < startOfNextYear;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfYearAfterNext = Date.newInstance(
            Date.today().year() + 2,
            1,
            1
        );
        return fieldValue >= startOfYearAfterNext;
    }
}
