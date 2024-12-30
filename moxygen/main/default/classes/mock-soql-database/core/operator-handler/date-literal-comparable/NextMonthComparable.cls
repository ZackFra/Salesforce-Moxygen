/**
 * @description Comparable class for NEXT_MONTH
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class NextMonthComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to NEXT_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return startOfNextMonth <= fieldValue && fieldValue < startOfNextMonth.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is greater than NEXT_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return fieldValue >= startOfNextMonth.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is less than NEXT_MONTH
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime startOfNextMonth = Gmt.today().toStartOfMonth().addMonths(1);
        return fieldValue < startOfNextMonth;
    }
}