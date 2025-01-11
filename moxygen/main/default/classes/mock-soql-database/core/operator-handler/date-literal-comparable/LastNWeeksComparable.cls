/**
 * @description Comparable class for LAST_N_WEEKS
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class LastNWeeksComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to LAST_N_WEEKS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime lastNWeeks = Gmt.today()
            .toStartOfWeek()
            .addDays(-Integer.valueOf(nWeeks) * 7);
        return lastNWeeks <= fieldValue &&
            fieldValue < Gmt.today().toStartOfWeek();
    }

    /**
     * @description Returns whether fieldValue is less than LAST_N_WEEKS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime lastNWeeks = Gmt.today()
            .toStartOfWeek()
            .addDays(-Integer.valueOf(nWeeks) * 7);
        return fieldValue < lastNWeeks;
    }

    /**
     * @description Returns whether fieldValue is greater than LAST_N_WEEKS
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today().toStartOfWeek();
    }
}
