/**
 * @description HOUR_IN_DAY date function. Date values are hour 0. DateTime values use the GMT hour.
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class HourInDayFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof Date) {
            return 0;
        }
        if (value instanceof DateTime) {
            return ((DateTime) value).hourGmt();
        }
        throw new QueryException('Invalid value type for date function');
    }
}
