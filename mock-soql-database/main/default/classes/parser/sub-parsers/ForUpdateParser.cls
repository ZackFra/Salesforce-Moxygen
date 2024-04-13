public inherited sharing class ForUpdateParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() == 0 || query.length() < 3) { 
            return null;
        }
        if(lookahead(query, 3) != 'for') {
            return null;
        }
        
        query = query.subString(3);
        query = skipWhitespace(query);
        query = consume(query, 'update');
        
        return new Intermediary(
        	new NodeBuilder()
            	.setId('for update')
            	.setNodeType('for update')
            	.build(),
            query
        );
    }
}