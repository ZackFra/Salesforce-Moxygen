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
 * @description This class is responsible for handling aggregate SOQL queries to the mock database
 * @author Zackary Frazier
 * @since 4/13/2024
 */
public inherited sharing class MockAggregateQueryHandler extends MockSOQLHandler {

    /**
     * @description Perform an aggregate query
     * @param query `String`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> aggregateQuery(String query) {
        return doQuery(query, null);
    }

    /**
     * @description Perform an aggregate query with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> aggregateQuery(String query, System.AccessLevel accessLevel) {
        return doQuery(query, null);
    }

    /**
     * @description Perform an aggregate query with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> aggregateQueryWithBinds(String query, Map<String, Object> binds, System.AccessLevel accessLevel) {
        return doQuery(query, binds);
    }

    /**
     * @description Perform an aggregate query
     * @param query `String`
     * @param params `Map<String, Object>`
     * @return  `List<Aggregate>`
     */
    private List<Aggregate> doQuery(String query, Map<String, Object> params) {
        Parser parser = new Parser();
        Node selectNode = parser.parse(query);
        return doQuery(selectNode, params);
    }

    @SuppressWarnings('PMD.NcssMethodCount')
    @TestVisible
    private List<Aggregate> doQuery(Node selectNode, Map<String, Object> params) {
        TopLevelNodes topLevelNodes = getTopLevelNodes(selectNode);
        Node fromNode = topLevelNodes.fromNode;
        Node limitNode = topLevelNodes.limitNode;
        Node offsetNode = topLevelNodes.offsetNode;

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
        List<SObject> databaseRecords = mockObjects.values();
        List<ProtoAggregate> aggregateResults = handleFilterAndGroupByNodes(topLevelNodes, databaseRecords, params);

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

    @TestVisible
    private List<ProtoAggregate> handleFilterAndGroupByNodes(
        TopLevelNodes topLevelNodes, 
        List<SObject> databaseRecords, 
        Map<String, Object> params
    ) {
        AggregateQueryHandler aggrHandler = new AggregateQueryHandler(topLevelNodes);

        // process the query, whether it's a count, aggregate, or regular query
        for(sObject databaseRecord : databaseRecords) {

            if(databaseRecord.get('IsDeleted') == true) {
                continue;
            }

            if(!checkWhereClause(databaseRecord, topLevelNodes.whereNode, params)) {
                continue;
            }

            if(!handleUsingScopeNode(databaseRecord, topLevelNodes.usingScopeNode, params)) {
                continue;
            }

            aggrHandler.processRecord(databaseRecord);

        }
        return aggrHandler.finish();
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

    private static Boolean checkHavingClause(BooleanLogicOptions havingLogicOptions) {
        HavingLogicHandler havingLogicHandler = new HavingLogicHandler(havingLogicOptions);
        return havingLogicHandler.evaluate();
    }

    private List<Aggregate> emptyResponse() {
        return new List<Aggregate>();
    }
}