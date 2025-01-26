/**
 * @description Comparable for THIS_YEAR
 * @author Zackary Frazier
 * @since 1/4/2025
 * @group Soql Engine
 */
public with sharing class ThisYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue.yearGmt() < Gmt.today().year();
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue.yearGmt() > Gmt.today().year();
    }
}
