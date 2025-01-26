/**
 * @description Comparable class for TODAY
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class TodayComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to TODAY
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return today <= fieldValue && fieldValue < today.addDays(1);
    }

    /**
     * @description Returns whether fieldValue is greater than TODAY
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return fieldValue >= today.addDays(1);
    }

    /**
     * @description Returns whether fieldValue is less than TODAY
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        DateTime today = Gmt.today();
        return fieldValue < today;
    }
}
