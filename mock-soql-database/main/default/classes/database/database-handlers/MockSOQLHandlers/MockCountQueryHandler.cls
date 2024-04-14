public inherited sharing class MockCountQueryHandler extends MockSOQLHandler {
    public Integer countQuery(String query) {
        return doQuery(query, null);
    }

    public Integer countQuery(String query, System.AccessLevel accessLevel) {
        return doQuery(query, null);
    }

    public Integer countQueryWithBinds(String query, Map<String, Object> binds, System.AccessLevel accessLevel) {
        return doQuery(query, binds);
    }

    // @description: This method is used to query the mock database by traversing the AST
    private Integer doQuery(String query, Map<String, Object> params) {
        Parser parser = new Parser();
        Node selectNode = parser.parse(query);
        return doQuery(selectNode, params);
    }

    /**
     * @description Used internally, do not use this method
     * @param selectNode : the select node
     * @param params : the query parameters
     * @return : the query results
     * @throws QueryException : if the query is invalid
     */
    @SuppressWarnings('PMD.NcssMethodCount')
    private Integer doQuery(Node selectNode, Map<String, Object> params) {
        TopLevelNodes topLevelNodes = getTopLevelNodes(selectNode);
        Node fromNode = topLevelNodes.fromNode;
        Node whereNode = topLevelNodes.whereNode;
        Node limitNode = topLevelNodes.limitNode;
        Node offsetNode = topLevelNodes.offsetNode;
        Node usingScopeNode = topLevelNodes.usingScopeNode;

        // validate the query, throws exception if invalid
        QueryValidator validator = new QueryValidator(topLevelNodes);
        validator.validate();

        Node objNode = fromNode.left;
        String objName = objNode.id;
        String objApiName = SchemaService.getSObjectName(objName);

        // otherwise valid query, but there's no data in the database
        Map<Id, sObject> mockObjects = MockDatabase.mockRecords.get(objApiName);
        if (mockObjects == null) {
            return emptyResponse();
        }

        Boolean isCountQuery = NodeService.isSingularCount(topLevelNodes);
        if(!isCountQuery) {
            throw new QueryException('Only count queries are supported for calls to countQuery()');
        }

        // results will either be a count, a list of sObjects, or a list of aggregates
        Integer count = 0;

        // process the query, whether it's a count, aggregate, or regular query
        for(sObject databaseRecord : mockObjects.values()) {

            if(databaseRecord.get('IsDeleted') == true) {
                continue;
            }

            if(!checkWhereClause(databaseRecord, whereNode, params)) {
                continue;
            }

            if(!handleUsingScopeNode(databaseRecord, usingScopeNode, params)) {
                continue;
            }
            count++;
        }


        count = (Integer) handleOffsetNode(Types.SOQL.COUNT, offsetNode, count, params);
        count = (Integer) handleLimitNode(Types.SOQL.COUNT, limitNode, count, params);

        removeTopLevelNodesFor(selectNode);
        return count;
    }

    private Integer emptyResponse() {
        return 0;
    }
}