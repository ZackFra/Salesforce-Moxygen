/**
 * @description Comparable class for THIS_WEEK
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class ThisWeekComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfWeek = Gmt.dateTime(Date.today().toStartOfWeek());
        return fieldValue >= startOfWeek.addDays(7);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfWeek = Gmt.dateTime(Date.today().toStartOfWeek());
        return fieldValue < startOfWeek;
    }
}
