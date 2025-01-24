/**
 * @description Compares the NEXT_QUARTER token
 * @author Zackary Frazier
 * @since 1/2/2024
 */
public with sharing class NextQuarterComparable extends DateLiteralComparable {
    /**
     * @description Returns true if the fieldValue is equal to the NEXT_QUARTER token
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(Datetime fieldValue) {
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Datetime endOfNextQuarter = startOfNextQuarter.addMonths(3);
        return startOfNextQuarter <= fieldValue &&
            fieldValue < endOfNextQuarter;
    }

    /**
     * @description Returns true if the fieldValue is greater than the NEXT_QUARTER token
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Datetime endOfNextQuarter = startOfNextQuarter.addMonths(3);
        return fieldValue >= endOfNextQuarter;
    }

    /**
     * @description Returns true if the fieldValue is less than the NEXT_QUARTER token
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        return fieldValue < startOfNextQuarter;
    }
}
