/**
 * @description A class to parse the this month literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class ThisMonthParser extends DateLiteralParser {
    /**
     * @description Parse the THIS_MONTH literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.THIS_MONTH_LITERAL);
    }
}