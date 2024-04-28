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
  * @description This class is responsible for parsing a list of fields.
  * @author Zackary Frazier
  * @since 4/12/2024
  */
public inherited sharing class FieldListParser extends SubParser {

    /**
     * @description Parses a list of fields
     * @param query `String`
     * @return  `Intermediary`
     */

    @SuppressWarnings('PMD.CognitiveComplexity')
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        Intermediary nextItem;
        if(isAggregateFunc(query)) {
            nextItem = new AggregateFuncParser().parse(query);
            query = nextItem.subquery;
        } else {
            nextItem = new FieldParser().parse(query);
            query = skipWhitespace(nextItem.subquery);
            if(query.length() == 0) {
                return nextItem;
            }
        }
        
        String nextChar = lookahead(query, 1);
        String nextCharAfterThat = null;
        if(query.length() > 1) {
            nextCharAfterThat = lookahead(
                skipWhitespace(
                    query.subString(1)
                ), 
                1
            );
        }
        
        if(nextChar == ',' && nextCharAfterThat != '(') {
            query = query.subString(1);
            Intermediary restOfList = parse(query);
            nextItem.head.left = restOfList.head;
            nextItem.subquery = restOfList.subquery;
        }
        return nextItem;
    }
}