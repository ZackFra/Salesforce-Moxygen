/**
 * @description Comparable class for N_DAYS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NDaysAgoComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to N_DAYS_AGO
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        String nDaysValue = this.token.split(':')[1];
        Integer nDays = Integer.valueOf(nDaysValue);
        DateTime nDaysAgo = Gmt.today().addDays(-nDays);
        return nDaysAgo <= fieldValue && fieldValue < Gmt.today();
    }

    /**
     * @description Returns whether fieldValue is greater than N_DAYS_AGO
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today();
    }

    /**
     * @description Returns whether fieldValue is less than N_DAYS_AGO
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        String nDaysValue = this.token.split(':')[1];
        Integer nDays = Integer.valueOf(nDaysValue);
        DateTime nDaysAgo = Gmt.today().addDays(-nDays);
        return fieldValue < nDaysAgo;
    }
}
