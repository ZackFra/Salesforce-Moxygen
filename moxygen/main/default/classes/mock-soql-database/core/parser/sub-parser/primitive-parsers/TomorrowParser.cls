public with sharing class TomorrowParser extends SubParser {
    public override Intermediary parse(String query) {
        query = consume(query, Token.TOMORROW_LITERAL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.TOMORROW_LITERAL)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}