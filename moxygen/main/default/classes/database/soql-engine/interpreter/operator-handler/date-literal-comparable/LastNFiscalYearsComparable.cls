/**
 * @description Comparable class for LAST_N_FISCAL_YEARS
 * @author Zackary Frazier
 * @since 1/8/2025
 * @group Soql Engine
 */
public with sharing class LastNFiscalYearsComparable extends DateLiteralComparable {
    /**
     * @description Returns if the field value is equal to LAST_N_FISCAL_YEARS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(Datetime fieldValue) {
        Datetime thisFiscalYear = Gmt.startOfThisFiscalYear();
        String nYears = this.token.split(':')[1];
        Datetime lastNFiscalYears = thisFiscalYear.addYears(
            -Integer.valueOf(nYears)
        );
        return lastNFiscalYears <= fieldValue && fieldValue < thisFiscalYear;
    }

    /**
     * @description Returns if the field value is less than LAST_N_FISCAL_YEARS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime thisFiscalYear = Gmt.startOfThisFiscalYear();
        String nYears = this.token.split(':')[1];
        Datetime lastNFiscalYears = thisFiscalYear.addYears(
            -Integer.valueOf(nYears)
        );
        return fieldValue < lastNFiscalYears;
    }

    /**
     * @description Returns if the field value is greater than LAST_N_FISCAL_YEARS
     * @param fieldValue
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime thisFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue >= thisFiscalYear;
    }
}
