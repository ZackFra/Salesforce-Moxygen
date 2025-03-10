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
 * @description Base class for handling SOQL queries to the mock database
 * @author Zackary Frazier
 * @since 4/13/2024
 * @group Soql Engine
 */
public virtual class MockSOQLHandler {
    final private static Map<Node, TopLevelNodes> TOP_LEVEL_NODES = new Map<Node, TopLevelNodes>();

    /**
     * @description Get the top level nodes for a given select node
     * @param selectNode `Node`
     * @return  `TopLeveLNodes`
     */
    protected TopLeveLNodes getTopLevelNodes(Node selectNode) {
        TopLevelNodes topLevelNodes = TOP_LEVEL_NODES.get(selectNode);
        if (topLevelNodes == null) {
            topLevelNodes = new TopLevelNodes(selectNode);
            TOP_LEVEL_NODES.put(selectNode, topLevelNodes);
        }
        return topLevelNodes;
    }

    /**
     * @description Handles the "ORDER BY" node
     * @param typeOfQuery `Types.SOQL`
     * @param results `Object`
     * @param selectNode `Node`
     * @return  `Object`
     */
    @TestVisible
    protected Object handleOrderByNode(
        Types.SOQL typeOfQuery,
        Object results,
        Node selectNode
    ) {
        if (results == null) {
            return results;
        }

        TopLevelNodes topLevelNodes = getTopLevelNodes(selectNode);

        OrderByHandler orderByHandler = new OrderByHandlerFactory()
            .setObj(results)
            .setTopLevelNodes(topLevelNodes)
            .setType(typeOfQuery)
            .createHandler();
        return orderByHandler.handleOrderBy();
    }

    /**
     * @description : given an offset node, return the offset value
     * @param typeOfQuery : the type of query
     * @param offsetNode : the offset node
     * @param results : the results
     * @param params : the query parameters
     * @return : the offset value
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    protected Object handleOffsetNode(
        Types.SOQL typeOfQuery,
        Node offsetNode,
        Object results,
        Map<String, Object> params
    ) {
        if (offsetNode == null) {
            return results;
        }

        IOffsetHandler offsetHandler = new OffsetHandlerFactory()
            .setType(typeOfQuery)
            .setObj(results)
            .setOffsetNode(offsetNode)
            .setParams(params)
            .createHandler();

        return offsetHandler.handleOffset();
    }

    /**
     * @description Check the "WHERE" clause
     * @param databaseRecord `SObject`
     * @param whereNode `Node`
     * @param params `Map<String, Object>`
     * @return  `Boolean`
     */
    protected Boolean checkWhereClause(
        SObject databaseRecord,
        node whereNode,
        Map<String, Object> params
    ) {
        BooleanLogicOptions whereLogicOptions = new BooleanLogicOptions()
            .setHead(whereNode)
            .setObj(databaseRecord)
            .setParams(params);
        WhereLogicHandler whereLogicHandler = new WhereLogicHandler(
            whereLogicOptions
        );
        return whereLogicHandler.evaluate();
    }

    /**
     * @description Filter on the "USING SCOPE" clause
     * @param sObj The SObject to filter
     * @param usingScopeNode The "USING SCOPE" node
     * @param params The query parameters
     * @return Whether the SObject passes the filter
     */
    protected Boolean handleUsingScopeNode(
        SObject sObj,
        Node usingScopeNode,
        Map<String, Object> params
    ) {
        // Salesforce at some point will support evaluating formulas in Apex
        // that day is not today, so until then we're just assuming the scope is good
        // https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_formulaeval.htm&release=248&type=5
        return true;
    }

    /**
     * @description Handle the "LIMIT" node
     * @param typeOfQuery `Types.SOQL`
     * @param limitNode `Node`
     * @param results `Object`
     * @param params `Map<String, Object>`
     * @return  `Object`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    protected Object handleLimitNode(
        Types.SOQL typeOfQuery,
        Node limitNode,
        Object results,
        Map<String, Object> params
    ) {
        if (limitNode == null) {
            return results;
        }

        ILimitHandler limitHandler = new LimitHandlerFactory()
            .setLimitNode(limitNode)
            .setParams(params)
            .setType(typeOfQuery)
            .setObj(results)
            .createHandler();

        return limitHandler.handleLimit();
    }

    /**
     * @description For a given select node, remove the top level nodes
     * @param selectNode `Node`
     */
    protected void removeTopLevelNodesFor(Node selectNode) {
        TOP_LEVEL_NODES.remove(selectNode);
    }
}
