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
 * @description Service class for manipulating and describing the nodes of the AST created by the parser
 *              each method is a static method that takes in a TopLevelNodes
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class NodeService {
    
    /**
     * @description Returns whether or not the query is an aggregate query
     * @param topLevelNodes `TopLevelNodes`
     * @return  `Boolean`
     */
    public static Boolean isAggregateQuery(TopLevelNodes topLevelNodes) {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;

        if(isSingularCount(topLevelNodes)) {
            return false;
        }

        Node curr = selectNode;
        while(curr != null) {
            if(curr.nodeType == 'aggregate function') {
                return true;
            }
            curr = curr.left;
        }

        if(groupByNode != null) {
            return true;
        }

        return false;
    }

    /**
     * @description Returns whether this is a COUNT query
     * @param topLevelNodes `TopLevelNodes`
     * @return  `Boolean`
     */
    public static Boolean isSingularCount(TopLevelNodes topLevelNodes) {
        Node selectNode = topLevelNodes.selectNode;
        return (selectNode.left.id == 'count' && selectNode.left.right == null && selectNode.left.left == null);
    }

}