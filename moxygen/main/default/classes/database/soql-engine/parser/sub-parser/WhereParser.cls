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
 * @description This class is responsible for parsing the WHERE clause of a SOQL query.
 * @author Zackary Frazier
 * @since 4/12/2024
 * @group Soql Engine
 */
public with sharing class WhereParser extends SubParser {
    /**
     * @description Parses the WHERE clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if (query.length() == 0) {
            return null;
        }
        if (!isNext(query, Token.XWHERE)) {
            return null;
        }
        query = consume(query, Token.XWHERE);
        query = consume(query, Token.WHITESPACE);

        Intermediary leftIntermediary = parseConditionalExpr(query);

        return new Intermediary(
            new NodeBuilder()
                .setId(Token.XWHERE)
                .setNodeType(NodeType.XWHERE)
                .setLeft(leftIntermediary.head)
                .build(),
            leftIntermediary.subquery
        );
    }

    private Intermediary parseConditionalExpr(String query) {
        query = skipWhitespace(query);

        Intermediary leftIntermediary;

        // work out the left intermediary first, it's either a sub-expression or a field being compared to a value
        if (isNext(query, Token.LPAREN)) {
            leftIntermediary = parseConditionalSubExpr(query);
        } else {
            leftIntermediary = parseConditionalOperationExpr(query);
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
        Intermediary restOfExpr = parseConditionalExpr(query);
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

    private Intermediary parseConditionalSubExpr(String query) {
        query = consume(query, Token.LPAREN);
        Intermediary subExpr = parseConditionalExpr(query);
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

    private Boolean isNextDateFunc(String query) {
        for (String token : Token.DATE_FUNCS) {
            if (isNext(query, token)) {
                return true;
            }
        }
        return false;
    }

    private Intermediary parseConditionalOperationExpr(String query) {
        if (isNext(query, Token.XNOT)) {
            return parseNot(query);
        }
        Intermediary fieldIntermediary;
        if (isNextDateFunc(query)) {
            fieldIntermediary = new AggregateFuncParser().parse(query);
        } else {
            fieldIntermediary = new FieldParser().parse(query);
        }
        query = fieldIntermediary.subquery;
        query = skipWhitespace(query);

        Intermediary operatorIntermediary = parseOperator(query);
        query = operatorIntermediary.subquery;
        query = skipWhitespace(query);

        Boolean isIn = operatorIntermediary.head.id == Token.XIN;
        Boolean isNotIn = operatorIntermediary.head.id == Token.XNOT_IN;
        Boolean isIncludes = operatorIntermediary.head.id == Token.XINCLUDES;
        Boolean isExcludes = operatorIntermediary.head.id == Token.XEXCLUDES;

        Boolean isExpectingList = (isIn || isNotIn || isIncludes || isExcludes);
        if (isExpectingList && isNext(query, Token.LPAREN)) {
            query = consume(query, Token.LPAREN);
            Intermediary listOrQuery = parseListOrSubquery(query);
            query = listOrQuery.subquery;
            query = skipWhitespace(query);
            query = consume(query, Token.RPAREN);
            operatorIntermediary.head.right = listOrQuery.head;
        } else if (
            isExpectingList &&
            !isNext(query, Token.LPAREN) &&
            !isNext(query, Token.COLON)
        ) {
            throw new ParsingException(query, null);
        } else {
            Intermediary valueIntermediary = new ValueParser().parse(query);
            query = valueIntermediary.subquery;
            operatorIntermediary.head.right = valueIntermediary.head;
        }
        operatorIntermediary.subquery = query;
        operatorIntermediary.head.left = fieldIntermediary.head;

        return operatorIntermediary;
    }

    private Intermediary parseListOrSubquery(String query) {
        Intermediary listOrQuery;
        if (lookahead(query, 6) == Token.XSELECT) {
            Intermediary soqlSubQuery = new QueryParser().parse(query);
            listOrQuery = new Intermediary(
                new NodeBuilder()
                    .setId(NodeType.SUBQUERY)
                    .setNodeType(NodeType.SUBQUERY)
                    .setRight(soqlSubQuery.head)
                    .build(),
                soqlSubQuery.subquery
            );
        } else {
            listOrQuery = new ValueListParser().parse(query);
        }
        return listOrQuery;
    }

    private Intermediary parseNot(String query) {
        query = consume(query, Token.XNOT);
        query = consume(query, Token.WHITESPACE);
        query = skipWhitespace(query);

        Intermediary subExpr = parseConditionalExpr(query);
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

    private Intermediary parseOperator(String query) {
        query = skipWhitespace(query);
        NodeBuilder nb = new NodeBuilder().setNodeType(NodeType.OPERATOR);

        for (String token : Token.OPERATORS) {
            if (isNext(query, token)) {
                nb.setId(token);
                query = consume(query, token);
                return new Intermediary(nb.build(), query);
            }
        }
        throw new ParsingException(query, null);
    }
}
