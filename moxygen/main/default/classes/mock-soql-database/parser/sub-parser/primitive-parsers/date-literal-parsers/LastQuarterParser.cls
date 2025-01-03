/**
 * @description Parses the LAST_QUARTER token 
 * @author Zackary Frazier
 * @since 1/1/2025
 */
public with sharing class LastQuarterParser extends DateLiteralParser {
    /**
     * @description Parses the LAST_QUARTER value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.LAST_QUARTER_LITERAL);
    }
}