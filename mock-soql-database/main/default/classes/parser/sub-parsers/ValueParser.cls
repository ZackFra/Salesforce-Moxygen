public inherited sharing class ValueParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(lookahead(query, 1) == '\'') {
            Intermediary baseValue;
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
        } else if(lookahead(query, 4) == 'null') {
            return parseNull(query);
        } else {
        	return parseNum(query);
        }
    }

    private Intermediary parseString(String query) {
        query = skipWhitespace(query);
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

    private Intermediary parseBoolean(String query) {
        query = skipWhitespace(query);

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

    private Intermediary parseBindVariable(String query) {
        query = skipWhitespace(query);
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
        query = skipWhitespace(query);
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

    private Intermediary parseNull(String query) {
        query = consume(query, 'null');
        return new Intermediary(
        	new NodeBuilder()
            	.setId('null')
            	.setNodeType('null')
            	.build(),
            query
        );
    }
}