/**
 * @description Comparable class for LAST_N_WEEKS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class LastNWeeksComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime lastNWeeks = Date.today().toStartOfWeek().addDays(-this.n * 7);
        return fieldValue < lastNWeeks;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue >= Date.today().toStartOfWeek();
    }
}
