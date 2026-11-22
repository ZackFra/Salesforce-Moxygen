/**
 * @description Comparable class for LAST_YEAR
 * @author Zackary Frazier
 * @since 2/2/2025
 * @group Soql Engine
 */
public with sharing class LastYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfThisYear = Date.newInstance(Date.today().year(), 1, 1);
        Date startOfLastYear = startOfThisYear.addYears(-1);
        return fieldValue < startOfLastYear;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfThisYear = Date.newInstance(Date.today().year(), 1, 1);
        return fieldValue >= startOfThisYear;
    }
}
