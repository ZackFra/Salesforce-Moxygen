/**
 * @description Comparable class for NEXT_90_DAYS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class Next90DaysComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to NEXT_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime next90Days = Gmt.today().addDays(90);
        DateTime startTime = Gmt.today();
        return startTime <= fieldValue && fieldValue <= next90Days;
    }

    /**
     * @description Returns whether fieldValue is greater than NEXT_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime next90Days = Gmt.today().addDays(90);
        return fieldValue > next90Days;
    }

    /**
     * @description Returns whether fieldValue is less than NEXT_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today();
    }
}
