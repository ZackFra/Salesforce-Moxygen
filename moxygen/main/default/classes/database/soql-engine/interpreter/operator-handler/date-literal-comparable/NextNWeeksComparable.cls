/**
 * @description Comparable class for NEXT_N_WEEKS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class NextNWeeksComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to NEXT_N_WEEKS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime nextNWeeks = Gmt.today()
            .toStartOfWeek()
            .addDays(Integer.valueOf(nWeeks) * 7);
        return Gmt.today().toStartOfWeek().addDays(7) <= fieldValue &&
            fieldValue < nextNWeeks.addDays(1);
    }

    /**
     * @description Returns whether fieldValue is less than NEXT_N_WEEKS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        return fieldValue < Gmt.today().toStartOfWeek().addDays(7);
    }

    /**
     * @description Returns whether fieldValue is greater than NEXT_N_WEEKS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime nextNWeeks = Gmt.today()
            .toStartOfWeek()
            .addDays(Integer.valueOf(nWeeks) * 7);
        return fieldValue >= nextNWeeks.addDays(1);
    }
}
