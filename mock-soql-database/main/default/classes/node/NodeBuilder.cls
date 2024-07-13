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
 * @description : Builder class for the Node class, used to create a Node
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class NodeBuilder {
    /**
     * @description The id of the node
     */
    public String id {get; private set;}
    /**
     * @description The type of the node
     */
    public String nodeType {get; private set;}
    /**
     * @description The left child of the node
     */
    public Node left {get; private set;}
    /**
     * @description The right child of the node
     */
    public Node right {get; private set;}
    
    /**
     * @description : Sets the id of the node
     * @param id : String, the id of the node
     * @return : NodeBuilder, the current instance of the NodeBuilder
     */
    public NodeBuilder setId(String id) {
        this.id = id;
        return this;
    }

    /**
     * @description : Sets the type of the node
     * @param nodeType : String, the type of the node
     * @return : NodeBuilder, the current instance of the NodeBuilder
     */
    public NodeBuilder setNodeType(String nodeType) {
        this.nodeType = nodeType;
        return this;
    }

    /**
     * @description : Sets the left child of the node
     * @param left : Node, the left child of the node
     * @return : NodeBuilder, the current instance of the NodeBuilder
     */
    public NodeBuilder setLeft(Node left) {
        this.left = left;
        return this;
    }

    /**
     * @description : Sets the right child of the node
     * @param right : Node, the right child of the node
     * @return : NodeBuilder, the current instance of the NodeBuilder
     */
    public NodeBuilder setRight(Node right) {
        this.right = right;
        return this;
    }

    /**
     * @description : Builds the node
     * @return : Node, the built node
     */
    public Node build() {
        return new Node(nodeType, id, left, right);
    }

    public static Node fromMap(
        Map<String, Object> nodeMap
    ) {
        return new Node(
            (String) nodeMap.get('nodeType'),
            (String) nodeMap.get('id'),
            fromMap((Map<String, Object>) nodeMap.get('left')),
            fromMap((Map<String, Object>) nodeMap.get('right'))
        );
    }
}