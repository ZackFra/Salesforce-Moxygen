public with sharing class TodayParser extends SubParser {
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