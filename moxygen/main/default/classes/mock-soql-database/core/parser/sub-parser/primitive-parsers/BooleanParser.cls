public with sharing class BooleanParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);

        Boolean isTrue = (isNext(query, Token.XTRUE));
        Boolean isFalse = (isNext(query, Token.XFALSE));
        
        String boolVal;
        if(isTrue) {
            boolVal = Token.XTRUE;
        } else { 
            boolVal = Token.XFALSE;
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