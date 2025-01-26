/**
 * @description Function to calculate the calendar month of a date or datetime value
 * @author Zackary Frazier
 * @since 1/17/2025
 * @group Soql Engine
 */
public with sharing class CalendarMonthFunc implements IDateFunc {
    /**
     * @description Returns the calendar month of a date or datetime value
     * @param value Date or Datetime value to calculate the calendar month of
     * @return  The calendar month of the date or datetime value
     * @exception QueryException if the value is not a Date or DateTime
     */
    public Integer calculate(Object value) {
        Integer calendarMonth;
        if (value instanceof Date) {
            Date dateValue = (Date) value;
            calendarMonth = dateValue.month();
        } else if (value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarMonth = dateTimeValue.monthGmt();
        } else {
            throw new QueryException(
                'Invalid value type for calendar month calculation'
            );
        }
        return calendarMonth;
    }
}
