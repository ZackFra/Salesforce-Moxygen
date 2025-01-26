/**
 * @description Comparable for the LAST_FISCAL_YEAR date literal
 * @author Zackary Frazier
 * @since 1/10/2025
 * @group Soql Engine
 */
public with sharing class LastFiscalYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfLastFiscalYear = startOfThisFiscalYear.addYears(-1);
        return fieldValue < startOfLastFiscalYear;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue >= startOfThisFiscalYear;
    }
}
