/**
 * @description Comparable class for LAST_N_MONTHS
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class LastNMonthsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-this.n);
        return fieldValue < startOfMonth;
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-this.n);
        return fieldValue >= startOfMonth.addMonths(this.n);
    }
}
