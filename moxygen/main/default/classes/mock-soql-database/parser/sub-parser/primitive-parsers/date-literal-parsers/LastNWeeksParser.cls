/**
 * @description Parses the LAST_N_WEEKS date literal
 * @author Zackary Frazier
 * @since 12/21/2024
 */
public inherited sharing class LastNWeeksParser extends DateLiteralParser {
    /**
     * @description Parse the LAST_N_WEEKS date literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.LAST_N_WEEKS_LITERAL);
    }
}