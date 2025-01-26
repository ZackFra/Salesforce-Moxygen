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
 * @description Tool for finding the aliases on nodes
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AliasService {
    /**
     * @description Get the field alias
     * @param curr
     * @param fieldNode
     * @param selectNode
     * @return  `Map<String, String>`
     */
    public static Map<String, String> getFieldAlias(
        Node curr,
        Node fieldNode,
        Node selectNode
    ) {
        Node aliasNode = curr.right;
        String fieldApiName;
        String relationshipName;
        if (aliasNode != null) {
            fieldApiName = aliasNode.id;
            relationshipName = null;
        } else {
            Map<String, Object> comparables = ComparableService.getComparableDataFromNodes(
                fieldNode,
                selectNode
            );
            relationshipName = (String) comparables.get('relationshipName');
            fieldApiName = (String) comparables.get('comparableField');
        }

        return new Map<String, String>{
            'fieldApiName' => fieldApiName,
            'relationshipName' => relationshipName
        };
    }

    private static Map<String, String> getAggrFuncAlias(
        Node curr,
        Integer exprNumber
    ) {
        Node aggrFieldNode = curr.right;
        Node aliasNode = aggrFieldNode.left;
        String fieldApiName;
        if (aliasNode != null) {
            fieldApiName = aliasNode.id;
        } else {
            fieldApiName = 'expr' + exprNumber;
        }

        return new Map<String, String>{
            'fieldApiName' => fieldApiName,
            'relationshipName' => null
        };
    }
    /**
     * @description Get the alias for a field node
     * @param selectNode
     * @param fieldNode
     * @return  `Map<String, String>`
     * @exception
     */
    public static Map<String, String> getAlias(
        Node selectNode,
        Node fieldNode
    ) {
        Integer exprNumber = 0;

        Node curr = selectNode.left;
        while (curr != null) {
            Boolean isField = (curr.nodeType == NodeType.FIELD);
            Boolean isSameId = (curr.id == fieldNode.id);

            Boolean isAggregateFunc = (curr.nodeType ==
            NodeType.AGGREGATE_FUNCTION);
            Boolean isSameAggrField = (isAggregateFunc &&
            curr.right.id == fieldNode?.right?.id);

            if (isField && isSameId) {
                return getFieldAlias(curr, fieldNode, selectNode);
            } else if (isAggregateFunc && isSameAggrField && isSameId) {
                return getAggrFuncAlias(curr, exprNumber);
            } else if (isAggregateFunc) {
                exprNumber++;
            }
            curr = curr.left;
        }
        throw new QueryException('No alias found');
    }
}
