/**
 * @description Factory class to create date functions by name
 * @author Zackary Frazier
 * @since 1/17/2025
 * @group Date Functions
 */
public with sharing class DateFuncFactory {
    static Map<String, Type> dateFuncByName = new Map<String, Type>{
        'calendar_month' => CalendarMonthFunc.class,
        'calendar_year' => CalendarYearFunc.class,
        'calendar_quarter' => CalendarQuarterFunc.class
    };

    /**
     * @description Create a date function by name
     * @param name Name of the date function to create
     * @return Instance of an IDateFunc
     * @exception IllegalArgumentException if the name is not a valid date function
     */
    public static IDateFunc create(String name) {
        Type dateFuncType = dateFuncByName.get(name);
        if (dateFuncType == null) {
            throw new IllegalArgumentException('Invalid date function');
        }
        return (IDateFunc) dateFuncType.newInstance();
    }
}
