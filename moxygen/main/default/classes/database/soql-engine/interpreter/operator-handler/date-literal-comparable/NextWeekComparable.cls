/**
 * @description Comparable class for NEXT_WEEK
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextWeekComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(7);
        return fieldValue >= startOfWeek.addDays(7);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(7);
        return fieldValue < startOfWeek;
    }
}
