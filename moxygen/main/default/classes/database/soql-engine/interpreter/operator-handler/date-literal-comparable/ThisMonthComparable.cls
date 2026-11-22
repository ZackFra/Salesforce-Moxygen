/**
 * @description Comparable class for THIS_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class ThisMonthComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfMonth = Date.today().toStartOfMonth();
        return fieldValue >= startOfMonth.addMonths(1);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfMonth = Date.today().toStartOfMonth();
        return fieldValue < startOfMonth;
    }
}
