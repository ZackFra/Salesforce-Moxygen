/**
 * @description NumberParser is a parser for numeric values.
 * @author Zackary Frazier
 * @since 11/28/2024
 * @group Soql Engine
 */
public with sharing class NumberParser extends SubParser {
    /**
     * @description Parses a numeric value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        String numericValue = '';

        while (
            query.length() != 0 &&
            (query.subString(0, 1).isNumeric() ||
            (query.subString(0, 1) == Token.DOT))
        ) {
            if (
                query.subString(0, 1) == Token.DOT &&
                !query.subString(1, 2).isNumeric()
            ) {
                throw new ParsingException(query, 'floating point value');
            }
            numericValue += query.subString(0, 1);
            query = query.subString(1);
        }
        if (!numericValue.isNumeric()) {
            throw new ParsingException(query, NodeType.XNUMBER);
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(numericValue)
                .setNodeType(NodeType.XNUMBER)
                .build(),
            query
        );
    }
}
