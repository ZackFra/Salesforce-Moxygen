/**
 * @description Comparable class for TOMORROW
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class TomorrowComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        Date tomorrow = GMT.today().addDays(1);
        return fieldValue > tomorrow.addDays(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        Date tomorrow = GMT.today().addDays(1);
        return fieldValue < tomorrow;
    }
}
