/**
 * @description Comparable class for TOMORROW
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class TomorrowComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to TOMORROW
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        Date tomorrow = GMT.today().addDays(1);
        return tomorrow <= fieldValue && fieldValue < tomorrow.addDays(1);
    }

    /**
     * @description Returns whether fieldValue is greater than TOMORROW
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        Date tomorrow = GMT.today().addDays(1);
        return fieldValue > tomorrow.addDays(1);
    }

    /**
     * @description Returns whether fieldValue is less than TOMORROW
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        Date tomorrow = GMT.today().addDays(1);
        return fieldValue < tomorrow;
    }
}
