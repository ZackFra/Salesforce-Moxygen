/**
 * @description This class is responsible for parsing the next month literal 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public with sharing class NextMonthParser extends DateLiteralParser {
    /**
     * @description Parse the query and return the intermediary object
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parse(query, Token.NEXT_MONTH_LITERAL);
    }
}