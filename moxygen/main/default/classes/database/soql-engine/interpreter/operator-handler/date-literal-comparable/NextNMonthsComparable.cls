/**
 * @description Compares a date to N months in the future
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class NextNMonthsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return fieldValue < startOfNextMonth;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date endOfNextNMonths = Gmt.today().toStartOfMonth().addMonths(this.n);
        return fieldValue >= endOfNextNMonths.addMonths(1);
    }
}
