/**
 * @description Comparable class for NEXT_N_DAYS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextNDaysComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue < Date.today().addDays(1);
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime nextNDays = Date.today().addDays(this.n);
        return fieldValue >= nextNDays.addDays(1);
    }
}
