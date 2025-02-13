/**
 * @description Compares a date to N weeks ago
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class NWeeksAgoComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Datetime fieldValue) {
        Date startOfNWeeksAgo = Gmt.today()
            .addDays(-7 * this.n)
            .toStartOfWeek();
        return fieldValue < startOfNWeeksAgo;
    }

    public override Boolean isGreaterThan(Datetime fieldValue) {
        Date startOfNWeeksAgo = Gmt.today()
            .addDays(-7 * (this.n - 1))
            .toStartOfWeek();
        return fieldValue >= startOfNWeeksAgo;
    }
}
