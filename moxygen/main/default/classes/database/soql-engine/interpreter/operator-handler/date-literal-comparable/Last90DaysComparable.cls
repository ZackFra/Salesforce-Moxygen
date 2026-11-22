/**
 * @description Comparable class for LAST_90_DAYS
 * @author Zackary Frazier
 * @since 12/28/2024
 * @group Soql Engine
 */
public with sharing class Last90DaysComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is greater than LAST_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue >= Date.today().addDays(1);
    }

    /**
     * @description Returns whether fieldValue is less than LAST_90_DAYS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        DateTime startOf90Days = Date.today().addDays(-90);
        return fieldValue < startOf90Days;
    }
}
