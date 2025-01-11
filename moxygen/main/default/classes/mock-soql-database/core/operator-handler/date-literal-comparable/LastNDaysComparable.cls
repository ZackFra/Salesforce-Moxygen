/**
 * @description Comparable class for LAST_N_DAYS
 * @author Zackary Frazier
 * @since 12/9/2024
 */
public with sharing class LastNDaysComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to LAST_N_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.today().addDays(-days);
        return lastNDays <= fieldValue && fieldValue < Gmt.today();
    }

    /**
     * @description Returns whether fieldValue is greater than LAST_N_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today();
    }

    /**
     * @description Returns whether fieldValue is less than LAST_N_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        String dayValue = this.token.split(':')[1];
        Integer days = Integer.valueOf(dayValue);
        DateTime lastNDays = Gmt.today().addDays(-days);
        return fieldValue < lastNDays;
    }
}
