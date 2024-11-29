/**
 * @description Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT 
 * @author Zackary Frazier
 * @since 11/16/2024
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
     */
    public static DateTime dateTime(Date d) {
        return DateTime.newInstanceGmt(d, Time.newInstance(0, 0, 0, 0));
    }
}