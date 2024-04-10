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
            selectExpr = parseAggregateFunc(query);
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
    @SuppressWarnings('PMD.NcssMethodCount')
    private Intermediary parseFieldListWithAliases(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;
        if(isTypeOf(query)) {
            nextItem = parseTypeOf(query);
            query = nextItem.subquery;
        } else if(isAggregateFunc(query)) {
            nextItem = parseAggregateFunc(query);
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
            alias = parseAlias(query);
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
        Intermediary fieldList = parseFieldList(query);
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
        Intermediary obj = parseObj(query);
        query = obj.subquery;
        query = consume(query, ' ');
        query = skipWhitespace(query);

        query = consume(query, 'then');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        Intermediary thenExpr = parseFieldList(query);
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

    private Intermediary parseFieldList(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;
        if(isAggregateFunc(query)) {
            nextItem = parseAggregateFunc(query);
            query = nextItem.subquery;
        } else {
            nextItem = this.fieldParser.parse(query);
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
        Intermediary field = this.fieldParser.parse(query);
        
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

    private Intermediary parseObj(String query) {
        query = skipWhitespace(query);
        String objectName = '';
        while(query.length() != 0 && (ParserUtils.validCharForFieldOrObject(query.subString(0, 1)))) {
            objectName += query.subString(0, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(objectName)
            	.setNodeType('object')
            	.build(),
            query
        );
    }
}