/**
 * @description Compares a date to N months in the future
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class NextNMonthsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNextMonth = Date.today().toStartOfMonth().addMonths(1);
        return fieldValue < startOfNextMonth;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date endOfNextNMonths = Date.today().toStartOfMonth().addMonths(this.n);
        return fieldValue >= endOfNextNMonths.addMonths(1);
    }
}
