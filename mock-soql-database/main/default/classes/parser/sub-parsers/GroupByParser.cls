public inherited sharing class GroupByParser extends SubParser {
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
            throw new QueryException('GROUP BY ROLLUP is not supported by the mock SOQL parser');
        } else if (lookahead(query, 4) == 'cube') {
            throw new QueryException('GROUP BY CUBE is not supported by the mock SOQL parser');
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