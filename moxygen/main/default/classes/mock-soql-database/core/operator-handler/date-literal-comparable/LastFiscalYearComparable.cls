/**
 * @description Comparable for the LAST_FISCAL_YEAR date literal 
 * @author Zackary Frazier
 * @since 1/10/2025
 */
public with sharing class LastFiscalYearComparable extends DateLiteralComparable {
    /**
     * @description Returns true if the fieldValue is less than the start of the last fiscal year
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfLastFiscalYear = startOfThisFiscalYear.addYears(-1);
        return fieldValue < startOfLastFiscalYear;
    }

    /**
     * @description Returns true if the fieldValue is greater than the start of the last fiscal year
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue >= startOfThisFiscalYear;
    }
}