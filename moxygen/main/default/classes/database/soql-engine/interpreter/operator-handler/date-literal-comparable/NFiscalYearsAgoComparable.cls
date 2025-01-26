/**
 * @description Compares a date to N fiscal years ago
 * @author Zackary Frazier
 * @since 1/21/2025
 * @group Soql Engine
 */
public with sharing class NFiscalYearsAgoComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        String nValue = this.token.split(':')[1];
        Integer n = Integer.valueOf(nValue);
        Date startofNFiscalYearsAgo = Gmt.startOfThisFiscalYear().addYears(-n);
        return fieldValue < startofNFiscalYearsAgo;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        String nValue = this.token.split(':')[1];
        Integer n = Integer.valueOf(nValue);
        Date startofNFiscalYearsAgo = Gmt.startOfThisFiscalYear()
            .addYears(-n + 1);
        return fieldValue >= startofNFiscalYearsAgo;
    }
}
