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
 * @description Handler for IN operator
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public class InHandler implements IOperatorHandler {
    static EqualityHandler equalityHandle = new EqualityHandler();
    /**
     * @description Handles the IN operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        List<Node> nodes = new List<Node>();
        for (Object currNode : (List<Object>) fieldValue) {
            nodes.add((Node) currNode);
        }
        return handleList(sObjectFieldValue, nodes, 0);
    }

    private Boolean handleList(
        Object fieldValue,
        List<Node> nodes,
        Integer index
    ) {
        if (index >= nodes.size()) {
            return false;
        }
        Node curr = nodes[index];
        Object currValue = curr.id;
        if (curr.nodeType == NodeType.DATE_LITERAL) {
            currValue = new DateLiteral.Builder()
                .setFieldValue((String) currValue)
                .build();
        }
        Boolean isEqual = equalityHandle.handle(fieldValue, currValue);
        if (!isEqual) {
            isEqual = handleList(fieldValue, nodes, index + 1);
        }
        return isEqual;
    }
}
