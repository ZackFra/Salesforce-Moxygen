/**
 * @description Parser for the N_DAYS_AGO token 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public inherited sharing class NDaysAgoParser extends DateLiteralParser{
    /**
     * @description Parse the LAST_N_DAYS date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.N_DAYS_AGO_LITERAL);
    }
}