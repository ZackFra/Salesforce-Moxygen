/**
 * @description Function to calculate the calendar year of a date or datetime value
 * @author Zackary Frazier
 * @since 1/17/2025
 * @group Soql Engine
 */
public with sharing class CalendarYearFunc implements IDateFunc {
    /**
     * @description Returns the calendar year of a date or datetime value
     * @param value Date or Datetime value to calculate the calendar year of
     * @return The calendar year of the date or datetime value
     * @exception QueryException if the value is not a Date or DateTime
     */
    public Integer calculate(Object value) {
        Integer calendarYear;
        if (value instanceof Date) {
            Date dateValue = (Date) value;
            calendarYear = dateValue.year();
        } else if (value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarYear = dateTimeValue.yearGmt();
        } else {
            throw new QueryException(
                'Invalid value type for calendar year calculation'
            );
        }
        return calendarYear;
    }
}
