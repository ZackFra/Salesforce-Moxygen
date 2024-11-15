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
  * @description This class is responsible for parsing values in the query string 
  * @author Zackary Frazier
  * @since 4/12/2024
  */
public inherited sharing class ValueParser extends SubParser {

    /**
     * @description Parses the value in the query string
     * @param query `String`
     * @return  `Intermediary`
     * @exception ParsingException
     */
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(isNext(query, Token.SINGLE_QUOTE)) {
            Intermediary baseValue;
            query = query.subString(1);
            baseValue = parseString(query);
            query = baseValue.subquery;
            if(!isNext(query, Token.SINGLE_QUOTE)) {
                throw new ParsingException(baseValue.subquery, Token.SINGLE_QUOTE);
            }
            query = consume(query, Token.SINGLE_QUOTE);
            baseValue.subquery = query;
            return baseValue;
        } else if(isNext(query, Token.XTRUE) || isNext(query, Token.XFALSE)) {
        	return parseBoolean(query);
        } else if(isNext(query, Token.COLON)) {
            query = consume(query, Token.COLON);
            return parseBindVariable(query);
        } else if(isNext(query, Token.XNULL)) {
            return parseNull(query);
        } else if(isNext(query, Token.TODAY_LITERAL)) {
            return parseToday(query);
        } else {
        	return parseNum(query);
        }
    }

    private Intermediary parseString(String query) {
        query = skipWhitespace(query);
        String strValue = '';
        while(query.length() != 0 && !isNext(query, Token.SINGLE_QUOTE)) {
            strValue += lookahead(query, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(strValue)
            	.setNodeType(NodeType.XSTRING)
            	.build(),
            query
        );
    }

    private Intermediary parseBoolean(String query) {
        query = skipWhitespace(query);

        Boolean isTrue = (isNext(query, Token.XTRUE));
        Boolean isFalse = (isNext(query, Token.XFALSE));
        
        if(!isTrue && !isFalse) {
        	throw new ParsingException(query, NodeType.XBOOLEAN);
        }
        
        String boolVal;
        if(isTrue) {
            boolVal = Token.XTRUE;
        } else { 
            boolVal = Token.XFALSE;
        }
        
        return new Intermediary(
            new NodeBuilder()
            .setId(boolVal)
            .setNodeType(NodeType.XBOOLEAN)
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
                .setNodeType(NodeType.XBIND_VARIABLE)
                .build(),
            query
        );
    }

    private Intermediary parseNum(String query) {
        query = skipWhitespace(query);
        String numericValue = '';
        
        while(query.length() != 0 && (query.subString(0, 1).isNumeric() || (query.subString(0, 1) == Token.DOT) )) {
            if(query.subString(0, 1) == Token.DOT && !query.subString(1, 2).isNumeric()) {
                throw new ParsingException(query, 'floating point value');
            }
            numericValue += query.subString(0, 1);
            query = query.subString(1);
        }
        if(!numericValue.isNumeric()) {
            throw new ParsingException(query, NodeType.XNUMBER);
        }
        
        return new Intermediary(
        	new NodeBuilder()
            	.setId(numericValue)
            	.setNodeType(NodeType.XNUMBER)
            	.build(),
            query
        );
    }

    private Intermediary parseNull(String query) {
        query = consume(query, Token.XNULL);
        return new Intermediary(
        	new NodeBuilder()
            	.setId(Token.XNULL)
            	.setNodeType(NodeType.XNULL)
            	.build(),
            query
        );
    }

    private Intermediary parseToday(String query) {
        query = consume(query, Token.TODAY_LITERAL);
        return new Intermediary(
        	new NodeBuilder()
            	.setId(Token.TODAY_LITERAL)
            	.setNodeType(NodeType.XSTRING)
            	.build(),
            query
        );
    }
}