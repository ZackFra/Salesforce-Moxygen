/**
 * @description Factory class for creating exceptions 
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing class ExceptionFactory {
    public static IllegalArgumentException createIllegalFieldNameException(String fieldName) {
        return new IllegalArgumentException('Invalid field name: ' + fieldName);
    }

    public static IllegalArgumentException createIllegalNullException(String argName) {
        return new IllegalArgumentException('Argument ' + argName + ' cannot be null');
    }

    public static IllegalArgumentException createIllegalDateFormatException(String dateFormat) {
        return new IllegalArgumentException('Invalid date format: ' + dateFormat);
    }

    public static IllegalArgumentException createIllegalDateTimeFormatException(String dateTimeFormat) {
        return new IllegalArgumentException('Invalid date time format: ' + dateTimeFormat);
    }

    public static IllegalArgumentException createIllegalTimeFormatException(String timeFormat) {
        return new IllegalArgumentException('Invalid time format: ' + timeFormat);
    }
}