/**
 * @description Comparable class for YESTERDAY
 * @author Zackary Frazier
 * @since 12/29/2024
 * @group Soql Engine
 */
public with sharing class YesterdayComparable extends DateLiteralComparable {
    public override Boolean isGreaterThan(DateTime fieldValue) {
        return (DateTime) fieldValue >= Gmt.today();
    }

    public override Boolean isLessThan(DateTime fieldValue) {
        Date yesterday = GMT.today().addDays(-1);
        return (DateTime) fieldValue < yesterday;
    }
}
