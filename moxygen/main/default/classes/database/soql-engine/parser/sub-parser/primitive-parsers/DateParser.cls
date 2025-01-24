/**
 * @description DateParser is a parser for date values.
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public with sharing class DateParser extends SubParser {
    /**
     * @description Parses a date value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while (query.length() != 0 && !isNext(query, Token.WHITESPACE)) {
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
