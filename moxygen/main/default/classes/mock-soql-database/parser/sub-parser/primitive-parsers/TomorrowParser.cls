/**
 * @description A class to parse the TOMORROW literal 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class TomorrowParser extends SubParser {
    /**
     * @description Parse the TOMORROW literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = consume(query, Token.TOMORROW_LITERAL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.TOMORROW_LITERAL)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}