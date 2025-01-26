/**
 * @description Comparable class for LAST_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class LastMonthComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to LAST_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-1);
        return startOfMonth <= fieldValue &&
            fieldValue < startOfMonth.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is greater than LAST_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-1);
        return fieldValue >= startOfMonth.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is less than LAST_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfMonth = Gmt.today().toStartOfMonth().addMonths(-1);
        return fieldValue < startOfMonth;
    }
}
