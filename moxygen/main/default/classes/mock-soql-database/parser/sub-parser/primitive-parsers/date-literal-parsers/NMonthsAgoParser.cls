/**
 * @description Parser for N_MONTHS_AGO date literals. 
 * @author Zackary Frazier
 * @since 12/23/2024
 */
public with sharing class NMonthsAgoParser extends DateLiteralParser {
    /**
     * @description Parses the N_MONTHS_AGO date literal. 
     * @param query `String`
     * @return `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.N_MONTHS_AGO_LITERAL);
    }
}