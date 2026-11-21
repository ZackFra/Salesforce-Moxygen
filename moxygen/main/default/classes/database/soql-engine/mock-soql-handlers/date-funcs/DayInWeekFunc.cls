/**
 * @description DAY_IN_WEEK date function. Sunday is 1 and Saturday is 7.
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class DayInWeekFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        Date gmtDate = gmtDate(value);
        if (gmtDate == null) {
            return null;
        }
        return sundayBasedDayOfWeek(gmtDate);
    }
}
