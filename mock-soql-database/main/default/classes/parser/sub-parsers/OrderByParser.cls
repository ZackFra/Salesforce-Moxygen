public inherited sharing class OrderByParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() < 5) {
            return null;
        }
        if(lookahead(query, 5) != 'order') {
            return null;
        }
        
        query = consume(query, 'order');
        query = consume(query, ' ');
        query = skipWhitespace(query);
        
        if(lookahead(query, 2) != 'by') {
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

    private Intermediary parseOrderByFieldList(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;

        if(isAggregateFunc(query)) {
            nextItem = new AggregateFuncParser().parse(query);
        } else {
            nextItem = new FieldParser().parse(query);
        }
        query = skipWhitespace(nextItem.subquery);
        
        Intermediary dir = parseDirection(query);
        if(dir != null) {
            nextItem.head.right = dir.head;
            nextItem.subquery = dir.subquery;
            query = skipWhitespace(dir.subquery);
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
        query = skipWhitespace(nextItem.subquery);

        if(query.length() == 0) {
            return nextItem;
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = lookahead(skipWhitespace(query.subString(1)), 1);
        
        if(nextChar == ',' && nextCharAfterThat != '(') {
            query = query.subString(1);
            Intermediary restOfList = parseOrderByFieldList(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;       
    }

    private Intermediary parseDirection(String query) {
        query = skipWhitespace(query);
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
        query = skipWhitespace(query);
        if(lookahead(query, 5) != 'nulls') {
            return null;
        }
        query = consume(query, 'nulls');
        query = skipWhitespace(query);
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
}