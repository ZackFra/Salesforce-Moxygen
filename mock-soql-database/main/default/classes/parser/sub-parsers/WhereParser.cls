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
 */
public inherited sharing class WhereParser extends SubParser {
    /**
     * @description Parses the WHERE clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 5) != 'where') {
            return null;
        }
        query = consume(query, 'where ');
        
        Intermediary leftIntermediary = parseConditionalExpr(query);
        
        return new Intermediary(
            new NodeBuilder()
                .setId('where')
                .setNodeType('where')
                .setLeft(leftIntermediary.head)
                .build(),
            leftIntermediary.subquery
        );
    }

    private Intermediary parseConditionalExpr(String query) {
        query = skipWhitespace(query);

        Intermediary leftIntermediary;

        // work out the left intermediary first, it's either a sub-expression or a field being compared to a value
        if(lookahead(query, 1) == '(') {
            leftIntermediary = parseConditionalSubExpr(query);
        } else {
            leftIntermediary = parseConditionalOperationExpr(query);
        }
        query = leftIntermediary.subquery;
        query = skipWhitespace(query);

        // if the next token is an AND or OR, parse it
        String token = null;
        if(lookahead(query, 3) == 'and') {
            token = 'and';
        }

        if(lookahead(query, 2) == 'or') {
            token = 'or';
        }

        if(token == null) {
            return leftIntermediary;
        }

        query = consume(query, token);
        if(lookahead(query, 1) != '(') {
            query = consume(query, ' ');
        }
        Intermediary restOfExpr = parseConditionalExpr(query);
        query = restOfExpr.subquery;

        Node head = new NodeBuilder()
                .setId(token)
                .setNodeType(token)
                .setLeft(leftIntermediary.head)
                .setRight(restOfExpr.head)
                .build();

        Node prev = head;
        Node curr = head.right;
        while(curr != null) {
            if(curr.nodeType == 'or') {
                prev.right = curr.left;
                curr.left = head;
                head = curr;
            }
            curr = curr.right;
        }

        return new Intermediary(
            head,
            query
        );
    }

    private Intermediary parseConditionalSubExpr(String query) {
        query = consume(query, '(');
        Intermediary subExpr = parseConditionalExpr(query);
        query = subExpr.subquery;
        query = consume(query, ')');
        return new Intermediary(
            new NodeBuilder()
                .setId('conditional subexpression')
                .setNodeType('conditional subexpression')
                .setLeft(subExpr.head)
                .build(),
            query
        );
    }

    private Intermediary parseConditionalOperationExpr(String query) {
        if(lookahead(query, 3) == 'not') {
            return parseNot(query);
        }
        Intermediary fieldIntermediary;
        if(AggregateService.isDateFunc('aggregate function', lookahead(query, 14).toLowercase())) {
            fieldIntermediary = new AggregateFuncParser().parse(query);
        } else {
            fieldIntermediary = new FieldParser().parse(query);
        }
        query = fieldIntermediary.subquery;
        query = skipWhitespace(query);

        Intermediary operatorIntermediary = parseOperator(query);
        query = operatorIntermediary.subquery;
        query = skipWhitespace(query);

        Boolean isIn = operatorIntermediary.head.id == 'in';
        Boolean isNotIn = operatorIntermediary.head.id == 'not in';
        Boolean isIncludes = operatorIntermediary.head.id == 'includes';
        Boolean isExcludes = operatorIntermediary.head.id == 'excludes';
        
        Boolean isExpectingList = (isIn || isNotIn || isIncludes || isExcludes);
        if(isExpectingList && lookahead(query, 1) == '(') {
            query = consume(query, '(');
            Intermediary listOrQuery;
            if(lookahead(query, 6) == 'select') {
                Intermediary soqlSubQuery = new QueryParser().parse(query);
                listOrQuery = new Intermediary(
                    new NodeBuilder()
                        .setId('subquery')
                        .setNodeType('subquery')
                        .setRight(soqlSubQuery.head)
                        .build(),
                    soqlSubQuery.subquery
                );
            } else {
                listOrQuery = new ValueListParser().parse(query);
            }
            query = listOrQuery.subquery;
            query = skipWhitespace(query);

            query = consume(query, ')');

            operatorIntermediary.head.right = listOrQuery.head;
        } else {
            Intermediary valueIntermediary = new ValueParser().parse(query);
            query = valueIntermediary.subquery;
            operatorIntermediary.head.right = valueIntermediary.head;
        }
        operatorIntermediary.subquery = query;
        operatorIntermediary.head.left = fieldIntermediary.head;

        return operatorIntermediary;
    }

    private Intermediary parseNot(String query) {
        query = consume(query, 'not');
        query = consume(query, ' ');
        query = skipWhitespace(query);

        Intermediary subExpr = parseConditionalExpr(query);
        query = subExpr.subquery;
        return new Intermediary(
            new NodeBuilder()
                .setId('not')
                .setNodeType('not')
                .setLeft(subExpr.head)
                .build(),
            query
        );
    }


    private Intermediary parseOperator(String query) {
        query = skipWhitespace(query);
        NodeBuilder nb = new NodeBuilder()
            .setNodeType('operator');
        List<String> opTokens = new List<String> {
            'includes',
            'excludes',
            'like',
            '!=',
            '<>',
            '<=',
            '>=',
            'in',
            'not in',
            '=',
            '>',
            '<'
        };
        for(String token : opTokens) {
            if(query.length() >= token.length() && lookahead(query, token.length()) == token) {
                nb.setId(token);
                query = consume(query, token);
                return new Intermediary(
                	nb.build(),
                    query
                );
            }
        }
        throw new ParsingException(query, null);
    }
}