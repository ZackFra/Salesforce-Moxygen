public inherited sharing class OffsetParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 6) != 'offset') {
            return null;
        }

        query = consume(query, 'offset ');
        query = skipWhitespace(query);
        Intermediary offsetValue = new ValueParser().parse(query);
        if(offsetValue.head.nodeType != 'bind variable' && offsetValue.head.nodeType != 'number') {
            throw new QueryException('Invalid offset value');
        }
        query = offsetValue.subquery;

        return new Intermediary(
        	new NodeBuilder()
            	.setId('offset')
            	.setNodeType('offset')
            	.setLeft(offsetValue.head)
            	.build(),
            query
        );
    }
}