public abstract class SubParser {
    public abstract Intermediary parse(String query);

    /* private helper methods */

    protected String consume(String query, String token) {
        return ParserUtils.consume(query, token);
    }

    protected String lookahead(String query, Integer numChars) {
        return ParserUtils.lookahead(query, numChars);
    }

    protected String lookahead(String query, Integer numChars, Boolean isCaseSensitive) {
        return ParserUtils.lookahead(query, numChars, isCaseSensitive);
    }

    protected void applyCasing(Node head) {
        ParserUtils.applyCasing(head);
    }

    protected String skipWhitespace(String query) {
        return ParserUtils.skipWhitespace(query);
    }

    protected Boolean isSubField(String query) {
        Boolean isLongEnough = (query.length() >= 3);
        Boolean isValidChar = isLongEnough && ParserUtils.validCharForFieldOrObject(query.subString(0, 1));
        Boolean isDot = isValidChar && query.subString(1, 2) == '.';
        Boolean isSubField = isDot && ParserUtils.validCharForFieldOrObject(query.subString(2, 3));
        return isSubField;
    }

    protected Boolean isNextTokenFieldOrObject(String query) {
        return ParserUtils.validCharForFieldOrObject(lookahead(query, 1));
    }

    protected Map<String, String> getFieldName(String query) {
        query = skipWhitespace(query);
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

    protected Boolean isAggregateFunc(String query) {
        query = skipWhitespace(query);
        Boolean isLongEnough = (query.length() >= 3);
        Boolean isSum = isLongEnough && lookahead(query, 3) == 'sum';
        Boolean isAvg = isLongEnough && lookahead(query, 3) == 'avg';
        Boolean isMin = isLongEnough && lookahead(query, 3) == 'min';
        Boolean isMax = isLongEnough && lookahead(query, 3) == 'max';
        Boolean isCount = isLongEnough && lookahead(query, 5) == 'count';
        Boolean isCountDistinct = isLongEnough && lookahead(query, 14) == 'count_distinct';
        return isSum || isAvg || isMin || isMax || isCount || isCountDistinct;
    }
}