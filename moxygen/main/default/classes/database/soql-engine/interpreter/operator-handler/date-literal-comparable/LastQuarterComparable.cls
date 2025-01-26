/**
 * @description Compares a date field to the last quarter
 * @author Zackary Frazier
 * @since 1/1/2024
 * @group Soql Engine
 */
public with sharing class LastQuarterComparable extends DateLiteralComparable {
    /**
     * @description Returns true if the fieldValue is equal to the last quarter
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(Datetime fieldValue) {
        Datetime endOfLastQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startOfLastQuarter = endOfLastQuarter.addMonths(-3);
        return startOfLastQuarter <= fieldValue &&
            fieldValue < endOfLastQuarter;
    }

    /**
     * @description Returns true if the fieldValue is less than the last quarter
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime endOfLastQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startOfLastQuarter = endOfLastQuarter.addMonths(-3);
        return fieldValue < startOfLastQuarter;
    }

    /**
     * @description Returns true if the fieldValue is greater than the last quarter
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime endOfLastQuarter = Gmt.startOfThisCalendarQuarter();
        return fieldValue >= endOfLastQuarter;
    }
}
