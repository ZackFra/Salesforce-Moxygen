/**
 * @description Comparable for THIS_YEAR
 * @author Zackary Frazier
 * @since 1/4/2025
 * @group Soql Engine
 */
public with sharing class ThisYearComparable extends DateLiteralComparable {
    /**
     * @description Return whether the year equals THIS_YEAR
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        return fieldValue.yearGmt() == Gmt.today().year();
    }

    /**
     * @description Return whether the year is less than THIS_YEAR
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue.yearGmt() < Gmt.today().year();
    }

    /**
     * @description Return whether the year is greater than THIS_YEAR
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue.yearGmt() > Gmt.today().year();
    }
}
