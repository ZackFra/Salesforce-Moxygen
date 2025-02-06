/**
 * @description Comparable class for NEXT_N_WEEKS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextNWeeksComparable extends DateLiteralComparable {
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today().toStartOfWeek().addDays(7);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime nextNWeeks = Gmt.today().toStartOfWeek().addDays(this.n * 7);
        return fieldValue >= nextNWeeks.addDays(1);
    }
}
