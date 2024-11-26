public with sharing class YesterdayParser extends SubParser {
    public override Intermediary parse(String query) {
        query = consume(query, Token.YESTERDAY_LITERAL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.YESTERDAY_LITERAL)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}