/**
 * @description A class to parse the yesterday literal 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class YesterdayParser extends SubParser {
    /**
     * @description Parse the yesterday literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = consume(query, Token.YESTERDAY_LITERAL);
        return new Intermediary(
            new NodeBuilder()
                .setId(Token.YESTERDAY_LITERAL)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}