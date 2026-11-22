/**
 * @description Comparable for the NEXT_N_QUARTERS token
 * @author Zackary Frazier
 * @since 1/4/2025
 * @group Soql Engine
 */
public with sharing class NextNQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return fieldValue < Gmt.startOfThisCalendarQuarter().addMonths(3);
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Datetime nextNQuarters = startOfNextQuarter.addMonths(this.n * 3);

        return fieldValue >= nextNQuarters;
    }
}
