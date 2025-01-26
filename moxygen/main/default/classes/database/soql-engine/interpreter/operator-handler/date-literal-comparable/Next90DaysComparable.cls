/**
 * @description Comparable class for NEXT_90_DAYS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class Next90DaysComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime next90Days = Gmt.today().addDays(90);
        return fieldValue > next90Days;
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today();
    }
}
