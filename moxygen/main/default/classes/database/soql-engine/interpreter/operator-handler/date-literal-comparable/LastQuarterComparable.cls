/**
 * @description Compares a date field to the last quarter
 * @author Zackary Frazier
 * @since 1/1/2024
 * @group Soql Engine
 */
public with sharing class LastQuarterComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime endOfLastQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startOfLastQuarter = endOfLastQuarter.addMonths(-3);
        return fieldValue < startOfLastQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime endOfLastQuarter = Gmt.startOfThisCalendarQuarter();
        return fieldValue >= endOfLastQuarter;
    }
}
