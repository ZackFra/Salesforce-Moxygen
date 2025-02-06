/**
 * @description Comparable class for LAST_N_FISCAL_YEARS
 * @author Zackary Frazier
 * @since 1/8/2025
 * @group Soql Engine
 */
public with sharing class LastNFiscalYearsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime lastNFiscalYears = thisFiscalYear.addYears(
            -Integer.valueOf(this.n)
        );
        return fieldValue < lastNFiscalYears;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime thisFiscalYear = Gmt.startOfThisFiscalYear();
        return fieldValue >= thisFiscalYear;
    }
}
