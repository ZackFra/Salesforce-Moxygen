public inherited sharing class ScopeParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() < 5 || lookahead(query, 5) != 'using') {
            return null;
        }

        query = consume(query, 'using ');
        query = skipWhitespace(query);
        query = consume(query, 'scope ');

        query = skipWhitespace(query);
        Intermediary scope = parseScopeName(query);
        query = scope.subquery;
        return new Intermediary(
        	new NodeBuilder()
            	.setId('using scope')
            	.setNodeType('using scope')
            	.setLeft(scope.head)
            	.build(),
            query
        );   
    }

    private Intermediary parseScopeName(String query) {
        String scopeName = '';
        while(ParserUtils.validCharForFieldOrObject(lookahead(query, 1))) {
            scopeName += lookahead(query, 1);
            query = query.subString(1);
        }

        if(scopeName.isNumeric()) {
            throw new ParsingException(scopeName, 'scope name');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(scopeName)
                .setNodeType('scope')
                .build(),
            query
        );
    }
}