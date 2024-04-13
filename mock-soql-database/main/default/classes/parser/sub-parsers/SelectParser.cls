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
  * @description Parser for the SELECT clause
  * @author Zackary Frazier
  * @since 4/12/2024
  */
@SuppressWarnings('PMD.CognitiveComplexity')
public inherited sharing class SelectParser extends SubParser {

    private FieldParser fieldParser = new FieldParser();

    public override Intermediary parse(String query) {
        query = consume(query, 'select ');
        Intermediary leftIntermediary = parseSelectExpr(query);
        query = leftIntermediary.subquery;
        return new Intermediary(
        	new NodeBuilder()
            	.setId('select')
            	.setNodeType('select')
            	.setLeft(leftIntermediary.head)
            	.build(),
            query
        );
    }
    
    private Intermediary parseSelectExpr(String query) {
        query = skipWhitespace(query);
        Intermediary selectExpr;

        if(isTypeOf(query)) {
            selectExpr = parseTypeOf(query);
            query = selectExpr.subquery;
        } else if(isAggregateFunc(query)) {
            selectExpr = new AggregateFuncParser().parse(query);
            query = selectExpr.subquery;
        } else if(lookahead(query, 1) == '(') {
            query = consume(query, '(');
            Intermediary soqlSubQuery = new QueryParser().parse(query);
            query = soqlSubQuery.subquery;
            query = skipWhitespace(query);
            query = consume(query, ')');
            selectExpr = new Intermediary(
            	new NodeBuilder()
                	.setId('subquery')
                	.setNodeType('subquery')
                	.setRight(soqlSubQuery.head)
                	.build(),
                query
            );
        } else {
            selectExpr = parseFieldListWithAliases(query);
            query = selectExpr.subquery;
        }
        
        query = skipWhitespace(query);
        String nextChar = lookahead(query, 1);
        if(nextChar == ',') {
            query = consume(query, ',');
            Intermediary restOfExpr = parseSelectExpr(query);
            Node curr = selectExpr.head;
            while(curr.left != null) {
                curr = curr.left;
            }
            curr.left = restOfExpr.head;
            query = restOfExpr.subquery;
            selectExpr.subquery = query;
        }
        return selectExpr;
    }

    /** 
     * @description : Parses a list of fields, with optional aliases
     * @param query `String`
     * @return : `Intermediary`
    */
    @SuppressWarnings('PMD.NcssMethodCount, PMD.CognitiveComplexity, PMD.CyclomaticComplexity')
    private Intermediary parseFieldListWithAliases(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;
        if(isTypeOf(query)) {
            nextItem = parseTypeOf(query);
            query = nextItem.subquery;
        } else if(isAggregateFunc(query)) {
            nextItem = new AggregateFuncParser().parse(query);
            query = nextItem.subquery;
        } else {
            nextItem = this.fieldParser.parse(query);
            query = skipWhitespace(nextItem.subquery);
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(skipWhitespace(query.subString(1)), 1);
        Boolean isAggrFuncNext = isAggregateFunc(skipWhitespace(query.subString(1)));
        
        if(nextChar == ',' && nextCharAfterThat != '(' && !isAggrFuncNext) {
            query = query.subString(1);
            Intermediary restOfList = parseFieldListWithAliases(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }

        Intermediary alias = null;
        query = skipWhitespace(nextItem.subquery);
        if(lookahead(query, 5) != 'from ' && lookahead(query, 1) != ',') {
            // NOTE: alias might still be null after parsing, that's ok
            alias = new AliasParser().parse(query);
        }
        
        if(alias != null) {
            nextItem.head.right = alias.head;
            query = alias.subquery;
            nextItem.subquery = query;
        }

        query = skipWhitespace(nextItem.subquery);
        nextChar = lookahead(query, 1);
        nextCharAfterThat = lookahead(skipWhitespace(query.subString(1)), 1);
        isAggrFuncNext = isAggregateFunc(skipWhitespace(query.subString(1)));
        
        if(nextChar == ',' && nextCharAfterThat != '(' && !isAggrFuncNext) {
            query = query.subString(1);
            Intermediary restOfList = parseFieldListWithAliases(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }


        return nextItem;        
    }

    private Boolean isTypeOf(String query) {
        return query.length() >= 6 && lookahead(query, 6) == 'typeof';
    }

    private Boolean isElse(String query) {
        return query.length() >= 4 && lookahead(query, 4) == 'else';
    }

    private Boolean isWhen(String query) {
        return query.length() >= 4 && lookahead(query, 4) == 'when';
    }
    
    private Intermediary parseElse(String query) {
        query = skipWhitespace(query);
        if(query.length() == 0 || !isElse(query)) {
            return null;
        }
        query = consume(query, 'else');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        Intermediary fieldList = new FieldListParser().parse(query);
        return new Intermediary(
        	new NodeBuilder()
            	.setId('else')
            	.setNodeType('else')
            	.setRight(fieldList.head)
            	.build(),
            fieldList.subquery
        );
    }

    private Intermediary parseWhenList(String query) {
        query = skipWhitespace(query);
        if(!isWhen(query)) {
            return null;
        }

        Intermediary whenList;
        while(isWhen(query)) {
            Intermediary whenExpr = parseWhen(query);
            query = whenExpr.subquery;
            query = skipWhitespace(query);
            if(whenList == null) {
                whenList = whenExpr;
            } else {
                Node curr = whenList.head;
                while(curr.right != null) {
                    curr = curr.right;
                }
                curr.right = whenExpr.head;
            }
        }

        if(isElse(query)) {
            Intermediary elseExpr = parseElse(query);
            query = elseExpr.subquery;
            Node curr = whenList.head;
            while(curr.right != null) {
                curr = curr.right;
            }
            curr.right = elseExpr.head;
        }

        whenList.subquery = query;
        return whenList;
    }

    private Intermediary parseWhen(String query) {
        query = skipWhitespace(query);
        if(query.length() < 4 || lookahead(query, 4) != 'when') {
            return null;
        }

        query = consume(query, 'when');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        Intermediary obj = new SObjectParser().parse(query);
        query = obj.subquery;
        query = consume(query, ' ');
        query = skipWhitespace(query);

        query = consume(query, 'then');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        Intermediary thenExpr = new FieldListParser().parse(query);
        query = thenExpr.subquery;
        return new Intermediary(
        	new NodeBuilder()
            	.setId('when')
            	.setNodeType('when')
            	.setLeft(obj.head)
            	.setRight(thenExpr.head)
            	.build(),
            query
        );
    }

    private Intermediary parseTypeOf(String query) {
        query = skipWhitespace(query);
        if(query.length() < 6 || lookahead(query, 6) != 'typeof') {
            return null;
        }

        query = consume(query, 'typeof');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        Map<String, String> dataMap = getFieldName(query);
        String fieldName = dataMap.get('fieldName');
        query = dataMap.get('subquery');
        query = consume(query, ' ');
        query = skipWhitespace(query);

        Intermediary whenExpr = parseWhenList(query);
        query = whenExpr.subquery;
        query = skipWhitespace(query);
        query = consume(query, 'end');
        query = consume(query, ' ');

        return new Intermediary(
        	new NodeBuilder()
            	.setId(fieldName)
            	.setNodeType('typeof')
            	.setRight(whenExpr.head)
            	.build(),
            query
        );
    }
}