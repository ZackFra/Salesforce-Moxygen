/**
 * @description Comparable class for YESTERDAY
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class YesterdayComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        return (DateTime) fieldValue >= Date.today();
    }

    public override Boolean isLessThan(Object rawField) {
        Datetime fieldValue = literalDateTime(rawField);
        Date yesterday = Date.today().addDays(-1);
        return (DateTime) fieldValue < yesterday;
    }
}
