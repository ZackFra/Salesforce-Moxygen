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