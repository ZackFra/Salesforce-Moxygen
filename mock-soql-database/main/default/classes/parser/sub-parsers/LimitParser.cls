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
 * @description This class is responsible for parsing the limit clause of a query
 * @author Zackary Frazier
 * @since 4/12/2024
 */
public inherited sharing class LimitParser extends SubParser {

    /**
     * @description Parses the limit clause of a query
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() < 5 || lookahead(query, 5) != 'limit') { 
            return null;
        }
        
        query = consume(query, 'limit ');
        query = skipWhitespace(query);
        Intermediary limitSize = new ValueParser().parse(query);
        if(limitSize.head.nodeType != 'bind variable' && limitSize.head.nodeType != 'number') {
            throw new ParsingException('Invalid offset value');
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId('limit')
            	.setNodeType('limit')
            	.setLeft(limitSize.head)
            	.build(),
            limitSize.subquery
        );
    }
}