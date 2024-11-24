/**
 * @description Factory class for creating exceptions 
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing class ExceptionFactory {
    public static IllegalArgumentException createIllegalFieldNameException(String fieldName) {
        return new IllegalArgumentException('Invalid field name: ' + fieldName);
    }
}