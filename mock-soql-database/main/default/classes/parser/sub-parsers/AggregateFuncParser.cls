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
 * @description This class is responsible for parsing aggregate functions
 * @author Zackary Frazier
 * @since 4/12/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public inherited sharing class AggregateFuncParser extends SubParser{
    /**
     * @description Parses an aggregate function
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    @SuppressWarnings('PMD.CognitiveComplexity, PMD.NcssMethodCount, PMD.CyclomaticComplexity')
    public override Intermediary parse(String query) {
        NodeBuilder nb = new NodeBuilder()
            .setNodeType('aggregate function');
        if(lookahead(query, 14) == 'count_distinct') {
            query = consume(query, 'count_distinct');
            nb.setId('count_distinct');
        } else if(lookahead(query, 5) == 'count') {
            query = consume(query, 'count');
            nb.setId('count');
        } else if(lookahead(query, 3) == 'sum') {
            query = consume(query, 'sum');
            nb.setId('sum');
        } else if(lookahead(query, 3) == 'avg') {
            query = consume(query, 'avg');
            nb.setId('avg');
        } else if(lookahead(query, 3) == 'min') {
            query = consume(query, 'min');
            nb.setId('min');
        } else if(lookahead(query, 3) == 'max') {
            query = consume(query, 'max');
            nb.setId('max');
        } else if(lookahead(query, 14) == 'calendar_month') {
            query = consume(query, 'calendar_month');
            nb.setId('calendar_month');
        } else {
            throw new ParsingException( query, 'aggregate function');
        }
        query = skipWhitespace(query);
        
        query = consume(query, '(');
        if(nb.id == 'count' && lookahead(query, 1) == ')') {
            query = consume(query, ')');
            return new Intermediary(
            	nb.build(),
                query
            );
        }

        query = skipWhitespace(query);
        Intermediary field = new FieldParser().parse(query);
        
        query = field.subquery;
        query = consume(query, ')');

        Intermediary alias = null;
        query = skipWhitespace(query);
        if(lookahead(query, 5) != 'from ') {
            // NOTE: alias might still be null after parsing, that's ok
            alias = new AliasParser().parse(query);
        }

        if(alias != null) {
            field.head.left = alias.head;
            query = alias.subquery;
        }
        nb.setRight(field.head);
        
        
        return new Intermediary(
			nb.build(),
            query
        );       
     }
}