public inherited sharing class DateFuncs {
    public static Integer calendarMonth(Object value) {
        Integer calendarMonth;
        if(value instanceof DateTime) {
            DateTime dateTimeValue = (DateTime) value;
            calendarMonth = dateTimeValue.month();
        } else if(value instanceof Date) {
            Date dateValue = (Date) value;
            calendarMonth = dateValue.month();
        } else {
            throw new QueryException('Invalid value type for calendar month calculation');
        }
        return calendarMonth;
    }
}