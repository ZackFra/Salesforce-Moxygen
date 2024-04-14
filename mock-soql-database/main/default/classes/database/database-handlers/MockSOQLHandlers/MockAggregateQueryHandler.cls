public inherited sharing class MockAggregateQueryHandler extends MockSOQLHandler {

    public List<Aggregate> aggregateQuery(String query) {
        return doQuery(query, null);
    }

    public List<Aggregate> aggregateQuery(String query, System.AccessLevel accessLevel) {
        return doQuery(query, null);
    }

    public List<Aggregate> aggregateQueryWithBinds(String query, Map<String, Object> binds, System.AccessLevel accessLevel) {
        return doQuery(query, binds);
    }

    private List<Aggregate> doQuery(String query, Map<String, Object> params) {
        Parser parser = new Parser();
        Node selectNode = parser.parse(query);
        return doQuery(selectNode, params);
    }

    private List<Aggregate> doQuery(Node selectNode, Map<String, Object> params) {
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

        Boolean isAggregateQuery = NodeService.isAggregateQuery(topLevelNodes);

        if(!isAggregateQuery) { 
            throw new QueryException('Only aggregate queries are supported for calls to aggregateQuery()');
        }

        List<Aggregate> results;

        // results will either be a count, a list of sObjects, or a list of aggregates
        List<ProtoAggregate> aggregateResults = new List<ProtoAggregate>();


        AggregateQueryHandler aggrHandler = new AggregateQueryHandler(topLevelNodes);

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

            aggrHandler.processRecord(databaseRecord);

        }
        aggregateResults = aggrHandler.finish();

        aggregateResults = (List<ProtoAggregate>) handleHavingNode(aggregateResults, selectNode, params);
        aggregateResults = (List<ProtoAggregate>) handleOrderByNode(Types.SOQL.AGGREGATE, aggregateResults, selectNode);
        aggregateResults = (List<ProtoAggregate>) handleOffsetNode(Types.SOQL.AGGREGATE, offsetNode, aggregateResults, params);
        aggregateResults = (List<ProtoAggregate>) handleLimitNode(Types.SOQL.AGGREGATE, limitNode, aggregateResults, params);

        // Remove internal fields from the aggregate result proto-records and return the list of aggregates
        List<Aggregate> aggregateResultsList = new AggregateBuilder()
            .setParams(params)
            .setProtoAggregates(aggregateResults)
            .setTopLevelNodes(topLevelNodes)
            .build();
        
        results = aggregateResultsList;

        removeTopLevelNodesFor(selectNode);
        return results;
    }

    private static Boolean checkHavingClause(BooleanLogicOptions havingLogicOptions) {
        HavingLogicHandler havingLogicHandler = new HavingLogicHandler(havingLogicOptions);
        return havingLogicHandler.evaluate();
    }

    private List<ProtoAggregate> handleHavingNode(
        List<ProtoAggregate> aggregateResults, 
        Node selectNode, 
        Map<String, Object> params
    ) {
        TopLevelNodes topLevelNodes = getTopLevelNodes(selectNode);
        Node havingNode = topLevelNodes.havingNode;
        if(havingNode == null) {
            return aggregateResults;
        }

        List<ProtoAggregate> results = new List<ProtoAggregate>();
        for(ProtoAggregate ar : aggregateResults) {

            BooleanLogicOptions havingLogicOptions = new BooleanLogicOptions()
                .setHead(havingNode)
                .setSelectNode(selectNode)
                .setObj(ar)
                .setParams(params);
            
            if(checkHavingClause(havingLogicOptions)) {
                results.add(ar);
            }
        }
        return results;
    }

    private List<Aggregate> emptyResponse() {
        return new List<Aggregate>();
    }
}