/**
 * @description Parser for NEXT_WEEK token 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class NextWeekParser extends DateLiteralParser {
    public override Intermediary parse(String query) {
        return parse(query, Token.NEXT_WEEK_LITERAL);
    }
}