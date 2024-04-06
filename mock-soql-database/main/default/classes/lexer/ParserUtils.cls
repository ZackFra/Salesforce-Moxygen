/**
 * @description Contains utility methods for the parser, could probably be refactored out of existance though
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class ParserUtils {

    /**
     * @description Skips whitespace in a query string
     * @param query `String`
     * @return  `String`
     */
    public static String skipWhitespace(String query) {
        while(query.length() > 0 && query.substring(0, 1).isWhitespace()) {
            query = query.subString(1);
        }
        return query;
    }
    
    /**
     * @description Checks if a character is a valid character for a field or object name
     * @param character `String`
     * @return  `Boolean`
     */
    public static Boolean validCharForFieldOrObject(String character) {
        return character.isAlpha() || character == '_' || character.isNumeric();
    }
}