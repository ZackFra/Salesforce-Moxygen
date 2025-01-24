/**
 * @description Comparable class for THIS_QUARTER
 * @author Zackary Frazier
 * @since 12/30/2024
 */
public with sharing class ThisQuarterComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to THIS_QUARTER
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(Datetime fieldValue) {
        Datetime startOfThisQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startOfNextQuarter = startOfThisQuarter.addMonths(3);
        return startOfThisQuarter <= fieldValue &&
            fieldValue < startOfNextQuarter;
    }

    /**
     * @description Returns whether fieldValue is greater than THIS_QUARTER
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime startOfThisQuarter = Gmt.startOfThisCalendarQuarter();
        return fieldValue < startOfThisQuarter;
    }

    /**
     * @description Return whether fieldValue is less than THIS_QUARTER
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime startOfThisQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startOfNextQuarter = startOfThisQuarter.addMonths(3);
        return fieldValue >= startOfNextQuarter;
    }
}
