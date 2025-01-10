/**
 * @description Parser for the NEXT_FISCAL_YEAR date literal 
 * @author Zackary Frazier
 * @since 1/9/2025
 */
public with sharing class NextFiscalYearParser extends DateLiteralParser {
    /**
     * @description Parses the NEXT_FISCAL_YEAR date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.NEXT_FISCAL_YEAR_LITERAL);
    }
}