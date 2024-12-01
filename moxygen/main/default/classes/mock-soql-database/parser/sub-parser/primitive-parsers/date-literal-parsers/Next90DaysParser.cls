/**
 * @description Parser for the  NEXT_90_DAYS date literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class Next90DaysParser extends DateLiteralParser {
    public override Intermediary parse(String query) {
        return parse(query, Token.NEXT_90_DAYS_LITERAL);
    }
}