/**
 * @description Parser for THIS_YEAR 
 * @author Zackary Frazier
 * @since 1/4/2025
 */
public with sharing class ThisYearParser extends DateLiteralParser {
    /**
     * @description Parses THIS_YEAR
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.THIS_YEAR_LITERAL);
    }
}