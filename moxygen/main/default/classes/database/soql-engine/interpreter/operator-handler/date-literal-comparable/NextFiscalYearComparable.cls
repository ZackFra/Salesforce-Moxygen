/**
 * @description Comparable for the NEXT_FISCAL_YEAR date literal
 * @author Zackary Frazier
 * @since 1/9/2025
 * @group Soql Engine
 */
public with sharing class NextFiscalYearComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNextFiscalYear = Gmt.startOfThisFiscalYear().addYears(1);
        return fieldValue < startOfNextFiscalYear;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNextFiscalYear = Gmt.startOfThisFiscalYear().addYears(1);
        return fieldValue >= startOfNextFiscalYear.addYears(1);
    }
}
