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
 * @description Options class for OrderBy 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public inherited sharing class OrderByOptions {
    private Object obj;
    private TopLevelNodes topLevelNodes;
    private Types.SOQL type;

    /**
     * @description Getter for the type of query 
     * @return  `Types.SOQL`
     */
    public Types.SOQL getType() {
        return type;
    }

    /**
     * @description Setter for the type of query 
     * @param type `Types.SOQL`
     * @return  `OrderByOptions`
     */
    public OrderByOptions setType(Types.SOQL type) {
        this.type = type;
        return this;
    }
    
    /**
     * @description Setter for the object to be queried 
     * @param obj `List<ProtoAggreate> | List<SObject>`
     * @return  `OrderByOptions`
     */
    public OrderByOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Getter for the object to be ordered 
     * @return  `Object`
     */
    public Object getObj() {
        return obj;
    }

    /**
     * @description Setter for the top level nodes
     * @param topLevelNodes `TopLevelNodes`
     * @return  `OrderByOptions`
     */
    public OrderByOptions setTopLevelNodes(TopLevelNodes topLevelNodes) {
        this.topLevelNodes = topLevelNodes;
        return this;
    }

    /**
     * @description Getter for the top level nodes
     * @return  `TopLevelNodes`
     */
    public TopLevelNodes getTopLevelNodes() {
        return topLevelNodes;
    }
}