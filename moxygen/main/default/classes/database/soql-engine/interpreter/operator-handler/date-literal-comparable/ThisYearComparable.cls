/**
 * @description Comparable for THIS_YEAR
 * @author Zackary Frazier
 * @since 1/4/2025
 * @group Soql Engine
 */
public with sharing class ThisYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue.yearGmt() < Date.today().year();
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue.yearGmt() > Date.today().year();
    }
}
