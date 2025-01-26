/**
 * @description Comparable class for LAST_N_WEEKS
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class LastNWeeksComparable extends DateLiteralComparable {
    public override Boolean isLessThan(DateTime fieldValue) {
        String nWeeks = this.token.split(':')[1];
        DateTime lastNWeeks = Gmt.today()
            .toStartOfWeek()
            .addDays(-Integer.valueOf(nWeeks) * 7);
        return fieldValue < lastNWeeks;
    }

    public override Boolean isGreaterThan(DateTime fieldValue) {
        return fieldValue >= Gmt.today().toStartOfWeek();
    }
}
