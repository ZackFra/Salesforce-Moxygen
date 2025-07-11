/**
 * @description Comparable class for LAST_N_FISCAL_QUARTERS
 * @author Zackary Frazier
 * @since 2/1/2025
 * @group Soql Engine
 */
public with sharing class LastNFiscalQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Integer nMonthsAgo = this.n * 3;
        // Does NOT include the current quarter, thus the -3
        Date nFiscalQuartersAgo = Gmt.startOfthisFiscalQuarter()
            .addMonths(-nMonthsAgo);
        return fieldValue < nFiscalQuartersAgo;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        // For LAST_N_FISCAL_QUARTERS, isGreaterThan should return true
        // when fieldValue is >= the start of the current fiscal quarter
        return fieldValue >= Gmt.startOfthisFiscalQuarter();
    }
}
