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
            if (value == null) {
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
            if (value == null) {
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
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public Node(String nodeType, string id, Node left, Node right) {
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
        String strVal =
            '{ id: ' +
            this.id +
            ', nodeType: ' +
            this.nodeType +
            ' }';
        if (this.left != null) {
            strVal = this.left.toString() + ', ' + strVal;
        }
        if (this.right != null) {
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
        if (this.left != null) {
            nb.setLeft(this.left.deepClone());
        }
        if (this.right != null) {
            nb.setRight(this.right.deepClone());
        }
        return nb.build();
    }
}
