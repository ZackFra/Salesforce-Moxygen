/**
 * @description Comparable class for THIS_WEEK
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class ThisWeekComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return fieldValue >= startOfWeek.addDays(7);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return fieldValue < startOfWeek;
    }
}
