/**
 * @description A class to parse the last month literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public inherited sharing class LastMonthParser extends DateLiteralParser {
    /**
     * @description Parse the LAST_MONTH literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.LAST_MONTH_LITERAL);
    }
}