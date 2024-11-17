/**
 * @description Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT 
 * @author Zackary Frazier
 * @since 11/16/2024
 */
public with sharing class GMT {
    public static Date today() {
        return System.now().dateGmt();
    }

    public static DateTime now() {
        return System.now();
    }

    public static Date date(DateTime dt) {
        return dt.dateGmt();
    }
}