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
 * @description The options to be passed into an ILimitHandler
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public inherited sharing class LimitOptions {
    public Integer limitSize;
    public Types.SOQL type;
    public Object obj;

    /**
     * @description Setter for the type of query 
     * @param type `MockDatabase.Types.SOQL`
     * @return  `LimitOptions`
     */
    public LimitOptions setType(Types.SOQL type) {
        this.type = type;
        return this;
    }

    /**
     * @description Getter for the type of query
     * @return  `MockDatabase.Types.SOQL`
     */
    public Types.SOQL getType() {
        return this.type;
    }

    /**
     * @description Sets the object to be used in the query
     * @param obj `List<ProtoAggregate> | List<SObject> | Integer`
     * @return  `LimitOptions`
     */
    public LimitOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Getter for the object to be used in the query 
     * @return  `Object`
     */
    public Object getObj() {
        return this.obj;
    }

    /**
     * @description Setter for the limit size
     * @param limitSize `Integer`
     * @return  `LimitOptions`
     */
    public LimitOptions setLimitSize(Integer limitSize) {
        this.limitSize = limitSize;
        return this;
    }

    /**
     * @description Getter for the limit size 
     * @return  `Integer`
     */
    public Integer getLimitSize() {
        return this.limitSize;
    }
}