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
 * @description This class is responsible for parsing the ORDER BY clause of a SOQL query.
 * @author Zackary Frazier
 * @since 4/12/2024
 * @group Soql Engine
 */
public with sharing class OrderByParser extends SubParser {
    /**
     * @description Parses the ORDER BY clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if (query.length() < 5) {
            return null;
        }
        if (lookahead(query, 5) != 'order') {
            return null;
        }

        query = consume(query, 'order');
        query = consume(query, ' ');
        query = skipWhitespace(query);

        if (lookahead(query, 2) != 'by') {
            throw new ParsingException(query, 'BY');
        }

        query = consume(query, 'by');
        query = consume(query, ' ');
        query = skipWhitespace(query);

        Intermediary fieldList = parseOrderByFieldList(query);
        return new Intermediary(
            new NodeBuilder()
                .setId('order by')
                .setNodeType('order by')
                .setLeft(fieldList.head)
                .build(),
            fieldList.subquery
        );
    }

    /**
     * @description Parses the list of fields in the ORDER BY clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseOrderByFieldList(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;

        if (isAggregateFunc(query)) {
            nextItem = new AggregateFuncParser().parse(query);
        } else {
            nextItem = new FieldParser().parse(query);
        }
        query = nextItem.subquery;
        Intermediary dir = parseDirection(query);
        if (dir != null) {
            Node curr = nextItem.head;
            while (curr.right != null) {
                curr = curr.right;
            }
            curr.right = dir.head;
            nextItem.subquery = dir.subquery;
            query = skipWhitespace(dir.subquery);
        }

        Intermediary nullsDir = parseNulls(query);
        if (nullsDir != null) {
            if (dir != null) {
                dir.head.right = nullsDir.head;
            } else {
                nextItem.head.right = nullsDir.head;
            }
            nextItem.subquery = nullsDir.subquery;
            query = nullsDir.subquery;
        }
        query = skipWhitespace(nextItem.subquery);

        if (query.length() == 0) {
            return nextItem;
        }

        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(
            skipWhitespace(query.subString(1)),
            1
        );

        if (nextChar == Token.COMMA && nextCharAfterThat != Token.LPAREN) {
            query = consume(query, Token.COMMA);
            Intermediary restOfList = parseOrderByFieldList(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;
    }

    /**
     * @description Parses the direction of the ORDER BY clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseDirection(String query) {
        // @TODO: Make AggregateFuncParser consistent with FieldParser, i.e. the subquery should retain the trailing whitespace
        if (isNext(query, Token.WHITESPACE)) {
            query = consume(query, TOKEN.WHITESPACE);
        }
        query = skipWhitespace(query);
        String dir = '';
        if (lookahead(query, 3) == 'asc') {
            dir = 'asc';
            query = consume(query, 'asc');
        } else if (lookahead(query, 4) == 'desc') {
            dir = 'desc';
            query = consume(query, 'desc');
        } else {
            // may be the case that there's no direction specified
            return null;
        }
        return new Intermediary(
            new NodeBuilder().setId(dir).setNodeType('direction').build(),
            query
        );
    }

    /**
     * @description Parses the NULLS direction of the ORDER BY clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     * @exception
     */
    private Intermediary parseNulls(String query) {
        query = skipWhitespace(query);
        if (lookahead(query, 5) != 'nulls') {
            return null;
        }
        query = consume(query, 'nulls');
        query = skipWhitespace(query);
        String dir;
        if (lookahead(query, 5) == 'first') {
            dir = 'nulls first';
            query = consume(query, 'first');
        } else if (lookahead(query, 4) == 'last') {
            dir = 'nulls last';
            query = consume(query, 'last');
        } else {
            throw new ParsingException(query, 'first or last');
        }

        return new Intermediary(
            new NodeBuilder().setId(dir).setNodeType('nulls direction').build(),
            query
        );
    }
}
