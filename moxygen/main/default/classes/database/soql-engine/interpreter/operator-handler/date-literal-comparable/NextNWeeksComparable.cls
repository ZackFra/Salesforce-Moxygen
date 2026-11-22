/**
 * @description Comparable class for NEXT_N_WEEKS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextNWeeksComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue < Date.today().toStartOfWeek().addDays(7);
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNextWeek = Date.today().toStartOfWeek().addDays(7);
        return fieldValue >= startOfNextWeek.addDays(this.n * 7);
    }
}
