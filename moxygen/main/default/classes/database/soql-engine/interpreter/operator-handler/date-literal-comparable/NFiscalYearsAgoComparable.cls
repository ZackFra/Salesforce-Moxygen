/**
 * @description Compares a date to N fiscal years ago
 * @author Zackary Frazier
 * @since 1/21/2025
 * @group Soql Engine
 */
public with sharing class NFiscalYearsAgoComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startofNFiscalYearsAgo = Gmt.startOfThisFiscalYear()
            .addYears(-this.n);
        return fieldValue < startofNFiscalYearsAgo;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startofNFiscalYearsAgo = Gmt.startOfThisFiscalYear()
            .addYears(-this.n + 1);
        return fieldValue >= startofNFiscalYearsAgo;
    }
}
