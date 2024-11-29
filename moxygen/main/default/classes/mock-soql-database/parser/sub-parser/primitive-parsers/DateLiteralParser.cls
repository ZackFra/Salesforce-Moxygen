/**
 * @description Generic date literal parser 
 * @author Zackary Frazier
 * @since 11/29/2024
 */
public abstract class DateLiteralParser extends SubParser {
    /**
     * @description Parse the TODAY literal
     * @param query `String`
     * @return  `Intermediary`
     */
    public Intermediary parse(String query, String token) {
        query = consume(query, token);
        return new Intermediary(
            new NodeBuilder()
                .setId(token)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }
}