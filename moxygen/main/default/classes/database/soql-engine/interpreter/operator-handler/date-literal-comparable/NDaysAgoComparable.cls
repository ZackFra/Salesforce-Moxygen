/**
 * @description Comparable class for N_DAYS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NDaysAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date nDaysAgo = Date.today().addDays(-this.n);
        return fieldValue >= nDaysAgo.addDays(1);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue < Date.today().addDays(-this.n);
    }
}
