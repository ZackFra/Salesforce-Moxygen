/**
 * @description Comparable class for NEXT_N_DAYS 
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class NextNDaysComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to NEXT_N_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime nextNDays = Gmt.today().addDays(days);
        return Gmt.today().addDays(1) <= fieldValue && fieldValue < nextNDays.addDays(1);
    }

    /**
     * @description Returns whether fieldValue is less than NEXT_N_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today().addDays(1);
    }

    /**
     * @description Returns whether fieldValue is greater than NEXT_N_DAYS
     * @param fieldValue 
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime nextNDays = Gmt.today().addDays(days);
        return fieldValue >= nextNDays.addDays(1);
    }
}