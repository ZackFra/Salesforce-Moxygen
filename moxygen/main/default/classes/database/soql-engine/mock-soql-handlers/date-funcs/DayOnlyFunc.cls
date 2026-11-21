/**
 * @description DAY_ONLY date function. DateTime values are reduced to their GMT date.
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class DayOnlyFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        return gmtDate(value);
    }
}
