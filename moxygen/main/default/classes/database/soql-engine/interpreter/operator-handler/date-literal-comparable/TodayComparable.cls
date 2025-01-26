/**
 * @description Comparable class for TODAY
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class TodayComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return fieldValue >= today.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return fieldValue < today;
    }
}
