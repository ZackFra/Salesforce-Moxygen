public inherited sharing class OperatorParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        NodeBuilder nb = new NodeBuilder()
            .setNodeType('operator');
        List<String> opTokens = new List<String> {
            'includes',
            'excludes',
            'like',
            '!=',
            '<>',
            '<=',
            '>=',
            'in',
            'not in',
            '=',
            '>',
            '<'
        };
        for(String token : opTokens) {
            if(query.length() >= token.length() && lookahead(query, token.length()) == token) {
                nb.setId(token);
                query = consume(query, token);
                return new Intermediary(
                    nb.build(),
                    query
                );
            }
        }
        throw new ParsingException(query, null);
    }
}