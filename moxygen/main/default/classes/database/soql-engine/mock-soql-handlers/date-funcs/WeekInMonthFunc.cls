/**
 * @description WEEK_IN_MONTH date function. Weeks start on Sunday, and week 1 contains the first of the month.
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class WeekInMonthFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        Date gmtDate = gmtDate(value);
        if (gmtDate == null) {
            return null;
        }
        Integer leadingDays =
            sundayBasedDayOfWeek(gmtDate.toStartOfMonth()) - 1;
        return ((gmtDate.day() - 1 + leadingDays) / 7) + 1;
    }
}
