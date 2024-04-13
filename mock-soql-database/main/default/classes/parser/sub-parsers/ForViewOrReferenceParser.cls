public inherited sharing class ForViewOrReferenceParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 3) != 'for') {
            return null;
        }
        query = consume(query, 'for ');
        query = skipWhitespace(query);

        // could be FOR UPDATE, if its not view or reference, return null
        if(lookahead(query, 4) != 'view' && lookahead(query, 9) != 'reference') {
            return null;
        }

        String forType = 'view';
        if(lookahead(query, 9) == 'reference') {
            forType = 'reference';
        }

        query = consume(query, forType);
        return new Intermediary(
        	new NodeBuilder()
            	.setId('for ' + forType)
            	.setNodeType('for ' + forType)
            	.build(),
            query
        );
    }
}