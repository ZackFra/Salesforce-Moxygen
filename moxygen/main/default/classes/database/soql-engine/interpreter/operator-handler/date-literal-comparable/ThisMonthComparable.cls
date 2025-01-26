/**
 * @description Comparable class for THIS_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class ThisMonthComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return fieldValue >= startOfMonth.addMonths(1);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return fieldValue < startOfMonth;
    }
}
