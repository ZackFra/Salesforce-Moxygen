/**
 * @description Parser for the LAST_WEEK token
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public with sharing class LastWeekParser extends SubParser {
    /**
     * @description Parses the LAST_WEEK value from a query string.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = consume(query, Token.LAST_WEEK_LITERAL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.LAST_WEEK_LITERAL)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}