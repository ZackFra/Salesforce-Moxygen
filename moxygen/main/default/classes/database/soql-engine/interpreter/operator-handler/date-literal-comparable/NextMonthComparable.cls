/**
 * @description Comparable class for NEXT_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextMonthComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfNextMonth = Date.today().toStartOfMonth().addMonths(1);
        return fieldValue >= startOfNextMonth.addMonths(1);
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOfNextMonth = Date.today().toStartOfMonth().addMonths(1);
        return fieldValue < startOfNextMonth;
    }
}
