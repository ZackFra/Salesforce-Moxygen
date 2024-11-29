/**
 * @description A class to parse the TOMORROW literal 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class TomorrowParser extends DateLiteralParser {
    /**
     * @description Parse the TOMORROW literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.TOMORROW_LITERAL);
    }
}