/**
 * @description Compares a date to N fiscal years ago
 * @author Zackary Frazier
 * @since 1/21/2025
 * @group Soql Engine
 */
public with sharing class NFiscalYearsAgoComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startofNFiscalYearsAgo = Gmt.startOfThisFiscalYear()
            .addYears(-this.n);
        return fieldValue < startofNFiscalYearsAgo;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startofNFiscalYearsAgo = Gmt.startOfThisFiscalYear()
            .addYears(-this.n + 1);
        return fieldValue >= startofNFiscalYearsAgo;
    }
}
