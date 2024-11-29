/**
 * @description A class to parse the TODAY literal 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class TodayParser extends SubParser {
    /**
     * @description Parse the TODAY literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = consume(query, Token.TODAY_LITERAL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.TODAY_LITERAL)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}