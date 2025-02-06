/**
 * @description Comparable for NEXT_N_YEARS
 * @author Zackary Frazier
 * @since 2/5/2025
 * @group Soql Engine
 */
public with sharing class NextNYearsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime nextYear = Datetime.newInstanceGmt(
            Gmt.today().year() + 1,
            1,
            1
        );
        return fieldValue < nextYear;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        String tkn = this.token.split(':')[1];
        Integer n = Integer.valueOf(tkn);
        Datetime nextNYears = Datetime.newInstanceGmt(
            Gmt.today().year() + 1 + n,
            1,
            1
        );
        return fieldValue >= nextNYears;
    }
}
