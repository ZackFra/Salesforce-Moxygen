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
 * @description This class is responsible for parsing the GROUP BY clause of a SOQL query
 * @author Zackary Frazier
 * @since 4/12/2024
 */
public inherited sharing class GroupByParser extends SubParser {
    /**
     * @description Parses the GROUP BY clause of a SOQL query
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 5) != 'group') { 
            return null;
        }
        
        query = consume(query, 'group');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        query = consume(query, 'by');
        query = consume(query, ' ');
        query = skipWhitespace(query);

        Intermediary fieldList;
        String nodeId = 'group by';
        if(lookahead(query, 6) == 'rollup') {
            throw new ParsingException('GROUP BY ROLLUP is not supported by the mock SOQL parser');
        } else if (lookahead(query, 4) == 'cube') {
            throw new ParsingException('GROUP BY CUBE is not supported by the mock SOQL parser');
        } else {
            fieldList = parseFieldList(query);
        }
        
        return new Intermediary(
        	new NodeBuilder()
            	.setId(nodeId)
            	.setNodeType('group by')
            	.setLeft(fieldList.head)
            	.build(),
            fieldList.subquery
        );
    }

    /**
     * @description Parses a list of fields in the GROUP BY clause
     * @param query `String`
     * @return  `Intermediary`
     */
    private Intermediary parseFieldList(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;
        if(isAggregateFunc(query)) {
            nextItem = parseAggregateFunc(query);
            query = nextItem.subquery;
        } else {
            nextItem = parseField(query);
            query = skipWhitespace(nextItem.subquery);
            if(query.length() == 0) {
                return nextItem;
            }
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(skipWhitespace(query.subString(1)), 1);
        
        if(nextChar == ',' && nextCharAfterThat != '(') {
            query = query.subString(1);
            Intermediary restOfList = parseFieldList(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;
    }

    @SuppressWarnings('PMD.NcssMethodCount')
    private Intermediary parseAggregateFunc(String query) {
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
        Intermediary field = parseField(query);
        
        query = field.subquery;
        query = consume(query, ')');

        Intermediary alias = null;
        query = skipWhitespace(query);
        if(lookahead(query, 5) != 'from ') {
            // NOTE: alias might still be null after parsing, that's ok
            alias = parseAlias(query);
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

    private Intermediary parseField(String query) {
        query = skipWhitespace(query);
        Map<String, String> dataMap = getFieldName(query);
        String fieldName = dataMap.get('fieldName');
        query = dataMap.get('subquery');
        
        Node head = new NodeBuilder()
            .setId(fieldName)
            .setNodeType('field')
            .build();

        return new Intermediary(head, query);
    }

    // @description : Parses an alias, which is a string of characters that is not a number
    private Intermediary parseAlias(String query) {

        query = skipWhitespace(query);
        // if the next character is not a letter, it's not an alias
        if(!lookahead(query, 1).isAlpha()) {
            return null;
        }

        String aliasName = '';
        while(query.length() > 0 && ParserUtils.validCharForFieldOrObject(lookahead(query, 1))) {
            aliasName += lookahead(query, 1, true);
            query = query.subString(1);
        }

        if(aliasName.isNumeric()) {
            throw new ParsingException(aliasName, 'alias name');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(aliasName)
                .setNodeType('alias')
                .build(),
            query
        );
    }
}