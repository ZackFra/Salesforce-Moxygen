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
        Token.TOMORROW_LITERAL => TomorrowParser.class,
        Token.TODAY_LITERAL => TodayParser.class,
        Token.YESTERDAY_LITERAL => YesterdayParser.class,
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
        if(isNext(query, Token.SINGLE_QUOTE)) {
            Intermediary baseValue;
            query = query.subString(1);
            baseValue = parseString(query);
            query = baseValue.subquery;
            if(!isNext(query, Token.SINGLE_QUOTE)) {
                throw new ParsingException(baseValue.subquery, Token.SINGLE_QUOTE);
            }
            query = consume(query, Token.SINGLE_QUOTE);
            baseValue.subquery = query;
            return baseValue;
        } 
        List<String> tokens = new List<String> {
            Token.XTRUE,
            Token.XFALSE,
            Token.COLON,
            Token.XNULL,
            Token.TODAY_LITERAL,
            Token.YESTERDAY_LITERAL,
            Token.TOMORROW_LITERAL
        };
        for(String token : tokens) {
            if(isNext(query, token)) {
                Type parserType = primitiveParsers.get(token);
                SubParser primitiveParser = (SubParser) parserType.newInstance();
                return primitiveParser.parse(query);
            } else if(isSoqlDate(query)) {
                return parseDate(query);
            } else if(isSoqlDateTime(query)) {
                return parseDate(query);
            }
        } 
        return new NumberParser().parse(query);
    }

    private Boolean isSoqlDateTime(String query) {
        String dateTimeRegex1 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\+([0-9]{2}):([0-9]{2})';
        String dateTimeRegex2 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\-([0-9]{2}):([0-9]{2})';
        String dateTimeRegex3 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z';

        Pattern dateTimePattern1 = Pattern.compile(dateTimeRegex1);
        Pattern dateTimePattern2 = Pattern.compile(dateTimeRegex2);
        Pattern dateTimePattern3 = Pattern.compile(dateTimeRegex3);

        Matcher dateTimeMatcher1 = dateTimePattern1.matcher(query);
        Matcher dateTimeMatcher2 = dateTimePattern2.matcher(query);
        Matcher dateTimeMatcher3 = dateTimePattern3.matcher(query);

        return dateTimeMatcher1.matches() || dateTimeMatcher2.matches() || dateTimeMatcher3.matches();
    }

    private Boolean isSoqlDate(String query) {
        String dateRegex = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})';
        Pattern datePattern = Pattern.compile(dateRegex);
        Matcher dateMatcher = datePattern.matcher(query);
        return dateMatcher.matches();
    }

    private Intermediary parseDateLiteral(String query, String token) {
        query = consume(query, token);
        return new Intermediary(
            new NodeBuilder()
                .setId(token)
                .setNodeType(NodeType.DATE_LITERAL)
                .build(),
            query
        );
    }

    private Intermediary parseDate(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while(query.length() != 0 && !isNext(query, Token.WHITESPACE)) {
            strValue += lookahead(query, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(strValue)
            	.setNodeType(NodeType.XSTRING)
            	.build(),
            query
        );        
    }

    private Intermediary parseString(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while(query.length() != 0 && !isNext(query, Token.SINGLE_QUOTE)) {
            strValue += lookahead(query, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(strValue)
            	.setNodeType(NodeType.XSTRING)
            	.build(),
            query
        );
    }

    private Intermediary parseBoolean(String query) {
        query = skipWhitespace(query);

        Boolean isTrue = (isNext(query, Token.XTRUE));
        Boolean isFalse = (isNext(query, Token.XFALSE));
        
        if(!isTrue && !isFalse) {
        	throw new ParsingException(query, NodeType.XBOOLEAN);
        }
        
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
            query.subString(boolVal.length())
        );
    }

    private Intermediary parseNum(String query) {
        query = skipWhitespace(query);
        String numericValue = '';
        
        while(query.length() != 0 && (query.subString(0, 1).isNumeric() || (query.subString(0, 1) == Token.DOT) )) {
            if(query.subString(0, 1) == Token.DOT && !query.subString(1, 2).isNumeric()) {
                throw new ParsingException(query, 'floating point value');
            }
            numericValue += query.subString(0, 1);
            query = query.subString(1);
        }
        if(!numericValue.isNumeric()) {
            throw new ParsingException(query, NodeType.XNUMBER);
        }
        
        return new Intermediary(
        	new NodeBuilder()
            	.setId(numericValue)
            	.setNodeType(NodeType.XNUMBER)
            	.build(),
            query
        );
    }

    private Intermediary parseNull(String query) {
        query = consume(query, Token.XNULL);
        return new Intermediary(
        	new NodeBuilder()
            	.setId(Token.XNULL)
            	.setNodeType(NodeType.XNULL)
            	.build(),
            query
        );
    }
}