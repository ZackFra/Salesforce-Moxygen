/**
 * @description Comparable for the THIS_FISCAL_YEAR token
 * @author Zackary Frazier
 * @since 1/7/2025
 * @group Soql Engine
 */
public with sharing class ThisFiscalYearComparable extends DateLiteralComparable {
    /**
     * @description Returns if the field value is equal to the current fiscal year
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(Datetime fieldValue) {
        Date orgFiscalYear = Gmt.startOfThisFiscalYear();
        return orgFiscalYear <= fieldValue &&
            fieldValue < orgFiscalYear.addYears(1);
    }

    /**
     * @description Returns if the field value is greater than the current fiscal year
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date orgFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue >= orgFiscalYear.addYears(1);
    }

    /**
     * @description Returns if the field value is less than the current fiscal year
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Date orgFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue < orgFiscalYear;
    }
}
