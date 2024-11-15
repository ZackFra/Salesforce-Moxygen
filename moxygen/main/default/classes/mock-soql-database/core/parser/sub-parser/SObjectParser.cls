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
  * @description Parses an SObject name in a query
  * @author Zackary Frazier
  * @since 4/12/2024
  */
public inherited sharing class SObjectParser extends SubParser {
    /**
     * @description Parses the object from the 'from' clause
     * @param query `String`
     * @return  `Intermediary`
     */
    public override Intermediary parse(String query) {
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