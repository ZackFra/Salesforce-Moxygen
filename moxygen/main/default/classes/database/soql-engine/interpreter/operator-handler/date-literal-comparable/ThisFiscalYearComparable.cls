/**
 * @description Comparable for the THIS_FISCAL_YEAR token
 * @author Zackary Frazier
 * @since 1/7/2025
 * @group Soql Engine
 */
public with sharing class ThisFiscalYearComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date orgFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue >= orgFiscalYear.addYears(1);
    }

    public override Boolean isLessThan(Datetime fieldValue) {
        Date orgFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue < orgFiscalYear;
    }
}
