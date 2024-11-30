/**
 * @description Factory class for primitive parsers 
 * @author Zackary Frazier
 * @since 11/30/2024
 */
public with sharing class PrimitiveParserFactory {
    static Map<String, Type> primitiveParsers = new Map<String, Type> {
        Token.SINGLE_QUOTE => StringParser.class,
        Token.TOMORROW_LITERAL => TomorrowParser.class,
        Token.TODAY_LITERAL => TodayParser.class,
        Token.YESTERDAY_LITERAL => YesterdayParser.class,
        Token.LAST_WEEK_LITERAL => LastWeekParser.class,
        Token.THIS_WEEK_LITERAL => ThisWeekParser.class,
        Token.XTRUE => BooleanParser.class,
        Token.XFALSE => BooleanParser.class,
        Token.XNULL => NullParser.class,
        Token.COLON => BindVariableParser.class
    };

    static Set<String> getPrimitiveParserTokens() {
        return primitiveParsers.keySet();
    }

    /**
     * @description Returns the primitive parser based on the token
     * @param token `String`
     * @return  `SubParser`
     */
    public static SubParser getPrimitiveParser(String token) {
        Type parserType = primitiveParsers.get(token);
        return (SubParser) parserType.newInstance();
    }
}