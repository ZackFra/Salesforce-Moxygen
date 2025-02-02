/**
 * @description Comparable class for LAST_N_YEARS
 * @author Zackary Frazier
 * @since 2/2/2025
 * @group Soql Engine
 */
public with sharing class LastNYearsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        String nTkn = this.token.split(':')[1];
        Integer n = Integer.valueOf(nTkn);
        Date startOfThisYear = Date.newInstance(Gmt.today().year(), 1, 1);
        Date nthYear = startOfThisYear.addYears(-n);
        return fieldValue < nthYear;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisYear = Date.newInstance(Gmt.today().year(), 1, 1);
        return fieldValue >= startOfThisYear;
    }
}
