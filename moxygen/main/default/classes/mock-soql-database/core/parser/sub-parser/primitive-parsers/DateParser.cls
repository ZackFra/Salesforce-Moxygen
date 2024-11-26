public with sharing class DateParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while(query.length() != 0 && !isNext(query, Token.WHITESPACE)) {
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