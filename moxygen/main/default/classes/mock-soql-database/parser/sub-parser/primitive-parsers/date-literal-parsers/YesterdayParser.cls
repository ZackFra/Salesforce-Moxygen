/**
 * @description A class to parse the yesterday literal 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class YesterdayParser extends DateLiteralParser {
    /**
     * @description Parse the YESTERDAY literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.YESTERDAY_LITERAL);
    }
}