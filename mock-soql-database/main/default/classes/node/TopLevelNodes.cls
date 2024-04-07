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
 * @description This class is used to parse the top level nodes of a SOQL query.
 *              Designed to refresh the instance if the head node changes, i.e. if a new SOQL query is made.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class TopLevelNodes {

    /**
     * @description The main node of the SOQL query, the SELECT node.
     */
    public Node selectNode { get; private set; }
    /**
     * @description The FROM node of the SOQL query.
     */
    public Node fromNode { get; private set; }
    /**
     * @description The WHERE node of the SOQL query.
     */
    public Node whereNode { get; private set; }
    /**
     * @description The GROUP BY node of the SOQL query.
     */
    public Node groupByNode { get; private set; }
    /**
     * @description The HAVING node of the SOQL query.
     */
    public Node havingNode { get; private set; }
    /**
     * @description The ORDER BY node of the SOQL query.
     */
    public Node orderByNode { get; private set; }
    /**
     * @description The LIMIT node of the SOQL query.
     */
    public Node limitNode { get; private set; }
    /**
     * @description The OFFSET node of the SOQL query.
     */
    public Node offsetNode { get; private set; }
    /**
     * @description The FOR UPDATE node of the SOQL query.
     */
    public Node forUpdateNode { get; private set; }
    /**
     * @description The USING SCOPE node of the SOQL query.
     */
    public Node usingScopeNode { get; private set; }

    /**
     * @description Constructor for the TopLevelNodes class.
     * @param selectNode `Node` the head node of the SOQL query.
     */
    public TopLevelNodes(Node selectNode) {
        Node curr = selectNode;
        while(curr != null) {
            curr = put(curr);
        }
    }

    /**
     * @description Sets the appropriate node based on the nodeName. Returns the right node of the current node.
     *              or the node itself if the nodeName is not supported.
     * @param node `Node`
     * @return  `Node`
     */
    private Node put(Node node) {
        switch on node.nodeType {
            when 'select' { 
                this.selectNode = node; 
            }
            when 'from' { 
                this.fromNode = node; 
            }
            when 'where' { 
                this.whereNode = node; 
            }
            when 'group by' { 
                this.groupByNode = node; 
            }
            when 'having' { 
                this.havingNode = node; 
            }
            when 'order by' { 
                this.orderByNode = node; 
            }
            when 'limit' { 
                this.limitNode = node; 
            }
            when 'offset' { 
                this.offsetNode = node; 
            }
            when 'for update' { 
                this.forUpdateNode = node; 
            }
            when 'using scope' { 
                this.usingScopeNode = node; 
            }
            when else {
                return node;
            }
        }
        return node.right;
    }

    private Boolean isNode(Node node, String nodeType) {
        return node != null && node.nodeType == nodeType;
    }
}