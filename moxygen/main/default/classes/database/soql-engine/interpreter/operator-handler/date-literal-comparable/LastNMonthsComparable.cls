/**
 * @description Comparable class for LAST_N_MONTHS
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class LastNMonthsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfMonth = Date.today()
            .toStartOfMonth()
            .addMonths(-this.n);
        return fieldValue < startOfMonth;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfMonth = Date.today()
            .toStartOfMonth()
            .addMonths(-this.n);
        return fieldValue >= startOfMonth.addMonths(this.n);
    }
}
