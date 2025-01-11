/**
 * @description A class to parse a generic string
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public inherited sharing class StringParser extends SubParser {
    /**
     * @description Parse a generic string
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        Intermediary baseValue;
        query = query.subString(1);
        baseValue = parseString(query);
        query = baseValue.subquery;
        if (!isNext(query, Token.SINGLE_QUOTE)) {
            throw new ParsingException(baseValue.subquery, Token.SINGLE_QUOTE);
        }
        query = consume(query, Token.SINGLE_QUOTE);
        baseValue.subquery = query;
        return baseValue;
    }

    private Intermediary parseString(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while (query.length() != 0 && !isNext(query, Token.SINGLE_QUOTE)) {
            strValue += lookahead(query, 1);
            query = query.subString(1);
        }
        return new Intermediary(
            new NodeBuilder()
                .setId(strValue)
                .setNodeType(NodeType.XSTRING)
                .build(),
            query
        );
    }
}
