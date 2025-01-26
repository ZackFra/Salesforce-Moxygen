/**
 * @description Comparable class for THIS_QUARTER
 * @author Zackary Frazier
 * @since 12/30/2024
 * @group Soql Engine
 */
public with sharing class ThisQuarterComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime startOfThisQuarter = Gmt.startOfThisCalendarQuarter();
        return fieldValue < startOfThisQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime startOfThisQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startOfNextQuarter = startOfThisQuarter.addMonths(3);
        return fieldValue >= startOfNextQuarter;
    }
}
