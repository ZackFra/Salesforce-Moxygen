/**
 * @description Factory class to create date functions by name
 * @author Zackary Frazier
 * @since 1/17/2025
 * @group Soql Engine
 */
public with sharing class DateFuncFactory {
    static Map<String, Type> dateFuncByName = new Map<String, Type>{
        Token.CALENDAR_MONTH => CalendarMonthFunc.class,
        Token.CALENDAR_YEAR => CalendarYearFunc.class,
        Token.CALENDAR_QUARTER => CalendarQuarterFunc.class,
        Token.DAY_IN_MONTH => DayInMonthFunc.class,
        Token.DAY_IN_WEEK => DayInWeekFunc.class,
        Token.DAY_IN_YEAR => DayInYearFunc.class,
        Token.DAY_ONLY => DayOnlyFunc.class,
        Token.FISCAL_MONTH => FiscalMonthFunc.class,
        Token.FISCAL_QUARTER => FiscalQuarterFunc.class,
        Token.FISCAL_YEAR => FiscalYearFunc.class,
        Token.HOUR_IN_DAY => HourInDayFunc.class,
        Token.WEEK_IN_MONTH => WeekInMonthFunc.class,
        Token.WEEK_IN_YEAR => WeekInYearFunc.class
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
