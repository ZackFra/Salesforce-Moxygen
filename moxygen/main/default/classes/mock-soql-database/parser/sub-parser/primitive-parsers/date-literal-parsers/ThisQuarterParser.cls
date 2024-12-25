/**
 * @description Parser for the THIS_QUARTER token 
 * @author Zackary Frazier
 * @since 12/24/2024
 */
public with sharing class ThisQuarterParser extends DateLiteralParser {
    /**
     * @description Parse the THIS_QUARTER literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.THIS_QUARTER_LITERAL);
    }
}