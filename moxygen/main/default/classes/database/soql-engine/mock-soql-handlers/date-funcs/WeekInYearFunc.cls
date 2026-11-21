/**
 * @description WEEK_IN_YEAR date function. Weeks start on Sunday, and week 1 contains January 1.
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class WeekInYearFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        Date gmtDate = gmtDate(value);
        if (gmtDate == null) {
            return null;
        }
        Date januaryFirst = Date.newInstance(gmtDate.year(), 1, 1);
        Integer leadingDays = sundayBasedDayOfWeek(januaryFirst) - 1;
        return ((gmtDate.dayOfYear() - 1 + leadingDays) / 7) + 1;
    }
}
