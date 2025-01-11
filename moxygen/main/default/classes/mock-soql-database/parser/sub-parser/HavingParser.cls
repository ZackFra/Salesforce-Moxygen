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
 * @description This class is responsible for parsing the HAVING clause of a SOQL query.
 * @author Zackary Frazier
 * @since 4/12/2024
 */
public inherited sharing class HavingParser extends SubParser {
    /**
     * @description Parses the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);

        if (!isNext(query, Token.XHAVING)) {
            return null;
        }
        query = consume(query, Token.XHAVING);
        query = consume(query, Token.WHITESPACE);
        query = skipWhitespace(query);
        Intermediary conditionalExpr = parseHavingConditionalExpr(query);
        query = conditionalExpr.subquery;

        return new Intermediary(
            new NodeBuilder()
                .setId(NodeType.XHAVING)
                .setNodeType(NodeType.XHAVING)
                .setLeft(conditionalExpr.head)
                .build(),
            query
        );
    }

    /**
     * @description Parses the conditional expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseHavingConditionalExpr(String query) {
        query = skipWhitespace(query);

        Intermediary leftIntermediary;

        // work out the left intermediary first, it's either a sub-expression or a field being compared to a value
        if (isNext(query, Token.LPAREN)) {
            leftIntermediary = parseHavingConditionalSubExpr(query);
        } else {
            leftIntermediary = parseHavingConditionalOperationExpr(query);
        }
        query = leftIntermediary.subquery;
        query = skipWhitespace(query);

        // if the next token is an AND or OR, parse it
        String nextToken = null;
        if (isNext(query, Token.XAND)) {
            nextToken = Token.XAND;
        }

        if (isNext(query, Token.XOR)) {
            nextToken = Token.XOR;
        }

        if (nextToken == null) {
            return leftIntermediary;
        }

        query = consume(query, nextToken);
        if (!isNext(query, Token.LPAREN)) {
            query = consume(query, Token.WHITESPACE);
        }
        Intermediary restOfExpr = parseHavingConditionalExpr(query);
        query = restOfExpr.subquery;

        Node head = new NodeBuilder()
            .setId(nextToken)
            .setNodeType(nextToken)
            .setLeft(leftIntermediary.head)
            .setRight(restOfExpr.head)
            .build();

        Node prev = head;
        Node curr = head.right;
        while (curr != null) {
            if (curr.nodeType == NodeType.XOR) {
                prev.right = curr.left;
                curr.left = head;
                head = curr;
            }
            curr = curr.right;
        }

        return new Intermediary(head, query);
    }

    /**
     * @description Parses a sub-expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseHavingConditionalSubExpr(String query) {
        query = consume(query, Token.LPAREN);
        Intermediary subExpr = parseHavingConditionalExpr(query);
        query = subExpr.subquery;
        query = consume(query, Token.RPAREN);
        return new Intermediary(
            new NodeBuilder()
                .setId(NodeType.CONDITONAL_SUBEXPRESSION)
                .setNodeType(NodeType.CONDITONAL_SUBEXPRESSION)
                .setLeft(subExpr.head)
                .build(),
            query
        );
    }

    /**
     * @description Parses a conditional operation expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    private Intermediary parseHavingConditionalOperationExpr(String query) {
        if (isNext(query, Token.XNOT)) {
            return parseHavingNot(query);
        }
        Intermediary nextItem;
        if (isAggregateFunc(query)) {
            nextItem = new AggregateFuncParser().parse(query);
        } else {
            nextItem = new FieldParser().parse(query);
        }
        query = nextItem.subquery;
        query = skipWhitespace(query);

        Intermediary operatorIntermediary = new OperatorParser().parse(query);
        query = operatorIntermediary.subquery;
        query = skipWhitespace(query);
        Boolean isIn = operatorIntermediary.head.id == Token.XIN;
        Boolean isNotIn = operatorIntermediary.head.id == Token.XNOT_IN;
        if ((isIn || isNotIn) && isNext(query, Token.LPAREN)) {
            query = consume(query, Token.LPAREN);
            Intermediary listOrQuery;
            if (isNext(query, Token.XSELECT)) {
                throw new ParsingException(query, 'subquery');
            } else {
                listOrQuery = new ValueListParser().parse(query);
            }
            query = listOrQuery.subquery;
            query = skipWhitespace(query);

            query = consume(query, Token.RPAREN);

            operatorIntermediary.head.right = listOrQuery.head;
        } else {
            Intermediary valueIntermediary = new ValueParser().parse(query);
            query = valueIntermediary.subquery;
            operatorIntermediary.head.right = valueIntermediary.head;
        }
        operatorIntermediary.subquery = query;
        operatorIntermediary.head.left = nextItem.head;

        return operatorIntermediary;
    }

    /**
     * @description Parses a NOT expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseHavingNot(String query) {
        query = consume(query, Token.XNOT);
        query = consume(query, Token.WHITESPACE);
        query = skipWhitespace(query);

        Intermediary subExpr = parseHavingConditionalExpr(query);
        query = subExpr.subquery;
        return new Intermediary(
            new NodeBuilder()
                .setId(NodeType.XNOT)
                .setNodeType(NodeType.XNOT)
                .setLeft(subExpr.head)
                .build(),
            query
        );
    }
}
