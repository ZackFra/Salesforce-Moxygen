/**
 * @description : Returns a string representation of the AST
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class Node {
    public Node left;
    public Node right;

    /**
     * @description The id of the node, cannot be null
     */
    public String id {
        get; 
        set {
            if(value == null) {
                throw new IllegalArgumentException('id cannot be null');
            }
            id = value;
        }
    }

    /**
     * @description The type of the node, cannot be null
     */
    public String nodeType {
        get;
        set {
            if(value == null) {
                throw new IllegalArgumentException('nodeType cannot be null');
            }
            nodeType = value;
        }
    }

    /**
     * @description : Constructor for a Node, not to be used directly
     * @param nodeType : String, the type of the node
     * @param id : String, the id of the node
     * @param left : Node, the left child of the node
     * @param right : Node, the right child of the node
     */
    public Node(String nodeType, string id, Node left, Node right) { // NOPMD
        
        this.id = id;
        this.nodeType = nodeType;
        this.left = left;
        this.right = right;
    }
    
    /**
     * @description : Returns a string representation of the node by traversing the tree in pre-order
     * @return : String, the string representation of the node
     */
    public override String toString() {
        String strVal = '{ id: ' + this.id + ', nodeType: ' + this.nodeType + ' }';
        if(this.left != null) {
            strVal = this.left.toString() + ', ' + strVal;
        }
        if(this.right != null) {
            strVal += ', ' + this.right.toString();
        }
        return strVal;
    }

    /**
     * @description : Clones a node and all of its children, recursively
     * @return : Node, the cloned tree
     */
    public Node deepClone() {
        NodeBuilder nb = new NodeBuilder()
            .setId(this.id)
            .setNodeType(this.nodeType);
        if(this.left != null) {
            nb.setLeft(this.left.deepClone());
        }
        if(this.right != null) {
            nb.setRight(this.right.deepClone());
        }
        return nb.build();
    }
}