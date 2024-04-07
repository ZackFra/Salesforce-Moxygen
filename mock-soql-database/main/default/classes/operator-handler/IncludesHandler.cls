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
 * @description Handles the includes operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class IncludesHandler implements IOperatorHandler {
    /**
     * @description Handles the includes operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     * @exception QueryException
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        List<String> values = new List<String>();
        try {
            List<Object> objList = (List<Object>) fieldValue;
            for(Object obj : objList) {
                values.add(
                    ((String) obj).toLowerCase() + ';'
                );
            }
        } catch(Exception ex) {
            throw new QueryException('Includes expects a list of strings');
        }
        String fieldString = ((String) sObjectFieldValue).toLowerCase();
        for(String value : values) {
            if(fieldString.contains(value)) {
                return true;
            }
        }
        return false;
    }
}