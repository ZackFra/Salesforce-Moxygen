/**
 * @description Comparable class for LAST_N_DAYS
 * @author Zackary Frazier
 * @since 12/9/2024
 * @group Soql Engine
 */
public with sharing class LastNDaysComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today();
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime lastNDays = Gmt.today().addDays(-this.n);
        return fieldValue < lastNDays;
    }
}
