/**
 * @description Comparable class for NEXT_90_DAYS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class Next90DaysComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime next90Days = Date.today().addDays(90);
        return fieldValue > next90Days;
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue < Date.today();
    }
}
