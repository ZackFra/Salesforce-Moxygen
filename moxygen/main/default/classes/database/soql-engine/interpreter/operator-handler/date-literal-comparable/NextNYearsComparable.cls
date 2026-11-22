/**
 * @description Comparable for NEXT_N_YEARS
 * @author Zackary Frazier
 * @since 2/5/2025
 * @group Soql Engine
 */
public with sharing class NextNYearsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Datetime nextYear = Datetime.newInstanceGmt(
            Date.today().year() + 1,
            1,
            1
        );
        return fieldValue < nextYear;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Datetime nextNYears = Datetime.newInstanceGmt(
            Date.today().year() + 1 + this.n,
            1,
            1
        );
        return fieldValue >= nextNYears;
    }
}
