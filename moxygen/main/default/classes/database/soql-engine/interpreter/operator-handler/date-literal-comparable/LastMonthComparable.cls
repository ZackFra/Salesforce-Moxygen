/**
 * @description Comparable class for LAST_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class LastMonthComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfMonth = Date.today().toStartOfMonth().addMonths(-1);
        return fieldValue >= startOfMonth.addMonths(1);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfMonth = Date.today().toStartOfMonth().addMonths(-1);
        return fieldValue < startOfMonth;
    }
}
