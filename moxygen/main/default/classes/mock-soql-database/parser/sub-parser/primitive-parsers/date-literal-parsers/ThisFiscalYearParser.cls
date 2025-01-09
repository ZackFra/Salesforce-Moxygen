/**
 * @description Parser for the FISCAL_YEAR token 
 * @author Zackary Frazier
 * @since 1/6/2025
 */
public with sharing class ThisFiscalYearParser extends DateLiteralParser {
    /**
     * @description Parses the query and returns an `Intermediary` object
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.THIS_FISCAL_YEAR_LITERAL);
    }
}