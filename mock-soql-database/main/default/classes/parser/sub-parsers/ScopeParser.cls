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
  * @description This class is responsible for parsing the scope clause of a SOQL query 
  * @author Zackary Fraizer
  * @since 4/12/2024
  */
public inherited sharing class ScopeParser extends SubParser {

    /**
     * @description Parses the scope clause of a SOQL query
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() < 5 || lookahead(query, 5) != 'using') {
            return null;
        }

        query = consume(query, 'using ');
        query = skipWhitespace(query);
        query = consume(query, 'scope ');

        query = skipWhitespace(query);
        Intermediary scope = parseScopeName(query);
        query = scope.subquery;
        return new Intermediary(
        	new NodeBuilder()
            	.setId('using scope')
            	.setNodeType('using scope')
            	.setLeft(scope.head)
            	.build(),
            query
        );   
    }

    /**
     * @description Parses the scope name from the query
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    private Intermediary parseScopeName(String query) {
        String scopeName = '';
        while(ParserUtils.validCharForFieldOrObject(lookahead(query, 1))) {
            scopeName += lookahead(query, 1);
            query = query.subString(1);
        }

        if(scopeName.isNumeric()) {
            throw new ParsingException(scopeName, 'scope name');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(scopeName)
                .setNodeType('scope')
                .build(),
            query
        );
    }
}