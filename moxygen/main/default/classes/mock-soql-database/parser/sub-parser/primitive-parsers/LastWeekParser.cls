/**
 * @description Parser for the LAST_WEEK token
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public with sharing class LastWeekParser extends DateLiteralParser {
    /**
     * @description Parses the LAST_WEEK value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.LAST_WEEK_LITERAL);
    }
}