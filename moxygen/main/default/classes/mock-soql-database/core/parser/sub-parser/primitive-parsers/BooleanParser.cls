public with sharing class BooleanParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        
        String boolVal = Token.XFALSE;
        if(isNext(query, Token.XTRUE)) {
            boolVal = Token.XTRUE;
        }
        
        return new Intermediary(
            new NodeBuilder()
                .setId(boolVal)
                .setNodeType(NodeType.XBOOLEAN)
                .build(),
            query.subString(boolVal.length()
        )
        );
    }
}