/**
 * @description Compares a date to N weeks ago
 * @author Zackary Frazier
 * @since 2/12/2025
 * @group Soql Engine
 */
public with sharing class NWeeksAgoComparable extends DateLiteralComparable {
    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNWeeksAgo = Date.today()
            .addDays(-7 * this.n)
            .toStartOfWeek();
        return fieldValue < startOfNWeeksAgo;
    }

    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date startOfNWeeksAgo = Date.today()
            .addDays(-7 * (this.n - 1))
            .toStartOfWeek();
        return fieldValue >= startOfNWeeksAgo;
    }
}
