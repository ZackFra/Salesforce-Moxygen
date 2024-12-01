/**
 * @description Parser for the LAST_90_DAYS literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class Last90DaysParser extends DateLiteralParser {
    /**
     * @description Parse the query and return the intermediary object
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.LAST_90_DAYS_LITERAL);
    }
}