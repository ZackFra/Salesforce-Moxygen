/**
 * @description NullParser is a parser for null values.
 * @author Zackary Frazier
 * @since 11/28/2024
 * @group Soql Engine
 */
public with sharing class NullParser extends SubParser {
    /**
     * @description Parses a null value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = consume(query, Token.XNULL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.XNULL)
                .setNodeType(NodeType.XNULL)
                .build(),
            query
        );
    }
}
