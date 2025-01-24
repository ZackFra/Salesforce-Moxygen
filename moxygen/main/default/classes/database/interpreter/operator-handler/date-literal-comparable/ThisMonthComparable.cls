/**
 * @description Comparable class for THIS_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class ThisMonthComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to THIS_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return startOfMonth <= fieldValue &&
            fieldValue < startOfMonth.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is greater than THIS_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return fieldValue >= startOfMonth.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is less than THIS_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth();
        return fieldValue < startOfMonth;
    }
}
