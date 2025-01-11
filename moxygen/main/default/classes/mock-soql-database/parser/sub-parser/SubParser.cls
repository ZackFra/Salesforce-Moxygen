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
 * @description SubParser is an abstract class that provides helper methods for parsing subqueries.
 * @author Zackary Frazier
 * @since 4/12/2024
 */
@SuppressWarnings('PMD.CognitiveComplexity')
public abstract class SubParser {

    protected String tkn;

    /**
     * @description Sets the token for the parser
     * @param token `String`
     */
    public void setToken(String token) {
        this.tkn = token;
    }

    /**
     * @description Parses a subquery and returns an `Intermediary` object.
     * @param query `String`
     * @return  `Intermediary`
     */
    public abstract Intermediary parse(String query);

    /* private helper methods */

    protected String consume(String query, String token) {
        return ParserUtils.consume(query, token);
    }

    protected String lookahead(String query, Integer numChars) {
        return ParserUtils.lookahead(query, numChars);
    }

    protected String lookahead(String query, Integer numChars, Boolean isCaseSensitive) {
        return ParserUtils.lookahead(query, numChars, isCaseSensitive);
    }

    protected void applyCasing(Node head) {
        ParserUtils.applyCasing(head);
    }

    protected String skipWhitespace(String query) {
        return ParserUtils.skipWhitespace(query);
    }

    protected Boolean isSubField(String query) {
        Boolean isLongEnough = (query.length() >= 3);
        Boolean isValidChar = isLongEnough && ParserUtils.validCharForFieldOrObject(query.subString(0, 1));
        Boolean isDot = isValidChar && query.subString(1, 2) == '.';
        Boolean isSubField = isDot && ParserUtils.validCharForFieldOrObject(query.subString(2, 3));
        return isSubField;
    }

    protected Boolean isNextTokenFieldOrObject(String query) {
        return ParserUtils.validCharForFieldOrObject(lookahead(query, 1));
    }

    protected Map<String, String> getFieldName(String query) {
        query = skipWhitespace(query);
        String fieldName = '';
        while(query.length() != 0 && 
              isNextTokenFieldOrObject(query) ||
              isSubField(query)) {

            if(isSubField(query)) {
                fieldName += lookahead(query, 3);
                query = query.subString(3);
            } else {
                fieldName += lookahead(query, 1);
                query = query.subString(1);
            }
        }
        
        if(fieldName.isNumeric()) {
            throw new ParsingException(fieldName, 'field name');
        }

        Map<String, String> dataMap = new Map<String, String> {
            'fieldName' => fieldName,
            'subquery' => query
        };
        return dataMap;
    }

    protected Boolean isAggregateFunc(String query) {
        query = skipWhitespace(query);
        Boolean isLongEnough = (query.length() >= 3);
        if(!isLongEnough) {
            return false;
        }
        for(String aggregateFunc : AggregateService.SUPPORTED_AGGREGATE_FUNCS) {
            if(isNext(query, aggregateFunc)) {
                return true;
            }
        }
        return false;
    }

    protected Boolean isNext(String query, String token) {
        return ParserUtils.isNext(query, token);
    }

    protected Boolean isProtectedKeyword(String query) {
        query = skipWhitespace(query);
        for(String keyword : Token.PROTECTED_KEYWORDS) {
            if(isNext(query, keyword)) {
                return true;
            }
        }
        return false;
    }
}