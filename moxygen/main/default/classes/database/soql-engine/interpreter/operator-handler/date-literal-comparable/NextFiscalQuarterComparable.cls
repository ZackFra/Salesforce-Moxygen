/**
 * @description Comparable class for NEXT_FISCAL_QUARTER
 * @author Zackary Frazier
 * @since 2/1/2025
 * @group Soql Engine
 */
public with sharing class NextFiscalQuarterComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        return fieldValue < startOfNextFiscalQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startOfNextFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        return fieldValue >= startOfNextFiscalQuarter.addMonths(3);
    }
}
