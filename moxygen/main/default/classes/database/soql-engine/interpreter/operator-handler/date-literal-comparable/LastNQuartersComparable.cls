/**
 * @description Comprable for LAST_N_QUARTERS
 * @author Zackary Frazier
 * @since 2/5/2025
 * @group Soql Engine
 */
public with sharing class LastNQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Datetime thisCalendarQuarter = Gmt.startOfThisCalendarQuarter();
        Datetime startingQuarter = thisCalendarQuarter.addMonths(-3 * this.n);
        return fieldValue < startingQuarter;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Datetime thisCalendarQuarter = Gmt.startOfThisCalendarQuarter();
        return fieldValue >= thisCalendarQuarter;
    }
}
