/**
 * @description The lexer breaks down a SOQL query into an AST, to be fed into the parser (MockDatabase)
 */
@SuppressWarnings('PMD.ExcessiveClassLength, PMD.CognitiveComplexity, PMD.CyclomaticComplexity, PMD.StdCyclomaticComplexity')
public with sharing class Lexer {

    /**
     * @description : Parses a trimmed SOQL query into an AST
     * @param query : String, the query to parse
     * @return : Node, the head of the AST
     */
    public Node parse(String query) {
        query = query.trim();
        Intermediary fullQuery = parseQuery(query);
        return fullQuery.head;
    }

    /**
     * Helper classes for the lexer, meant to be used internally
     */

    /**
     * Private methods for the lexer, meant to be used internally
     */
    
    /**
     * @description : Consumes the first token in the query if it matches the token
     * @param query : String, the query to consume
     * @param token : String, the token to consume
     * @return : String, the query with the token consumed
     * @throws ParsingException : if the token is not the first token in the query
     */
    private String consume(String query, String token) {
        if(query.length() < token.length() || query.subString(0, token.length()).toLowerCase() != token) {
            throw new ParsingException(query, token);
        }
        return query.subString(token.length());
    }

    /** 
     * @description : Look ahead at the next numChars characters in the query
     * @param query : String, the query to look ahead in
     * @param numChars : Integer, the number of characters to look ahead
     * @return : String, the next numChars characters in the query
     */
    private String lookahead(String query, Integer numChars) {
        if(query.length() < numChars) { 
            return query.toLowerCase();
        }
        return query.subString(0, numChars).toLowerCase();
    }

    private String lookahead(String query, Integer numChars, Boolean isCaseSensitive) {
        if(!isCaseSensitive) {
            return lookahead(query, numChars);
        }

        if(query.length() < numChars) { 
            return query;
        }
        return query.subString(0, numChars);
    }
    
    /**
     * @description : Class to hold the head of a parsed query and the remaining subquery
     */
    private class Intermediary {
        protected Node head;
        protected String subquery;

        /**
         * @description : Constructor for an Intermediary
         * @param head : Node, the head of the parsed query
         * @param subquery : String, the remaining subquery
         */
        public Intermediary(Node head, String subquery) {
            this.head = head;
            this.subquery = subquery;
        }
    }
    
    /** 
     * @description Custom error thrown when a query cannot be parsed
     */
    private class ParsingException extends Exception {

        /**
         * @description Constructor for a ParsingException
         * @param message `String` the message to display
         * @param expected : `String` the expected token
         */
        public ParsingException(String message, String expected) {
            if(expected == null) {
                this.setMessage('Unkown parsing exception, "' + message + '" could not be parsed.');
            } else {
                this.setMessage('Parsing exception, expected "' + expected + '", instead saw "' + message + '".');
            }
        }
    }

    private void applyCasing(Node head) {
        if(head == null) {
            return;
        }

        if(head.nodeType != 'alias') {
            head.id = head.id.toLowerCase();
        }

        applyCasing(head.left);
        applyCasing(head.right);
    }
    
    @SuppressWarnings('PMD.NcssMethodCount')
    private Intermediary parseQuery(String query) {
        
        Intermediary selectIntermediary = parseSelect(query);
        query = selectIntermediary.subquery;

        Intermediary fromIntermediary = parseFrom(query);
        query = fromIntermediary.subquery;
        
        Intermediary nextLink = selectIntermediary;

        nextLink.head.right = fromIntermediary.head;
        nextLink = fromIntermediary;

        Intermediary scopeIntermediary = parseScope(query);
        if(scopeIntermediary != null) {
            query = scopeIntermediary.subquery;
            nextLink.head.right = scopeIntermediary.head;
            nextLink = scopeIntermediary;
        }
        
        Intermediary whereIntermediary = parseWhere(fromIntermediary.subquery);
        if(whereIntermediary != null) {
            query = whereIntermediary.subquery;
            nextLink.head.right = whereIntermediary.head;
            nextLink = whereIntermediary;
        }

        // throws exception if WITH [DATA CATEGORY] is added to the query
        parseWithDataCategory(query);
        
        Intermediary groupByIntermediary = parseGroupBy(query);
        if(groupByIntermediary != null) {
            query = groupByIntermediary.subquery;
            nextLink.head.right = groupByIntermediary.head;
            nextLink = groupByIntermediary;
            
            Intermediary havingIntermediary = parseHaving(query);
            if(havingIntermediary != null) {
                query = havingIntermediary.subquery;
                nextLink.head.right = havingIntermediary.head;
                nextLink = havingIntermediary;
            }
        }
        
        Intermediary orderByIntermediary = parseOrderBy(query);
        if(orderByIntermediary != null) {
            query = orderByIntermediary.subquery;
            nextLink.head.right = orderByIntermediary.head;
            nextLink = orderByIntermediary;
        }
        
        Intermediary limitIntermediary = parseLimit(query);
        if(limitIntermediary != null) {
            query = limitIntermediary.subquery;
            nextLink.head.right = limitIntermediary.head;
            nextLink = limitIntermediary;
        }

        Intermediary offsetIntermediary = parseOffset(query);
        if(offsetIntermediary != null) {
            query = offsetIntermediary.subquery;
            nextLink.head.right = offsetIntermediary.head;
            nextLink = offsetIntermediary;
        }

        Intermediary forViewOrReferenceIntermediary = parseForViewOrReference(query);
        if(forViewOrReferenceIntermediary != null) {
            query = forViewOrReferenceIntermediary.subquery;
            nextLink.head.right = forViewOrReferenceIntermediary.head;
            nextLink = forViewOrReferenceIntermediary;
        }

        // will throw an exception if UPDATE TRACKING or UPDATE VIEWSTAT is added to the query
        parseUpdateTrackingOrViewStat(query);
        
        Intermediary forUpdateIntermediary = parseForUpdate(query);
        if(forUpdateIntermediary != null) {
            query = forUpdateIntermediary.subquery;
            nextLink.head.right = forUpdateIntermediary.head;
            nextLink = forUpdateIntermediary;
        }
        
        // head node, so to speak
        selectIntermediary.subquery = nextLink.subquery;
		if(nextLink.subquery != '' && lookahead(nextLink.subquery, 1) != ')') {
            throw new ParsingException(nextLink.subquery, null);
        }
        // just making sure everything is lowercase
        applyCasing(selectIntermediary.head);
        
        return selectIntermediary;
    }

    private Intermediary parseUpdateTrackingOrViewStat(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 6) != 'update') {
            return null;
        }
        
        query = consume(query, 'update');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);

        if(lookahead(query, 8) != 'tracking' && lookahead(query, 4) != 'view') {
            return null;
        }

        String updateType = 'tracking';
        if(lookahead(query, 8) == 'viewstat') {
            updateType = 'viewstat';
        }

        query = consume(query, updateType);

        // so it is either UPDATE VIEW or UPDATE TRACKING
        throw new QueryException('UPDATE ' + updateType.toUpperCase() + ' is not supported by the mock SOQL parser');
    }

    private Intermediary parseWithDataCategory(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(lookahead(query, 4) == 'with') {
            throw new QueryException('WITH [DATA CATEGORY] is not supported by the mock SOQL parser');
        }
        return null;
    }

    private Intermediary parseForViewOrReference(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 3) != 'for') {
            return null;
        }
        query = consume(query, 'for');
        query = ParserUtils.skipWhitespace(query);

        // could be FOR UPDATE, if its not view or reference, return null
        if(lookahead(query, 4) != 'view' && lookahead(query, 9) != 'reference') {
            return null;
        }

        String forType = 'view';
        if(lookahead(query, 9) == 'reference') {
            forType = 'reference';
        }

        query = consume(query, forType);
        return new Intermediary(
        	new NodeBuilder()
            	.setId('for ' + forType)
            	.setNodeType('for ' + forType)
            	.build(),
            query
        );
    }

    private Intermediary parseOffset(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 6) != 'offset') {
            return null;
        }

        query = consume(query, 'offset');
        query = ParserUtils.skipWhitespace(query);
        Intermediary offsetValue;
        if(lookahead(query, 1) == ':') {
            query = consume(query, ':');
            offsetValue = parseBindVariable(query);
        } else {
            offsetValue = parseNum(query);
        }
        query = offsetValue.subquery;

        return new Intermediary(
        	new NodeBuilder()
            	.setId('offset')
            	.setNodeType('offset')
            	.setLeft(offsetValue.head)
            	.build(),
            query
        );
    }
    
    private Intermediary parseSelect(String query) {
        
        query = consume(query, 'select');
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

    private Boolean isTypeOf(String query) {
        return query.length() >= 6 && lookahead(query, 6) == 'typeof';
    }
    
    private Intermediary parseSelectExpr(String query) {
        query = ParserUtils.skipWhitespace(query);
        Intermediary selectExpr;

        if(isTypeOf(query)) {
            selectExpr = parseTypeOf(query);
            query = selectExpr.subquery;
        } else if(isAggregateFunction(query)) {
            selectExpr = parseAggregateFunc(query);
            query = selectExpr.subquery;
        } else if(lookahead(query, 1) == '(') {
            query = consume(query, '(');
            Intermediary soqlSubQuery = parseQuery(query);
            query = soqlSubQuery.subquery;
            query = ParserUtils.skipWhitespace(query);
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
        
        query = ParserUtils.skipWhitespace(query);
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
        query = ParserUtils.skipWhitespace(query);
        Intermediary nextItem;
        if(isTypeOf(query)) {
            nextItem = parseTypeOf(query);
            query = nextItem.subquery;
        } else if(isAggregateFunction(query)) {
            nextItem = parseAggregateFunc(query);
            query = nextItem.subquery;
        } else {
            nextItem = parseField(query);
            query = ParserUtils.skipWhitespace(nextItem.subquery);
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(ParserUtils.skipWhitespace(query.subString(1)), 1);
        Boolean isAggrFuncNext = isAggregateFunction(ParserUtils.skipWhitespace(query.subString(1)));
        
        if(nextChar == ',' && nextCharAfterThat != '(' && !isAggrFuncNext) {
            query = query.subString(1);
            Intermediary restOfList = parseFieldListWithAliases(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }

        Intermediary alias = null;
        query = ParserUtils.skipWhitespace(nextItem.subquery);
        if(lookahead(query, 5) != 'from ' && lookahead(query, 1) != ',') {
            // NOTE: alias might still be null after parsing, that's ok
            alias = parseAlias(query);
        }
        
        if(alias != null) {
            nextItem.head.right = alias.head;
            query = alias.subquery;
            nextItem.subquery = query;
        }

        query = ParserUtils.skipWhitespace(nextItem.subquery);
        nextChar = lookahead(query, 1);
        nextCharAfterThat = lookahead(ParserUtils.skipWhitespace(query.subString(1)), 1);
        isAggrFuncNext = isAggregateFunction(ParserUtils.skipWhitespace(query.subString(1)));
        
        if(nextChar == ',' && nextCharAfterThat != '(' && !isAggrFuncNext) {
            query = query.subString(1);
            Intermediary restOfList = parseFieldListWithAliases(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }


        return nextItem;        
    }

    private Intermediary parseDirection(String query) {
        query = ParserUtils.skipWhitespace(query);
        String dir = '';
        if(lookahead(query, 3) == 'asc') {
            dir = 'asc';
            query = consume(query, 'asc');
        } else if(lookahead(query, 4) == 'desc') {
            dir = 'desc';
            query = consume(query, 'desc');
        } else {
            // may be the case that there's no direction specified
            return null;
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(dir)
            	.setNodeType('direction')
            	.build(),
            query
        );
    }

    private Intermediary parseNulls(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(lookahead(query, 5) != 'nulls') {
            return null;
        }
        query = consume(query, 'nulls');
        query = ParserUtils.skipWhitespace(query);
        String dir;
        if(lookahead(query, 5) == 'first') {
            dir = 'nulls first';
            query = consume(query, 'first');
        } else if(lookahead(query, 4) == 'last') {
            dir = 'nulls last';
            query = consume(query, 'last');
        } else {
            throw new ParsingException(query, 'first or last');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(dir)
                .setNodeType('nulls direction')
                .build(),
            query
        );
    }

    private Intermediary parseOrderByFieldList(String query) {
        query = ParserUtils.skipWhitespace(query);
        Intermediary nextItem;

        if(isAggregateFunction(query)) {
            nextItem = parseAggregateFunc(query);
        } else {
            nextItem = parseField(query);
        }
        query = ParserUtils.skipWhitespace(nextItem.subquery);
        
        Intermediary dir = parseDirection(query);
        if(dir != null) {
            nextItem.head.right = dir.head;
            nextItem.subquery = dir.subquery;
            query = ParserUtils.skipWhitespace(dir.subquery);
        }
        
        Intermediary nullsDir = parseNulls(query);
        if(nullsDir != null) {
            if(dir != null) {
                dir.head.right = nullsDir.head;
            } else {
                nextItem.head.right = nullsDir.head;
            }
            nextItem.subquery = nullsDir.subquery;
            query = nullsDir.subquery;
        }
        query = ParserUtils.skipWhitespace(nextItem.subquery);

        if(query.length() == 0) {
            return nextItem;
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(ParserUtils.skipWhitespace(query.subString(1)), 1);
        
        if(nextChar == ',' && nextCharAfterThat != '(') {
            query = query.subString(1);
            Intermediary restOfList = parseOrderByFieldList(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;       
    }

    private Intermediary parseGroupByRollupFieldList(String query) {
        return parseGroupByRollupFieldList(query, 0);
    }

    private Intermediary parseGroupByRollupFieldList(String query, Integer depth) {
        if(depth == 3) {
            throw new ParsingException(query, 'Group By with ROLLUP or CUBE must contain 3 fields or less');
        }

        query = ParserUtils.skipWhitespace(query);
        Intermediary nextItem = parseField(query);
        query = ParserUtils.skipWhitespace(nextItem.subquery);
        
        if(query.length() == 0) {
            return nextItem;
        }
        
        String nextChar = lookahead(query, 1);
        
        if(nextChar == ',') {
            query = consume(query, ',');
            Intermediary restOfList = parseGroupByRollupFieldList(query, depth + 1);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;
    }
    
    private Intermediary parseFieldList(String query) {
        query = ParserUtils.skipWhitespace(query);
        Intermediary nextItem;
        if(isAggregateFunction(query)) {
            nextItem = parseAggregateFunc(query);
            query = nextItem.subquery;
        } else {
            nextItem = parseField(query);
            query = ParserUtils.skipWhitespace(nextItem.subquery);
            if(query.length() == 0) {
                return nextItem;
            }
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(ParserUtils.skipWhitespace(query.subString(1)), 1);
        
        if(nextChar == ',' && nextCharAfterThat != '(') {
            query = query.subString(1);
            Intermediary restOfList = parseFieldList(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;
    }

    private Boolean isAggregateFunction(String query) {
        query = ParserUtils.skipWhitespace(query);
        Boolean isLongEnough = (query.length() >= 3);
        Boolean isSum = isLongEnough && lookahead(query, 3) == 'sum';
        Boolean isAvg = isLongEnough && lookahead(query, 3) == 'avg';
        Boolean isMin = isLongEnough && lookahead(query, 3) == 'min';
        Boolean isMax = isLongEnough && lookahead(query, 3) == 'max';
        Boolean isCount = isLongEnough && lookahead(query, 5) == 'count';
        Boolean isCountDistinct = isLongEnough && lookahead(query, 14) == 'count_distinct';
        return isSum || isAvg || isMin || isMax || isCount || isCountDistinct;
    }

    // @description : Returns true if the next three tokens in the query denote a subfield
    private Boolean isSubField(String query) {
        Boolean isLongEnough = (query.length() >= 3);
        Boolean isValidChar = isLongEnough && ParserUtils.validCharForFieldOrObject(query.subString(0, 1));
        Boolean isDot = isValidChar && query.subString(1, 2) == '.';
        Boolean isSubField = isDot && ParserUtils.validCharForFieldOrObject(query.subString(2, 3));
        return isSubField;
    }

    // @description returns true if the next token in the query is a field or object
    private Boolean isNextTokenFieldOrObject(String query) {
        return ParserUtils.validCharForFieldOrObject(lookahead(query, 1));
    }

    private Map<String, String> getFieldName(String query) {
        query = ParserUtils.skipWhitespace(query);
        String fieldName = '';
        while(query.length() != 0 && 
              isNextTokenFieldOrObject(query) ||
              isSubField(query)) {

            if(isSubField(query)) {
                fieldName += lookahead(query, 3);
                query = query.subString(3);
            } else {
                fieldName += lookahead(query, 1);
                query = query.subString(1);
            }
        }
        
        if(fieldName.isNumeric()) {
            throw new ParsingException(fieldName, 'field name');
        }

        Map<String, String> dataMap = new Map<String, String> {
            'fieldName' => fieldName,
            'subquery' => query
        };
        return dataMap;
    }
    
    private Intermediary parseField(String query) {
        query = ParserUtils.skipWhitespace(query);
        Map<String, String> dataMap = getFieldName(query);
        String fieldName = dataMap.get('fieldName');
        query = dataMap.get('subquery');
        
        Node head = new NodeBuilder()
            .setId(fieldName)
            .setNodeType('field')
            .build();

        return new Intermediary(head, query);
    }
    
    private Intermediary parseFrom(String query) {
        query = ParserUtils.skipWhitespace(query);
        query = consume(query, 'from');
        
        
        Intermediary leftIntermediary = parseObj(query);
		
        return new Intermediary(
        	new NodeBuilder()
            	.setId('from')
            	.setNodeType('from')
            	.setLeft(leftIntermediary.head)
            	.build(),
            leftIntermediary.subquery
        );
    }
    
    private Intermediary parseObj(String query) {
        query = ParserUtils.skipWhitespace(query);
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
    
    private Intermediary parseWhere(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 5) != 'where') {
            return null;
        }
        query = consume(query, 'where');
        
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

    private Intermediary parseNot(String query) {
        query = consume(query, 'not');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);

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

    private Intermediary parseConditionalOperationExpr(String query) {
        if(lookahead(query, 3) == 'not') {
            return parseNot(query);
        }
        Intermediary fieldIntermediary = parseField(query);
        query = fieldIntermediary.subquery;
        query = ParserUtils.skipWhitespace(query);

        Intermediary operatorIntermediary = parseOperator(query);
        query = operatorIntermediary.subquery;
        query = ParserUtils.skipWhitespace(query);

        Boolean isIn = operatorIntermediary.head.id == 'in';
        Boolean isNotIn = operatorIntermediary.head.id == 'not in';
        Boolean isIncludes = operatorIntermediary.head.id == 'includes';
        Boolean isExcludes = operatorIntermediary.head.id == 'excludes';
        
        Boolean isExpectingList = (isIn || isNotIn || isIncludes || isExcludes);
        if(isExpectingList && lookahead(query, 1) == '(') {
            query = consume(query, '(');
            Intermediary listOrQuery;
            if(lookahead(query, 6) == 'select') {
                Intermediary soqlSubQuery = parseQuery(query);
                listOrQuery = new Intermediary(
                    new NodeBuilder()
                        .setId('subquery')
                        .setNodeType('subquery')
                        .setRight(soqlSubQuery.head)
                        .build(),
                    soqlSubQuery.subquery
                );
            } else {
                listOrQuery = parseValueList(query);
            }
            query = listOrQuery.subquery;
            query = ParserUtils.skipWhitespace(query);

            query = consume(query, ')');

            operatorIntermediary.head.right = listOrQuery.head;
        } else {
            Intermediary valueIntermediary = parseValue(query);
            query = valueIntermediary.subquery;
            operatorIntermediary.head.right = valueIntermediary.head;
        }
        operatorIntermediary.subquery = query;
        operatorIntermediary.head.left = fieldIntermediary.head;

        return operatorIntermediary;
    }

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

    private Intermediary parseHavingNot(String query) {
        query = consume(query, 'not');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);

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

    private Intermediary parseHavingConditionalOperationExpr(String query) {
        if(lookahead(query, 3) == 'not') {
            return parseHavingNot(query);
        }
        Intermediary nextItem;
        if(isAggregateFunction(query)) {
            nextItem = parseAggregateFunc(query);
        } else {
            nextItem = parseField(query);
        }
        query = nextItem.subquery;
        query = ParserUtils.skipWhitespace(query);

        Intermediary operatorIntermediary = parseOperator(query);
        query = operatorIntermediary.subquery;
        query = ParserUtils.skipWhitespace(query);
        Boolean isIn = operatorIntermediary.head.id == 'in';
        Boolean isNotIn = operatorIntermediary.head.id == 'not in';
        if((isIn || isNotIn) && lookahead(query, 1) == '(') {
            query = consume(query, '(');
            Intermediary listOrQuery;
            if(lookahead(query, 6) == 'select') {
                throw new ParsingException(query, 'subquery');
            } else {
                listOrQuery = parseValueList(query);
            }
            query = listOrQuery.subquery;
            query = ParserUtils.skipWhitespace(query);

            query = consume(query, ')');

            operatorIntermediary.head.right = listOrQuery.head;
        } else {
            Intermediary valueIntermediary = parseValue(query);
            query = valueIntermediary.subquery;
            operatorIntermediary.head.right = valueIntermediary.head;
        }
        operatorIntermediary.subquery = query;
        operatorIntermediary.head.left = nextItem.head;

        return operatorIntermediary;
    }

    private Intermediary parseHavingConditionalExpr(String query) {
        query = ParserUtils.skipWhitespace(query);

        Intermediary leftIntermediary;

        // work out the left intermediary first, it's either a sub-expression or a field being compared to a value
        if(lookahead(query, 1) == '(') {
            leftIntermediary = parseHavingConditionalSubExpr(query);
        } else {
            leftIntermediary = parseHavingConditionalOperationExpr(query);
        }
        query = leftIntermediary.subquery;
        query = ParserUtils.skipWhitespace(query);

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

    private Intermediary parseConditionalExpr(String query) {
        query = ParserUtils.skipWhitespace(query);

        Intermediary leftIntermediary;

        // work out the left intermediary first, it's either a sub-expression or a field being compared to a value
        if(lookahead(query, 1) == '(') {
            leftIntermediary = parseConditionalSubExpr(query);
        } else {
            leftIntermediary = parseConditionalOperationExpr(query);
        }
        query = leftIntermediary.subquery;
        query = ParserUtils.skipWhitespace(query);

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

    private Intermediary parseValueList(String query) {
        query = ParserUtils.skipWhitespace(query);
        
        Intermediary value = parseValue(query);
        query = value.subquery;
        query = ParserUtils.skipWhitespace(query);
        
        if(lookahead(query, 1) == ',') {
            query = consume(query, ',');
            Intermediary restOfList = parseValueList(query);
            value.head.left = restOfList.head;
            value.subquery = restOfList.subquery;
        }
        query = value.subquery;
        return new Intermediary(
            new NodeBuilder()
            .setId('value list')
            .setNodeType('value list')
            .setLeft(value.head)
            .build(),
            query
        );
    }
    
    private Intermediary parseOperator(String query) {
        query = ParserUtils.skipWhitespace(query);
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
    
    private Intermediary parseValue(String query) {
        query = ParserUtils.skipWhitespace(query);
        Intermediary baseValue;
        if(lookahead(query, 1) == '\'') {
            query = query.subString(1);
            baseValue = parseString(query);
            query = baseValue.subquery;
            if(lookahead(query, 1) != '\'') {
                throw new ParsingException(baseValue.subquery, '\'');
            }
            query = consume(query, '\'');
            baseValue.subquery = query;
            return baseValue;
        } else if(lookahead(query, 4) == 'true' || lookahead(query, 5) == 'false') {
        	return parseBoolean(query);
        } else if(lookahead(query, 1) == ':') {
            query = consume(query, ':');
            return parseBindVariable(query);
        } else {
        	return parseNum(query);
        }
    }

    private Intermediary parseBindVariable(String query) {
        query = ParserUtils.skipWhitespace(query);
        String bindVarName = '';
        while(query.length() > 0 && isNextTokenFieldOrObject(query)) {
            bindVarName += query.subString(0, 1);
            query = query.subString(1);
        }

        if(bindVarName.isNumeric()) {
            throw new ParsingException(bindVarName, 'bind variable name');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(bindVarName)
                .setNodeType('bind variable')
                .build(),
            query
        );
    }
    
    private Intermediary parseNum(String query) {
        query = ParserUtils.skipWhitespace(query);
        String numericValue = '';
        
        while(query.length() != 0 && (query.subString(0, 1).isNumeric() || (query.subString(0, 1) == '.') )) {
            if(query.subString(0, 1) == '.' && !query.subString(1, 2).isNumeric()) {
                throw new ParsingException(query, 'floating point value');
            }
            numericValue += query.subString(0, 1);
            query = query.subString(1);
        }
        if(!numericValue.isNumeric()) {
            throw new ParsingException(query, 'number');
        }
        
        return new Intermediary(
        	new NodeBuilder()
            	.setId(numericValue)
            	.setNodeType('number')
            	.build(),
            query
        );
    }
    
    private Intermediary parseBoolean(String query) {
        query = ParserUtils.skipWhitespace(query);

        Boolean isTrue = (lookahead(query, 4) == 'true');
        Boolean isFalse = (lookahead(query, 5) == 'false');
        
        if(!isTrue && !isFalse) {
        	throw new ParsingException(query, 'boolean');
        }
        
        String boolVal;
        if(isTrue) {
            boolVal = 'true';
        } else { 
            boolVal = 'false';
        }
        
        return new Intermediary(
            new NodeBuilder()
            .setId(boolVal)
            .setNodeType('boolean')
            .build(),
            query.subString(boolVal.length())
        );
    }
    
    private Intermediary parseString(String query) {
        query = ParserUtils.skipWhitespace(query);
        String strValue = '';
        while(query.length() != 0 && lookahead(query, 1) != '\'') {
            strValue += lookahead(query, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(strValue)
            	.setNodeType('string')
            	.build(),
            query
        );
    }
    
    private Intermediary parseGroupBy(String query) {
        query = ParserUtils.skipWhitespace(query);
        
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 5) != 'group') { 
            return null;
        }
        
        query = consume(query, 'group');
        query = ParserUtils.skipWhitespace(query);
        query = consume(query, 'by');
        query = ParserUtils.skipWhitespace(query);

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
    
    private Intermediary parseOrderBy(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() < 5) {
            return null;
        }
        if(lookahead(query, 5) != 'order') {
            return null;
        }
        
        query = query.subString(5);
        query = ParserUtils.skipWhitespace(query);
        
        if(lookahead(query, 2) != 'by') {
            throw new ParsingException(query, 'BY');
        }

        query = query.subString(2);
        query = ParserUtils.skipWhitespace(query);

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
    
    private Intermediary parseLimit(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() < 5 || lookahead(query, 5) != 'limit') { 
            return null;
        }
        
        query = consume(query, 'limit');
        query = ParserUtils.skipWhitespace(query);
        Intermediary limitSize;
        if(lookahead(query, 1) == ':') {
            query = consume(query, ':');
            limitSize = parseBindVariable(query);
        } else {
            limitSize = parseNum(query);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId('limit')
            	.setNodeType('limit')
            	.setLeft(limitSize.head)
            	.build(),
            limitSize.subquery
        );
    }

    private Boolean isElse(String query) {
        return query.length() >= 4 && lookahead(query, 4) == 'else';
    }

    private Boolean isWhen(String query) {
        return query.length() >= 4 && lookahead(query, 4) == 'when';
    }
    
    private Intermediary parseElse(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() == 0 || !isElse(query)) {
            return null;
        }
        query = consume(query, 'else');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);
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
        query = ParserUtils.skipWhitespace(query);
        if(!isWhen(query)) {
            return null;
        }

        Intermediary whenList;
        while(isWhen(query)) {
            Intermediary whenExpr = parseWhen(query);
            query = whenExpr.subquery;
            query = ParserUtils.skipWhitespace(query);
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
        query = ParserUtils.skipWhitespace(query);
        if(query.length() < 4 || lookahead(query, 4) != 'when') {
            return null;
        }

        query = consume(query, 'when');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);
        Intermediary obj = parseObj(query);
        query = obj.subquery;
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);

        query = consume(query, 'then');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);
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
        query = ParserUtils.skipWhitespace(query);
        if(query.length() < 6 || lookahead(query, 6) != 'typeof') {
            return null;
        }

        query = consume(query, 'typeof');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);
        Map<String, String> dataMap = getFieldName(query);
        String fieldName = dataMap.get('fieldName');
        query = dataMap.get('subquery');
        query = consume(query, ' ');
        query = ParserUtils.skipWhitespace(query);

        Intermediary whenExpr = parseWhenList(query);
        query = whenExpr.subquery;
        query = ParserUtils.skipWhitespace(query);
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
    
    private Intermediary parseForUpdate(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() == 0 || query.length() < 3) { 
            return null;
        }
        if(lookahead(query, 3) != 'for') {
            return null;
        }
        
        query = query.subString(3);
        query = ParserUtils.skipWhitespace(query);
        query = consume(query, 'update');
        
        return new Intermediary(
        	new NodeBuilder()
            	.setId('for update')
            	.setNodeType('for update')
            	.build(),
            query
        );
    }
    
    private Intermediary parseHaving(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() < 6 || lookahead(query, 6) != 'having') {
            return null;
        }

        query = consume(query, 'having');
        query = ParserUtils.skipWhitespace(query);
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

    // @description : Parses an alias, which is a string of characters that is not a number
    private Intermediary parseAlias(String query) {

        query = ParserUtils.skipWhitespace(query);
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

    private Intermediary parseScopeName(String query) {
        query = ParserUtils.skipWhitespace(query);
        String scopeName = '';
        while(ParserUtils.validCharForFieldOrObject(lookahead(query, 1))) {
            scopeName += lookahead(query, 1);
            query = query.subString(1);
        }

        if(scopeName.isNumeric()) {
            throw new ParsingException(scopeName, 'scope name');
        }

        return new Intermediary(
            new NodeBuilder()
                .setId(scopeName)
                .setNodeType('scope')
                .build(),
            query
        );
    }

    private Intermediary parseScope(String query) {
        query = ParserUtils.skipWhitespace(query);
        if(query.length() < 5 || lookahead(query, 5) != 'using') {
            return null;
        }

        query = consume(query, 'using');
        query = ParserUtils.skipWhitespace(query);
        query = consume(query, 'scope');
        query = ParserUtils.skipWhitespace(query);
        Intermediary scope = parseScopeName(query);
        query = scope.subquery;
        return new Intermediary(
        	new NodeBuilder()
            	.setId('using scope')
            	.setNodeType('using scope')
            	.setLeft(scope.head)
            	.build(),
            query
        );
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
        query = ParserUtils.skipWhitespace(query);
        
        query = consume(query, '(');
        if(nb.id == 'count' && lookahead(query, 1) == ')') {
            query = consume(query, ')');
            return new Intermediary(
            	nb.build(),
                query
            );
        }

        query = ParserUtils.skipWhitespace(query);
        Intermediary field = parseField(query);
        
        query = field.subquery;
        query = consume(query, ')');

        Intermediary alias = null;
        query = ParserUtils.skipWhitespace(query);
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
}