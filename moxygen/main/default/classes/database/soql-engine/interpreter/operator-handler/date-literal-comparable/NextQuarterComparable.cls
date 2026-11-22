/**
 * @description Compares the NEXT_QUARTER token
 * @author Zackary Frazier
 * @since 1/2/2024
 * @group Soql Engine
 */
public with sharing class NextQuarterComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Datetime endOfNextQuarter = startOfNextQuarter.addMonths(3);
        return fieldValue >= endOfNextQuarter;
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        return fieldValue < startOfNextQuarter;
    }
}
