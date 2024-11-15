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
 * @description Contains utility methods for the parser, could probably be refactored out of existance though
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class ParserUtils {

    /**
     * @description Skips whitespace in a query string
     * @param query `String`
     * @return  `String`
     */
    public static String skipWhitespace(String query) {
        while(query.length() > 0 && query.substring(0, 1).isWhitespace()) {
            query = query.subString(1);
        }
        return query;
    }
    
    /**
     * @description Checks if a character is a valid character for a field or object name
     * @param character `String`
     * @return  `Boolean`
     */
    public static Boolean validCharForFieldOrObject(String character) {
        return character.isAlpha() || character == '_' || character.isNumeric();
    }

    /**
     * @description : Consumes the first token in the query if it matches the token
     * @param query : String, the query to consume
     * @param token : String, the token to consume
     * @return : String, the query with the token consumed
     * @throws ParsingException : if the token is not the first token in the query
     */
    public static String consume(String query, String token) {
        if(query.length() < token.length() || query.subString(0, token.length()).toLowerCase() != token) {
            throw new ParsingException(query, token);
        }
        return query.subString(token.length());
    }

    /** 
     * @description : Look ahead at the next numChars characters in the query
     * @param query : String, the query to look ahead in
     * @param numChars : Integer, the number of characters to look ahead
     * @return : String, the next numChars characters in the query
     */
    public static String lookahead(String query, Integer numChars) {
        if(query.length() < numChars) { 
            return query.toLowerCase();
        }
        return query.subString(0, numChars).toLowerCase();
    }

    /**
     * @description Look ahead at the next numChars characters in the query, with case sensitivity
     * @param query `String`
     * @param numChars `Integer`
     * @param isCaseSensitive `Boolean`
     * @return  `String`
     */
    public static String lookahead(String query, Integer numChars, Boolean isCaseSensitive) {
        if(!isCaseSensitive) {
            return lookahead(query, numChars);
        }

        if(query.length() < numChars) { 
            return query;
        }
        return query.subString(0, numChars);
    }

    /**
     * @description Lowercases every node's id that isn't an alias 
     * @param head `Node`
     */
    public static void applyCasing(Node head) {
        if(head == null) {
            return;
        }

        if(head.nodeType != 'alias') {
            head.id = head.id.toLowerCase();
        }

        applyCasing(head.left);
        applyCasing(head.right);
    }    
}