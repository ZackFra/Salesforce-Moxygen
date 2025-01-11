/**
 * @description A class to parse a bind variable
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public with sharing class BindVariableParser extends SubParser {
    /**
     * @description Parse a bind variable
     * @param query `String`
     * @return  `Intermediary`
     * @exception
     */
    public override Intermediary parse(String query) {
        query = consume(query, Token.COLON);
        query = skipWhitespace(query);
        String bindVarName = '';
        while (query.length() > 0 && isNextTokenFieldOrObject(query)) {
            bindVarName += query.subString(0, 1);
            query = query.subString(1);
        }

        if (bindVarName.isNumeric()) {
            throw new ParsingException(bindVarName, 'bind variable name');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(bindVarName)
                .setNodeType(NodeType.XBIND_VARIABLE)
                .build(),
            query
        );
    }
}
