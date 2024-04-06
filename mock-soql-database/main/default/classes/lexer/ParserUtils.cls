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
}