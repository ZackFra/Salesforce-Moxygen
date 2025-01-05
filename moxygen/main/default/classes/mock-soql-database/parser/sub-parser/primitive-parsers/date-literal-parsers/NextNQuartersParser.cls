/**
 * @description Parser for the NEXT_N_QUARTERS_LITERAL 
 * @author Zackary Frazier
 * @since 1/4/2025
 */
public with sharing class NextNQuartersParser extends DateLiteralParser {
    /**
     * @description Parses the NEXT_N_QUARTERS_LITERAL
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.NEXT_N_QUARTERS_LITERAL);
    }
}