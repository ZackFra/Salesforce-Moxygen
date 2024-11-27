public with sharing class NullParser extends SubParser {
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