/**
 * @description Generic date literal parser
 * @author Zackary Frazier
 * @since 11/29/2024
 * @group Soql Engine
 */
public class DateLiteralParser extends SubParser {
    // symbol that denotes this is a variable value, e.g. LAST_N_DAYS:5, LAST_N_WEEKS:3
    static final String VARIABLE_SINGNIFIER = 'n_';

    public override Intermediary parse(String query) {
        if (this.tkn.contains(VARIABLE_SINGNIFIER)) {
            return parseN(query, this.tkn);
        }
        return parse(query, this.tkn);
    }

    /**
     * @description Parse a generic date literal
     * @param query `String`
     * @param token `String`
     * @return  `Intermediary`
     */
    private Intermediary parse(String query, String token) {
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
     * @description For the variable date literals (N_DAYS_AGO:5, etc.), parse the query and return the token
     * @param query `String`
     * @param nDaysTkn `String`
     * @return  `Intermediary`
     * @exception ValidationException
     */
    private Intermediary parseN(String query, String nDaysTkn) {
        String tkn = nDaysTkn;
        String subquery = consume(query, tkn);
        subquery = skipWhitespace(subquery);
        subquery = consume(subquery, Token.COLON);
        subquery = skipWhitespace(subquery);

        tkn += Token.COLON;
        while (
            subquery.length() != 0 && (subquery.subString(0, 1).isNumeric())
        ) {
            tkn += subquery.subString(0, 1);
            subquery = consume(subquery, subquery.subString(0, 1));
        }
        Regex r = new Regex();
        if (!r.matches(tkn, '^' + nDaysTkn + '\\s*:\\s*[0-9]+$')) {
            throw new ValidationException(
                'Invalid value for ' + nDaysTkn + ': ' + tkn
            );
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
