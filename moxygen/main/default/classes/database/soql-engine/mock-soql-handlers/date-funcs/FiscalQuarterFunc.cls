/**
 * @description FISCAL_QUARTER date function for the org's standard fiscal year
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class FiscalQuarterFunc extends DateFuncBase {
    public override Object calculate(Object value) {
        Date gmtDate = gmtDate(value);
        if (gmtDate == null) {
            return null;
        }
        return Gmt.fiscalQuarter(gmtDate);
    }
}
