/**
 * @description Comparable class for THIS_WEEK 
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class ThisWeekComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to THIS_WEEK
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return startOfWeek <= fieldValue && fieldValue < startOfWeek.addDays(7);
    }

    /**
     * @description Returns whether fieldValue is greater than THIS_WEEK
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return fieldValue >= startOfWeek.addDays(7);
    }

    /**
     * @description Returns whether fieldValue is less than THIS_WEEK
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfWeek = Gmt.dateTime(Gmt.today().toStartOfWeek());
        return fieldValue < startOfWeek;
    }
}