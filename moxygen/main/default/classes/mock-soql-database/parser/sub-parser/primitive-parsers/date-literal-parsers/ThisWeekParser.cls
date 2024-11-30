/**
 * @description Parser for the THIS_WEEK token 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public inherited sharing class ThisWeekParser extends DateLiteralParser {
    /**
     * @description Parse the TODAY literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.THIS_WEEK_LITERAL);
    }
}