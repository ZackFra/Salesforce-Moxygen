/**
 * @description Comparable class for YESTERDAY 
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class YesterdayComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to YESTERDAY
     * @param fieldValue `DateTime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        Date yesterday = GMT.today().addDays(-1);
        return yesterday <= (DateTime) fieldValue && (DateTime) fieldValue < GMT.today();
    }

    /**
     * @description Returs whether fieldValue is greater than YESTERDAY
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return (DateTime) fieldValue >= Gmt.today();
    }

    /**
     * @description Returns whether fieldValue is less than YESTERDAY
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        Date yesterday = GMT.today().addDays(-1);
        return (DateTime) fieldValue < yesterday;
    }
}