/**
 * @description Comparable class for LAST_FISCAL_QUARTER
 * @author Zackary Frazier
 * @since 2/2/2025
 * @group Soql Engine
 */
public with sharing class LastFiscalQuarterComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfthisFiscalQuarter();
        Date startOfLastFiscalQuarter = startOfThisFiscalQuarter.addMonths(-3);
        return fieldValue < startOfLastFiscalQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        return fieldValue >= startOfThisFiscalQuarter;
    }
}
