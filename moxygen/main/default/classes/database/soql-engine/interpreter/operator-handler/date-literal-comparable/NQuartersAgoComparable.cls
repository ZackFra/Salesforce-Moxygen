/**
 * @description Comparable class for N_QUARTERS_AGO
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class NQuartersAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime nQuartersAgo = Gmt.startOfThisCalendarQuarter()
            .addMonths(-3 * this.n);
        return fieldValue >= nQuartersAgo.addMonths(3);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime nQuartersAgo = Gmt.startOfThisCalendarQuarter()
            .addMonths(-3 * this.n);
        return fieldValue < nQuartersAgo;
    }
}
