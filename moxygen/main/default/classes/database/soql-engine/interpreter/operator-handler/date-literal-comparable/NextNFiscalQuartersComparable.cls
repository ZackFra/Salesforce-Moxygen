/**
 * @description Comparable class for NEXT_N_FISCAL_QUARTERS
 * @author Zackary Frazier
 * @since 2/2/2025
 * @group Soql Engine
 */
public with sharing class NextNFiscalQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date nthFiscalQuarter = startOfThisFiscalQuarter.addMonths(3 * this.n);
        return fieldValue < nthFiscalQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date nthFiscalQuarter = startOfThisFiscalQuarter.addMonths(3 * this.n);
        return fieldValue >= nthFiscalQuarter.addMonths(3);
    }
}
