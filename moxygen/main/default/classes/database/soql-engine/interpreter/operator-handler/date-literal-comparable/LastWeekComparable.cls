/**
 * @description Comparable class for LAST_WEEK
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class LastWeekComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfWeek = Date.today().toStartOfWeek().addDays(-7);
        return fieldValue >= startOfWeek.addDays(7);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfWeek = Date.today().toStartOfWeek().addDays(-7);
        return fieldValue < startOfWeek;
    }
}
