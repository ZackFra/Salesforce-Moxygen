/**
 * @description Comparable class for N_MONTHS_AGO
 * @author Zackary Frazier
 * @since 12/29/2024
 */
public with sharing class NMonthsAgoComparable extends DateLiteralComparable {
    /**
     * @description Returns whether fieldValue is equal to N_MONTHS_AGO
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isEqual(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today()
            .toStartOfMonth()
            .addMonths(-Integer.valueOf(nMonths));
        return nMonthsAgo <= fieldValue && fieldValue < nMonthsAgo.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is greater than N_MONTHS_AGO
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isGreaterThan(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today()
            .toStartOfMonth()
            .addMonths(-Integer.valueOf(nMonths));
        return fieldValue >= nMonthsAgo.addMonths(1);
    }

    /**
     * @description Returns whether fieldValue is less than N_MONTHS_AGO
     * @param fieldValue `Datetime`
     * @return  `Boolean`
     */
    public override Boolean isLessThan(DateTime fieldValue) {
        String nMonths = this.token.split(':')[1];
        DateTime nMonthsAgo = Gmt.today()
            .toStartOfMonth()
            .addMonths(-Integer.valueOf(nMonths));
        return fieldValue < nMonthsAgo;
    }
}
