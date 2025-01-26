/**
 * @description Comparable class for N_MONTHS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NMonthsAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today()
            .toStartOfMonth()
            .addMonths(-Integer.valueOf(nMonths));
        return fieldValue >= nMonthsAgo.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today()
            .toStartOfMonth()
            .addMonths(-Integer.valueOf(nMonths));
        return fieldValue < nMonthsAgo;
    }
}
