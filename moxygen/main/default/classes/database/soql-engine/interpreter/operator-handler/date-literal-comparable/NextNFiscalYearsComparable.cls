/**
 * @description Compare the date field value with the NEXT_N_FISCAL_YEARS:N token
 * @author Zackary Frazier
 * @since 1/11/2025
 * @group Soql Engine
 */
public with sharing class NextNFiscalYearsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        return fieldValue < startOfNextFiscalYear;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        return fieldValue >= startOfNextFiscalYear.addYears(this.n);
    }
}
