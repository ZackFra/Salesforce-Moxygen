public inherited sharing class LimitParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() < 5 || lookahead(query, 5) != 'limit') { 
            return null;
        }
        
        query = consume(query, 'limit ');
        query = skipWhitespace(query);
        Intermediary limitSize = new ValueParser().parse(query);
        if(limitSize.head.nodeType != 'bind variable' && limitSize.head.nodeType != 'number') {
            throw new QueryException('Invalid offset value');
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId('limit')
            	.setNodeType('limit')
            	.setLeft(limitSize.head)
            	.build(),
            limitSize.subquery
        );
    }
}