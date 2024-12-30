/**
 * @description Comparable class for LAST_90_DAYS 
 * @author Zackary Frazier
 * @since 12/28/2024
 */
public with sharing class Last90DaysComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to LAST_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOf90Days = Gmt.today().addDays(-90);
        return startOf90Days <= fieldValue && fieldValue <= Gmt.now();
    }

    /**
     * @description Returns whether fieldValue is greater than LAST_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue > Gmt.now();
    }

    /**
     * @description Returns whether fieldValue is less than LAST_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOf90Days = Gmt.today().addDays(-90);
        return fieldValue < startOf90Days;
    }
}