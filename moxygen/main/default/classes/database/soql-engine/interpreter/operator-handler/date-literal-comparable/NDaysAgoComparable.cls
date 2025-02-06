/**
 * @description Comparable class for N_DAYS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NDaysAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today();
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime nDaysAgo = Gmt.today().addDays(-this.n);
        return fieldValue < nDaysAgo;
    }
}
