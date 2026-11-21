/**
 * @description DAY_IN_MONTH date function
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class DayInMonthFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        Date gmtDate = gmtDate(value);
        if (gmtDate == null) {
            return null;
        }
        return gmtDate.day();
    }
}
