/**
 * @description Parses the LAST_N_DAYS date literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class LastNDaysParser extends DateLiteralParser {
    /**
     * @description Parse the LAST_N_DAYS date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.LAST_N_DAYS_LITERAL);
    }
}