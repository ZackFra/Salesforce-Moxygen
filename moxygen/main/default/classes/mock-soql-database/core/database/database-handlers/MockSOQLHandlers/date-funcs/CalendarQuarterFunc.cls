/**
 * @description Function to calculate the calendar quarter of a date or datetime value
 * @author Zackary Frazier
 * @since 1/17/2025
 * @group Date Functions
 */
public with sharing class CalendarQuarterFunc implements IDateFunc {
    /**
     * @description Calculate the calendar quarter of a date or datetime value
     * @param value Date or Datetime value to calculate the calendar quarter of
     * @return  The calendar quarter of the date or datetime value
     * @exception QueryException if the value is not a Date or DateTime
     */
    public Integer calculate(Object value) {
        Integer calendarQuarter;
        if (value instanceof Date) {
            Date dateValue = (Date) value;
            calendarQuarter = 1 + (dateValue.month() / 3);
        } else if (value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarQuarter = 1 + (dateTimeValue.monthGmt() / 3);
        } else {
            throw new QueryException(
                'Invalid value type for calendar quarter calculation'
            );
        }
        return calendarQuarter;
    }
}
