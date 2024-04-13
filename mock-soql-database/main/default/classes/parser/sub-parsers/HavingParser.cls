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
        if(query.length() < 6 || lookahead(query, 6) != 'having') {
            return null;
        }

        query = consume(query, 'having ');
        query = skipWhitespace(query);
        Intermediary conditionalExpr = parseHavingConditionalExpr(query);
        query = conditionalExpr.subquery;
        
        return new Intermediary(
            new NodeBuilder()
                .setId('having')
                .setNodeType('having')
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
        if(lookahead(query, 1) == '(') {
            leftIntermediary = parseHavingConditionalSubExpr(query);
        } else {
            leftIntermediary = parseHavingConditionalOperationExpr(query);
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
        Intermediary restOfExpr = parseHavingConditionalExpr(query);
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

    /**
     * @description Parses a sub-expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseHavingConditionalSubExpr(String query) {
        query = consume(query, '(');
        Intermediary subExpr = parseHavingConditionalExpr(query);
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

    /**
     * @description Parses a conditional operation expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    private Intermediary parseHavingConditionalOperationExpr(String query) {
        if(lookahead(query, 3) == 'not') {
            return parseHavingNot(query);
        }
        Intermediary nextItem;
        if(isAggregateFunc(query)) {
            nextItem = new AggregateFuncParser().parse(query);
        } else {
            nextItem = new FieldParser().parse(query);
        }
        query = nextItem.subquery;
        query = skipWhitespace(query);

        Intermediary operatorIntermediary = new OperatorParser().parse(query);
        query = operatorIntermediary.subquery;
        query = skipWhitespace(query);
        Boolean isIn = operatorIntermediary.head.id == 'in';
        Boolean isNotIn = operatorIntermediary.head.id == 'not in';
        if((isIn || isNotIn) && lookahead(query, 1) == '(') {
            query = consume(query, '(');
            Intermediary listOrQuery;
            if(lookahead(query, 6) == 'select') {
                throw new ParsingException(query, 'subquery');
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
        operatorIntermediary.head.left = nextItem.head;

        return operatorIntermediary;
    }

    /**
     * @description Parses a NOT expression of the HAVING clause of a SOQL query.
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseHavingNot(String query) {
        query = consume(query, 'not');
        query = consume(query, ' ');
        query = skipWhitespace(query);

        Intermediary subExpr = parseHavingConditionalExpr(query);
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
}