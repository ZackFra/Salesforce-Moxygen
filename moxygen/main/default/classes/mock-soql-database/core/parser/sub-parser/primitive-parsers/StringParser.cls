public with sharing class StringParser extends SubParser {
    public override Intermediary parse(String query) {
        Intermediary baseValue;
        query = query.subString(1);
        baseValue = parseString(query);
        query = baseValue.subquery;
        if(!isNext(query, Token.SINGLE_QUOTE)) {
            throw new ParsingException(baseValue.subquery, Token.SINGLE_QUOTE);
        }
        query = consume(query, Token.SINGLE_QUOTE);
        baseValue.subquery = query;
        return baseValue;
    }

    private Intermediary parseString(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while(query.length() != 0 && !isNext(query, Token.SINGLE_QUOTE)) {
            strValue += lookahead(query, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(strValue)
            	.setNodeType(NodeType.XSTRING)
            	.build(),
            query
        );
    }
}