/**
 * @description Parses the NEXT_N_WEEKS date literal 
 * @author Zackary Frazier
 * @since 12/17/2024
 */
public inherited sharing class NextNWeeksParser extends DateLiteralParser {
    /**
     * @description Parse the NEXT_N_WEEKS date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.NEXT_N_WEEKS_LITERAL);
    }
}