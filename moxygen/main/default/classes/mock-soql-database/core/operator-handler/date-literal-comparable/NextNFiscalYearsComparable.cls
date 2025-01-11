/**
 * @description Compare the date field value with the NEXT_N_FISCAL_YEARS:N token
 * @author Zackary Frazier
 * @since 1/11/2025
 */
public with sharing class NextNFiscalYearsComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        return fieldValue < startOfNextFiscalYear;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalYear = Gmt.startOfThisFiscalYear();
        Date startOfNextFiscalYear = startOfThisFiscalYear.addYears(1);
        String elapsed = this.token.split(':')[1].trim();
        Integer nextNFiscalYears = Integer.valueOf(elapsed);
        return fieldValue >= startOfNextFiscalYear.addYears(nextNFiscalYears);
    }
}
