/**
 * @description Parses the NEXT_QUARTER token 
 * @author Zackary Frazier
 * @since 1/2/2025
 */
public with sharing class NextQuarterParser extends DateLiteralParser {
    /**
     * @description Parses the NEXT_QUARTER value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.NEXT_QUARTER_LITERAL);
    }
}