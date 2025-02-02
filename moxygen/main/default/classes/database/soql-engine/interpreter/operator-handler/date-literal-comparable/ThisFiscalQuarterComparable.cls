/**
 * @description Comparable class for THIS_FISCAL_QUARTER
 * @author Zackary Frazier
 * @since 2/2/2025
 */
public with sharing class ThisFiscalQuarterComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        return fieldValue < startOfThisFiscalQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        return fieldValue >= startOfNextFiscalQuarter;
    }
}
