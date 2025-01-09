/**
 * @description Parser for the LAST_N_FISCAL_YEARS date literal 
 * @author Zackary Frazier
 * @since 1/8/2025
 */
public with sharing class LastNFiscalYearsParser extends DateLiteralParser {
    /**
     * @description Parses the LAST_N_FISCAL_YEARS date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.LAST_N_FISCAL_YEARS_LITERAL);
    }
}