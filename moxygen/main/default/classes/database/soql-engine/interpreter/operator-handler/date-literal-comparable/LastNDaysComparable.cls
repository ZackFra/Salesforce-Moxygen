/**
 * @description Comparable class for LAST_N_DAYS
 * @author Zackary Frazier
 * @since 12/9/2024
 * @group Soql Engine
 */
public with sharing class LastNDaysComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today();
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.today().addDays(-days);
        return fieldValue < lastNDays;
    }
}
