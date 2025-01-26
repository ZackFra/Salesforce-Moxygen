/**
 * @description Comparable class for NEXT_N_DAYS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextNDaysComparable extends DateLiteralComparable {
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today().addDays(1);
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime nextNDays = Gmt.today().addDays(days);
        return fieldValue >= nextNDays.addDays(1);
    }
}
