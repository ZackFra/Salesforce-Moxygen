/**
 * @description Comparable class for N_MONTHS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NMonthsAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime nMonthsAgo = Gmt.today().toStartOfMonth().addMonths(-this.n);
        return fieldValue >= nMonthsAgo.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime nMonthsAgo = Gmt.today().toStartOfMonth().addMonths(-this.n);
        return fieldValue < nMonthsAgo;
    }
}
