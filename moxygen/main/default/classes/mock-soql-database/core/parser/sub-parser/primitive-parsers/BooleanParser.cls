/**
 * @description A parser for boolean values 
 * @author Zackary Frazier
 * @since 11/25/2024
 */
public with sharing class BooleanParser extends SubParser {
    /**
     * @description Parse a boolean value
     * @param query `String`
     * @return  `Intermediary`
     */
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