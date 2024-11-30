/**
 * @description A class to parse the TODAY literal 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class TodayParser extends DateLiteralParser {
    /**
     * @description Parse the TODAY literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.TODAY_LITERAL);
    }
}