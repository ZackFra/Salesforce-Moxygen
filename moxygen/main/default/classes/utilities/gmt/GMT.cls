/**
 * @description Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT
 * @author Zackary Frazier
 * @since 11/16/2024
 * @group Utilities
 */
public with sharing class GMT {
    /**
     * @description Return today's date in GMT
     * @return  `Date`
     */
    public static Date today() {
        return System.now().dateGmt();
    }

    /**
     * @description Return today's date time in GMT
     * @return  `DateTime`
     */
    public static DateTime now() {
        return System.now();
    }

    /**
     * @description Return the date in GMT of the date time
     * @param dt
     * @return  `Date`
     */
    public static Date date(DateTime dt) {
        return dt.dateGmt();
    }

    /**
     * @description Return the date time in GMT of the date
     * @param d `Date`
     * @return `DateTime`
     */
    public static DateTime dateTime(Date d) {
        return DateTime.newInstanceGmt(d, Time.newInstance(0, 0, 0, 0));
    }

    /**
     * @description Return the start of the current calendar quarter
     * @return  `Date`
     */
    public static Datetime startOfThisCalendarQuarter() {
        Date today = Gmt.today();
        Integer startMonth = today.month();

        if (startMonth >= 10) {
            startMonth = 10;
        } else if (startMonth >= 7) {
            startMonth = 7;
        } else if (startMonth >= 4) {
            startMonth = 4;
        } else {
            startMonth = 1;
        }

        return Datetime.newInstanceGmt(today.year(), startMonth, 1);
    }

    /**
     * @description Return the start of the current fiscal year
     * @return  `Date`
     */
    public static Date startOfThisFiscalYear() {
        Organization org = OrganizationSingleton.getInstance();
        Integer orgFiscalMonth = org.FiscalYearStartMonth;
        Date possibleStartOfThisFiscalYear = Date.newInstance(
            Gmt.today().year(),
            orgFiscalMonth,
            1
        );
        if (possibleStartOfThisFiscalYear > Gmt.today()) {
            return possibleStartOfThisFiscalYear.addYears(-1);
        }
        return possibleStartOfThisFiscalYear;
    }

    /**
     * @description Return the start of the current fiscal quarter
     * @return  `Date`
     */
    public static Date startOfthisFiscalQuarter() {
        Date startOfThisFiscalQuarter = startOfThisFiscalYear();
        while (startOfThisFiscalQuarter <= Gmt.today()) {
            startOfThisFiscalQuarter = startOfThisFiscalQuarter.addMonths(3);
        }
        return startOfThisFiscalQuarter.addMonths(-3);
    }
}
