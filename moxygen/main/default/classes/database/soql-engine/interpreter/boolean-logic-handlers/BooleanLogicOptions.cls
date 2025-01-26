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
 * @description This class is used to store the options for the BooleanLogic class
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class BooleanLogicOptions {
    /**
     * @description Parameters for bind variables in the query
     */
    public Map<String, Object> params;

    /**
     * @description The object being compared (either SObject or Aggregate)
     */
    public Object obj;

    /**
     * @description The head conditional node
     */
    public Node head;

    /**
     * @description The select node to compare against
     */
    public Node selectNode;

    /**
     * @description Setter for `params`
     * @param params
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }

    /**
     * @description Setter for `obj`
     * @param obj
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Setter for `head` node
     * @param head
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setHead(Node head) {
        this.head = head;
        return this;
    }

    /**
     * @description Setter for `selectNode`
     * @param selectNode
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setSelectNode(Node selectNode) {
        this.selectNode = selectNode;
        return this;
    }
}
