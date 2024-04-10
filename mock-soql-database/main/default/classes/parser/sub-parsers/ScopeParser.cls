public inherited sharing class ScopeParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
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