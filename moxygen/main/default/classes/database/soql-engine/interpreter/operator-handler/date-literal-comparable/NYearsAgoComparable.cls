/**
 * @description Comparable class for N_YEARS_AGO
 * @author Zackary Frazier
 * @since 2/1/2025
 * @group Soql Engine
 */
public with sharing class NYearsAgoComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        String yearsAgoStr = this.token.split(':')[1];
        Integer yearsAgo = Integer.valueOf(yearsAgoStr);
        Integer nYearsAgo = Gmt.today().year() - yearsAgo;
        return fieldValue < Datetime.newInstanceGmt(nYearsAgo, 1, 1);
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        String yearsAgoStr = this.token.split(':')[1];
        Integer yearsAgo = Integer.valueOf(yearsAgoStr);
        Integer nYearsAgo = Gmt.today().year() - yearsAgo;
        return fieldValue >= Datetime.newInstanceGmt(nYearsAgo + 1, 1, 1);
    }
}
