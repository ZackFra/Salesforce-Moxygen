/**
 * @description Comparable class for N_MONTHS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NMonthsAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime nMonthsAgo = Date.today().toStartOfMonth().addMonths(-this.n);
        return fieldValue >= nMonthsAgo.addMonths(1);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime nMonthsAgo = Date.today().toStartOfMonth().addMonths(-this.n);
        return fieldValue < nMonthsAgo;
    }
}
