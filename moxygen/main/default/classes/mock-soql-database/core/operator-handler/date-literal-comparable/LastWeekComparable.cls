/**
 * @description Comparable class for LAST_WEEK 
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class LastWeekComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to LAST_WEEK
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(-7);
        return startOfWeek <= fieldValue && fieldValue < startOfWeek.addDays(7);
    }

    /**
     * @description Returns whether fieldValue is greater than LAST_WEEK
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(-7);
        return fieldValue >= startOfWeek.addDays(7);
    }

    /**
     * @description Returns whether fieldValue is less than LAST_WEEK
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.today().toStartOfWeek().addDays(-7);
        return fieldValue < startOfWeek;
    }
}