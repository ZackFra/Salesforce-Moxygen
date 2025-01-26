/**
 * @description Comparable for the NEXT_N_QUARTERS token
 * @author Zackary Frazier
 * @since 1/4/2025
 * @group Soql Engine
 */
public with sharing class NextNQuartersComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        return fieldValue < Gmt.startOfThisCalendarQuarter().addMonths(3);
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        String nQuarters = this.token.split(':')[1];
        Integer nQuartersInt = Integer.valueOf(nQuarters);
        Datetime startOfNextQuarter = Gmt.startOfThisCalendarQuarter()
            .addMonths(3);
        Datetime nextNQuarters = startOfNextQuarter.addMonths(nQuartersInt * 3);

        return fieldValue >= nextNQuarters;
    }
}
