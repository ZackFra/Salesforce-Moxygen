/**
 * @description Comparable class for LAST_N_FISCAL_QUARTERS
 * @author Zackary Frazier
 * @since 2/1/2025
 * @group Soql Engine
 */
public with sharing class LastNFiscalQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        String lastNFiscalQuartersTkn = this.token.split(':')[1];
        Integer lastNFiscalQuarters = Integer.valueOf(lastNFiscalQuartersTkn);
        Integer nMonthsAgo = lastNFiscalQuarters * 3;
        // Does NOT include the current quarter, thus the -3
        Date nFiscalQuartersAgo = Gmt.startOfthisFiscalQuarter()
            .addMonths(-nMonthsAgo);
        return fieldValue < nFiscalQuartersAgo;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        String lastNFiscalQuartersTkn = this.token.split(':')[1];
        Integer lastNFiscalQuarters = Integer.valueOf(lastNFiscalQuartersTkn);
        Integer nMonthsAgo = lastNFiscalQuarters * 3;
        // Does NOT include the current quarter, thus the -3
        Date nFiscalQuartersAgo = Gmt.startOfthisFiscalQuarter()
            .addMonths(-nMonthsAgo);
        return fieldValue >= nFiscalQuartersAgo.addMonths(3);
    }
}
