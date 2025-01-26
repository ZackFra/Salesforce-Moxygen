/**
 * @description Compares the NEXT_QUARTER token
 * @author Zackary Frazier
 * @since 1/2/2024
 * @group Soql Engine
 */
public with sharing class NextQuarterComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Datetime endOfNextQuarter = startOfNextQuarter.addMonths(3);
        return fieldValue >= endOfNextQuarter;
    }

    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        return fieldValue < startOfNextQuarter;
    }
}
