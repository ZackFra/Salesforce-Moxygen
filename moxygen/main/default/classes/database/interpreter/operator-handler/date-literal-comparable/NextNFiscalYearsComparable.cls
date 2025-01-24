/**
 * @description Compare the date field value with the NEXT_N_FISCAL_YEARS:N token
 * @author Zackary Frazier
 * @since 1/11/2025
 */
public with sharing class NextNFiscalYearsComparable extends DateLiteralComparable {
    /**
     * @description Check if the fieldValue is less than the NEXT_N_FISCAL_YEARS:N token
     * @param fieldValue Datetime or Date to be compared
     * @return Whether fieldValue is less than the NEXT_N_FISCAL_YEARS:N token
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        return fieldValue < startOfNextFiscalYear;
    }

    /**
     * @description Check if the fieldValue is greater than the NEXT_N_FISCAL_YEARS:N token
     * @param fieldValue Datetime or Date to be compared
     * @return Whether fieldValue is greater than the NEXT_N_FISCAL_YEARS:N token
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        String elapsed = this.token.split(':')[1].trim();
        Integer nextNFiscalYears = Integer.valueOf(elapsed);
        return fieldValue >= startOfNextFiscalYear.addYears(nextNFiscalYears);
    }
}
