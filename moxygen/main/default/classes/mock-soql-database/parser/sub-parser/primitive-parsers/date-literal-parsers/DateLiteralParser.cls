/**
 * @description Generic date literal parser 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public abstract class DateLiteralParser extends SubParser {
    /**
     * @description Parse a generic date literal
     * @param query `String`
     * @param token `String`
     * @return  `Intermediary`
     */
    public Intermediary parse(String query, String token) {
        query = consume(query, token);
        return new Intermediary(
            new NodeBuilder()
                .setId(token)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }

    /**
     * @description For the N_DAYS dates literals, parse the query and return the token
     * @param query `String`
     * @param nDaysTkn `String`
     * @return  `Intermediary`
     * @exception ValidationException
     */
    public Intermediary parseNDays(String query, String nDaysTkn) {
        String tkn = nDaysTkn;
        String subquery = consume(query, tkn);
        subquery = skipWhitespace(subquery);
        subquery = consume(subquery, Token.COLON);
        subquery = skipWhitespace(subquery);

        tkn += Token.COLON;
        while(subquery.length() != 0 && (subquery.subString(0, 1).isNumeric())) {
            tkn += subquery.subString(0, 1);
            subquery = consume(subquery, subquery.subString(0, 1));
        }
        Regex r = new Regex();
        if(!r.matches(tkn, '^' + nDaysTkn + '\\s*:\\s*[0-9]+$')) {
            throw new ValidationException('Invalid value for ' + nDaysTkn + ': ' + tkn);
        }
        return new Intermediary(
            new NodeBuilder()
                .setId(tkn)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            subquery
        );
    }
}