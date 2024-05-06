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
            .setNodeType(NodeType.AGGREGATE_FUNCTION);
        
        if(isNext(query, Token.COUNT_DISTINCT)) {
            query = consume(query, Token.COUNT_DISTINCT);
            nb.setId(Token.COUNT_DISTINCT);
        } else if(isNext(query, Token.COUNT)) {
            query = consume(query, Token.COUNT);
            nb.setId(Token.COUNT);
        } else if(isNext(query, Token.SUM)) {
            query = consume(query, Token.SUM);
            nb.setId(Token.SUM);
        } else if(isNext(query, Token.AVG)) {
            query = consume(query, Token.AVG);
            nb.setId(Token.AVG);
        } else if(isNext(query, Token.MIN)) {
            query = consume(query, Token.MIN);
            nb.setId(Token.MIN);
        } else if(isNext(query, Token.MAX)) {
            query = consume(query, Token.MAX);
            nb.setId(Token.MAX);
        } else if(isNext(query, Token.CALENDAR_MONTH)) {
            query = consume(query, Token.CALENDAR_MONTH);
            nb.setId(Token.CALENDAR_MONTH);
        } else if(isNext(query, Token.CALENDAR_YEAR)) {
            query = consume(query, Token.CALENDAR_YEAR);
            nb.setId(Token.CALENDAR_YEAR);
        } else {
            throw new ParsingException( query, 'aggregate function');
        }
        query = skipWhitespace(query);
        
        query = consume(query, TOKEN.LPAREN);
        if(nb.id == Token.COUNT && isNext(query, TOKEN.RPAREN)) {
            query = consume(query, TOKEN.RPAREN);
            return new Intermediary(
            	nb.build(),
                query
            );
        }

        query = skipWhitespace(query);
        Intermediary field = new FieldParser().parse(query);
        
        query = field.subquery;
        query = consume(query, Token.RPAREN);

        Intermediary alias = null;
        query = skipWhitespace(query);
        if(lookahead(query, 5) != (Token.XFROM + Token.WHITESPACE)) {
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