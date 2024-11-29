/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

 /**
  * @description This class is responsible for parsing values in the query string 
  * @author Zackary Frazier
  * @since 4/12/2024
  */
public inherited sharing class ValueParser extends SubParser {

    Map<String, Type> primitiveParsers = new Map<String, Type> {
        Token.SINGLE_QUOTE => StringParser.class,
        Token.TOMORROW_LITERAL => TomorrowParser.class,
        Token.TODAY_LITERAL => TodayParser.class,
        Token.YESTERDAY_LITERAL => YesterdayParser.class,
        Token.LAST_WEEK_LITERAL => LastWeekParser.class,
        Token.XTRUE => BooleanParser.class,
        Token.XFALSE => BooleanParser.class,
        Token.XNULL => NullParser.class,
        Token.COLON => BindVariableParser.class
    };

    /**
     * @description Parses the value in the query string
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        
        Intermediary intermediary = tryParsingPredictableQueries(query);
        if(intermediary != null) {
            return intermediary;
        }
        
        if(isSoqlDateOrDateTime(query)) {
            return tryParsingDateOrDateTime(query);
        }

        return tryParsingAsNumber(query);
    }

    private Intermediary tryParsingPredictableQueries(String query) {
        Set<String> expectedTokens = primitiveParsers.keySet();
        for(String token : expectedTokens) {
            if(isNext(query, token)) {
                Type parserType = primitiveParsers.get(token);
                SubParser primitiveParser = (SubParser) parserType.newInstance();
                return primitiveParser.parse(query);
            }
        }
        return null;
    }

    private Intermediary tryParsingDateOrDateTime(String query) {
        try {
            return new DateParser().parse(query);
        } catch(Exception e) {
            throw new ParsingException(query, null);
        }
    }

    private Intermediary tryParsingAsNumber(String query) {
        try {
            return new NumberParser().parse(query);
        } catch(Exception e) {
            throw new ParsingException(query, null);
        }
    }

    private Boolean isSoqlDateOrDateTime(String query) {
        return isSoqlDate(query) || isSoqlDateTime(query);
    }

    private Boolean isSoqlDateTime(String query) {
        String dateTimeRegex1 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\+([0-9]{2}):([0-9]{2})';
        String dateTimeRegex2 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\-([0-9]{2}):([0-9]{2})';
        String dateTimeRegex3 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z';
        Regex reg = new Regex();
        return reg.matches(query, dateTimeRegex1) || reg.matches(query, dateTimeRegex2) || reg.matches(query, dateTimeRegex3);
    }

    private Boolean isSoqlDate(String query) {
        String dateRegex = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})';
        Regex reg = new Regex();
        return reg.matches(query, dateRegex);
    }
}