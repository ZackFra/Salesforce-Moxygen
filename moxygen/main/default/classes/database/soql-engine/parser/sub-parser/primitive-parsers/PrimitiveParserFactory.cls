/**
 * @description Factory class for primitive parsers
 * @author Zackary Frazier
 * @since 11/30/2024
 * @group Soql Engine
 */
public with sharing class PrimitiveParserFactory {
    @TestVisible
    static Map<String, Type> parserTypeByToken = new Map<String, Type>{
        Token.SINGLE_QUOTE => StringParser.class,
        Token.XTRUE => BooleanParser.class,
        Token.XFALSE => BooleanParser.class,
        Token.XNULL => NullParser.class,
        Token.COLON => BindVariableParser.class
    };

    static {
        for (String dateLiteralToken : Token.DATE_LITERAL_TOKENS) {
            parserTypeByToken.put(dateLiteralToken, DateLiteralParser.class);
        }
    }

    @TestVisible
    static Set<String> getPrimitiveParserTokens() {
        return parserTypeByToken.keySet();
    }

    /**
     * @description Returns the appropriate primitive parser for the given query
     * @param query `String`
     * @return  `SubParser`
     */
    public static SubParser getPrimitiveParser(String query) {
        if (isSoqlDateOrDateTime(query)) {
            return new DateParser();
        }

        Set<String> expectedTokens = getPrimitiveParserTokens();
        for (String token : expectedTokens) {
            if (ParserUtils.isNext(query, token)) {
                Type parserType = parserTypeByToken.get(token);
                SubParser primitiveParser = (SubParser) parserType.newInstance();
                primitiveParser.setToken(token);
                return primitiveParser;
            }
        }

        // if none of the others, assume it's a number
        return new NumberParser();
    }

    private static Boolean isSoqlDateOrDateTime(String query) {
        return isSoqlDate(query) || isSoqlDateTime(query);
    }

    private static Boolean isSoqlDateTime(String query) {
        String dateTimeRegex1 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\+([0-9]{2}):([0-9]{2})';
        String dateTimeRegex2 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\-([0-9]{2}):([0-9]{2})';
        String dateTimeRegex3 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z';
        Regex reg = new Regex();
        return reg.matches(query, dateTimeRegex1) ||
            reg.matches(query, dateTimeRegex2) ||
            reg.matches(query, dateTimeRegex3);
    }

    private static Boolean isSoqlDate(String query) {
        String dateRegex = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})';
        Regex reg = new Regex();
        return reg.matches(query, dateRegex);
    }
}
