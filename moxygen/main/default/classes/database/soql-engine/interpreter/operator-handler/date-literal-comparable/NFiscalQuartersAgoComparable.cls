/**
 * @description Comparable class for N_FISCAL_QUARTERS_AGO
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class NFiscalQuartersAgoComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        Date nFiscalQuartersAgo = Gmt.startOfthisFiscalQuarter()
            .addMonths(-3 * this.n);
        return fieldValue >= nFiscalQuartersAgo.addMonths(3);
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        Date nFiscalQuartersAgo = Gmt.startOfthisFiscalQuarter()
            .addMonths(-3 * this.n);
        return fieldValue < nFiscalQuartersAgo;
    }
}
