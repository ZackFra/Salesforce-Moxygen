/**
 * @description Factory class for creating exceptions 
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing class ExceptionFactory {
    /**
     * @description Generates an `IllegalArgumentException` for an invalid field name
     * @param fieldName `String`
     * @return  `IllegalArgumentException`
     */
    public static IllegalArgumentException createIllegalFieldNameException(String fieldName) {
        return new IllegalArgumentException('Invalid field name: ' + fieldName);
    }

    /**
     * @description Generates an `IllegalArgumentException` for a null argument
     * @param argName `String`
     * @return  `IllegalArgumentException`
     */
    public static IllegalArgumentException createIllegalNullException(String argName) {
        return new IllegalArgumentException('Argument ' + argName + ' cannot be null');
    }

    /**
     * @description Generates an `IllegalArgumentException` for an invalid date format
     * @param dateFormat `String`
     * @return  `IllegalArgumentException`
     */
    public static IllegalArgumentException createIllegalDateFormatException(String dateFormat) {
        return new IllegalArgumentException('Invalid date format: ' + dateFormat);
    }

    /**
     * @description Generates an `IllegalArgumentException` for an invalid date time format
     * @param dateTimeFormat `String`
     * @return  `IllegalArgumentException`
     */
    public static IllegalArgumentException createIllegalDateTimeFormatException(String dateTimeFormat) {
        return new IllegalArgumentException('Invalid date time format: ' + dateTimeFormat);
    }

    /**
     * @description Generates an `IllegalArgumentException` for an invalid time format
     * @param timeFormat `String`
     * @return  `IllegalArgumentException`
     */
    public static IllegalArgumentException createIllegalTimeFormatException(String timeFormat) {
        return new IllegalArgumentException('Invalid time format: ' + timeFormat);
    }
}