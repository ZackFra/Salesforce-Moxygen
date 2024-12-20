/**
 * @description Parses the NEXT_N_DAYS date literal 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public inherited sharing class NextNDaysParser extends DateLiteralParser {
    /**
     * @description Parse the LAST_N_DAYS date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.NEXT_N_DAYS_LITERAL);
    }
}