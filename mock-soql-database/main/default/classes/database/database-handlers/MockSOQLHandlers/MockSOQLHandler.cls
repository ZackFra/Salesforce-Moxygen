public virtual class MockSOQLHandler {
    final private static Map<Node, TopLevelNodes> TOP_LEVEL_NODES = new Map<Node, TopLevelNodes>();

    protected TopLeveLNodes getTopLevelNodes(Node selectNode) {
        TopLevelNodes topLevelNodes = TOP_LEVEL_NODES.get(selectNode);
        if(topLevelNodes == null) {
            topLevelNodes = new TopLevelNodes(selectNode);
            TOP_LEVEL_NODES.put(selectNode, topLevelNodes);
        }
        return topLevelNodes;
    }

    protected Object handleOrderByNode(
        Types.SOQL typeOfQuery, 
        Object results, 
        Node selectNode
    ) {
        if(results == null) {
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
        if(offsetNode == null) {
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

    protected Boolean checkWhereClause(SObject databaseRecord, node whereNode, Map<String, Object> params) {
        BooleanLogicOptions whereLogicOptions = new BooleanLogicOptions()
            .setHead(whereNode)
            .setObj(databaseRecord)
            .setParams(params);
        WhereLogicHandler whereLogicHandler = new WhereLogicHandler(whereLogicOptions);
        return whereLogicHandler.evaluate();
    }

    /**
     * @description Filter on the "USING SCOPE" clause
     * @param sObj The SObject to filter
     * @param usingScopeNode The "USING SCOPE" node
     * @param params The query parameters
     * @return Whether the SObject passes the filter
     */
    protected Boolean handleUsingScopeNode(SObject sObj, Node usingScopeNode, Map<String, Object> params) {
        // Salesforce at some point will support evaluating formulas in Apex
        // that day is not today, so until then we're just assuming the scope is good
        // https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_formulaeval.htm&release=248&type=5
        return true;
     }

     @SuppressWarnings('PMD.ExcessiveParameterList')
     protected Object handleLimitNode(Types.SOQL typeOfQuery, Node limitNode, Object results, Map<String, Object> params) {
         if(limitNode == null) {
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