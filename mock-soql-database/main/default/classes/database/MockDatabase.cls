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
 * @description The MockDatabase class is used to simulate the Salesforce database in Apex unit tests 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.CognitiveComplexity, PMD.CyclomaticComplexity, PMD.StdCyclomaticComplexity, PMD.ExcessivePublicCount')
public inherited sharing class MockDatabase {

    final Map<Node, TopLevelNodes> topLevelNodes = new Map<Node, TopLevelNodes>();
    MockDatabaseDMLHandler dmlHandler;

    public Map<String, Map<Id, SObject>> mockRecords;
    public MockDatabaseUtils utils = new MockDatabaseUtils(this);

    /**
     * @description The MockDatabase constructor
     */
    public MockDatabase() {
        this.mockRecords = new Map<String, Map<Id, SObject>>();
        this.dmlHandler = new MockDatabaseDMLHandler(mockRecords);
    }

    /**
     * @description The MockDatabase constructor with a database parameter, used for integrating this class 
     *              with other classes
     * @param mockRecords The database to use
     */
    public MockDatabase(Map<String, Map<Id, SObject>> mockRecords) {
        this.mockRecords = mockRecords;
        this.dmlHandler = new MockDatabaseDMLHandler(mockRecords);
    }

    /** Utility methods (For Testing) */

    /**
     * @description Reset the DML handlers call state
     */
    public void resetHandlers() {
        this.dmlHandler.resetHandlers();
    }

    /**
     * @description Returns whether any DML operation was called 
     * @return  `Boolean`
     */
    public Boolean didAnyDML() {
        return this.dmlHandler.wasCalled();
    }

    /**
     * @description Returns whether a specific DML operation was called
     * @param dmlType 
     * @return  `Boolean`
     */
    public Boolean didDML(Types.DML dmlType) {
        return this.dmlHandler.wasCalled(dmlType);
    }

    /**
     * @description Count the number of records in the mock database 
     * @return  `Integer`
     */
    public Integer count() {
        Integer count = 0;
        for(String objApiName : this.mockRecords.keySet()) {
            count += this.mockRecords.get(objApiName).size();
        }
        return count;
    }

    /**
     * @description wasDeleted is used to check if a record was deleted from the database
     * @param recordId - The Id of the record to check
     * @return Boolean - Whether the record was deleted
     */
    public Boolean isDeleted(Id recordId) {
        SObject record = this.utils.findRecord(recordId);
        return (
            record.get('IsDeleted') == true
        );
    }

    /**
     * @description Returns the deleted record by Id
     * @param recordId 
     * @return  `SObject`
     */
    public SObject selectRecordById(Id recordId) {
        return this.utils.findRecord(recordId);
    }

    /** DML methods **/

    /**
     * @description Deletes a record from the mock database
     * @param recordToDelete - The record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone) {
        return dmlHandler.doDelete(recordToDelete, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordsToDelete - The records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        return dmlHandler.doDelete(recordsToDelete, allOrNone);
    }

    /**
     * @description doDelete is used to delete a record from the database
     * @param recordID - The Id of the record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        return dmlHandler.doDelete(recordID, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordIDs - The Ids of the records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        return dmlHandler.doDelete(recordIDs, allOrNone);
    }

    /**
     * @description doMockInsert is used to insert a record into the mock database without setting the `wasCalled` flag
     * @param recordToInsert - The record to insert
     */
    public void doMockInsert(SObject recordToInsert) {
        dmlHandler.doMockInsert(recordToInsert);
    }

    /**
     * @description doMockInsert is used to insert a list of records into the mock database without setting the `wasCalled` flag
     * @param recordsToInsert - The records to insert
     */
    public void doMockInsert(List<SObject> recordsToInsert) {
        dmlHandler.doMockInsert(recordsToInsert);
    }

    /**
     * @description doInsert is used to insert a record into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.SaveResult - The result of the insert operation
     */
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        return dmlHandler.doInsert(recordToInsert, allOrNone, accessLevel);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        return dmlHandler.doInsert(recordToInsert, allOrNone);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        return dmlHandler.doInsert(recordsToInsert, allOrNone);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @param accessLevel - The access level of the user performing the operation
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        return dmlHandler.doInsert(recordsToInsert, allOrNone, accessLevel);
    }

    /**
     * @description doUpdate is used to update a record in the database
     * @param recordToUpdate - The record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        return dmlHandler.doUpdate(recordToUpdate, allOrNone);
    }

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return `List<Database.SaveResult>` - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        return dmlHandler.doUpdate(recordsToUpdate, allOrNone);
    }

    /**
     * @description Updates a record in the mock database
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel AccessLevel of the user performing the operation
     * @return  `Database.SaveResult`
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return dmlHandler.doUpdate(recordToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Update a list of records in the mock database
     * @param recordsToUpdate Records to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access Level of the user performing the operation
     * @return  `List<Database.SaveResult>`
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return dmlHandler.doUpdate(recordsToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Upserts a record into the mock database
     * @param recordToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external ID
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `Database.UpsertResult`
     */
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return dmlHandler.doUpsert(recordToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Upserts a record in the mock database
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external ID
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `List<Database.UpsertResult>`
     */
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return dmlHandler.doUpsert(recordsToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Upserts a record in the mock database
     * @param recordToUpsert Record to upsert
     * @param externalIdField Optional external ID field
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access level of the user performing the operation
     * @return  `Database.UpsertResult`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return dmlHandler.doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel);
    }

    /**
     * @description Upsert a list of records in the mock database
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional external ID field
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access level of the user performing the operation
     * @return  `List<Database.UpsertResult>`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return dmlHandler.doUpsert(recordsToUpsert, externalIdField, allOrNone, accessLevel);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone) {
        return dmlHandler.doUndelete(recordToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordsToUndelete - The records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public List<Database.UndeleteResult> doUndelete(List<sObject> recordsToUndelete, Boolean allOrNone) {
        return dmlHandler.doUndelete(recordsToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordID - The Id of the record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone) {
        return dmlHandler.doUndelete(recordID, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordIDs - The Ids of the records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone) {
        return this.dmlHandler.doUndelete(recordIDs, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel) {
        return this.dmlHandler.doUndelete(recordToUndelete, allOrNone, accessLevel);
    }


    /** SOQL methods **/

    /**
     * @description This method is used to query the mock database by traversing the AST
     * @param query : the query string
     * @return : the query results
     */
    public Object query(String query) {
        return doQuery(query, null);
    }

    /**
     * @description This method is used to query the mock database by traversing the AST
     * @param query : the query string
     * @param params : the query parameters
     * @return : the query results
     */
    public Object queryWithBinds(String query, Map<String, Object> params) {
        Map<String, Object> lowerCaseParams = new Map<String, Object>();
        for(String key : params.keySet()) {
            lowerCaseParams.put(key.toLowerCase(), params.get(key));
        }
        return doQuery(query, lowerCaseParams);       
    }

    /**
     * @description This method is used to query the mock database by traversing the AST
     * @param query : the query string
     * @param params : the query parameters
     * @param access : the access level
     * @return : the query results
     */
    public Object queryWithBinds(String query, Map<String, Object> params, AccessLevel access) {
        return queryWithBinds(query, params);
    }

    // @description: This method is used to query the mock database by traversing the AST
    private Object doQuery(String query, Map<String, Object> params) {
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
    public Object doQuery(Node selectNode, Map<String, Object> params) {
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
        Map<Id, sObject> mockObjects = this.mockRecords.get(objApiName);
        if (mockObjects == null) {
            return this.utils.emptyResponse(topLevelNodes);
        }

        Boolean isAggregateQuery = NodeService.isAggregateQuery(topLevelNodes);
        Boolean isCount = NodeService.isSingularCount(topLevelNodes);

        Object results;

        // results will either be a count, a list of sObjects, or a list of aggregates
        Integer count = 0;
        List<ProtoAggregate> aggregateResults = new List<ProtoAggregate>();
        List<sObject> sObjects = new List<sObject>();


        AggregateQueryHandler aggrHandler = new AggregateQueryHandler(this, topLevelNodes);

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

            if(isAggregateQuery) {
                aggrHandler.processRecord(databaseRecord);
                continue;
            }

            if(isCount) {
                count++;
                continue;
            }

            // handle fields
            SObject queriedRecord = handleSelectQuery(databaseRecord, selectNode, params);
            sObjects.add(queriedRecord);

            
        }
        aggregateResults = aggrHandler.finish();

        // handle the ORDER BY and LIMIT logic here
        if(isAggregateQuery) {
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
        } else if(isCount) {
            count = (Integer) handleOffsetNode(Types.SOQL.COUNT, offsetNode, count, params);
            count = (Integer) handleLimitNode(Types.SOQL.COUNT, limitNode, count, params);
            results = count;
        } else {
            sObjects = (List<SObject>) handleOrderByNode(Types.SOQL.RECORD, sObjects, selectNode);
            sObjects = (List<SObject>) handleOffsetNode(Types.SOQL.RECORD, offsetNode, sObjects, params);
            sObjects = (List<SObject>) handleLimitNode(Types.SOQL.RECORD, limitNode, sObjects, params);
            results = sObjects;
        }
        this.topLevelNodes.remove(selectNode);
        return results;
    }

    /**
     * @description return all SObjects of a given type
     * @param objApiName : the object API name
     * @return : the map of SObjects
     */
    public Map<Id, sObject> get(String objApiName) {
        return this.mockRecords.get(objApiName);
    }

    /**
     * @description Given a record and a field, return the parent record (i.e. the record that field looks up to)
     * @param sObj : the record
     * @param fieldName : the field name
     * @return : the parent record
     * @throws QueryException : if the parent record does not exist
     */
    public Map<String, Object> findParentRecord(sObject sObj, String fieldName) {
        return this.utils.findParentRecord(sObj, fieldName);
    }

    /**
     * @description Wrapper aroung the ComparableService.getComparables method
     * @param record : the record
     * @param field : the field
     * @return : the comparables
     * @throws QueryException : if the comparables cannot be found
     */
    public Map<String, Object> getComparables(SObject record, String field) {
        return ComparableService.getComparables(this, record, field);
    }
    
    private Boolean checkHavingClause(BooleanLogicOptions havingLogicOptions) {
        HavingLogicHandler havingLogicHandler = new HavingLogicHandler(havingLogicOptions);
        return havingLogicHandler.evaluate();
    }

    private Boolean checkWhereClause(SObject databaseRecord, node whereNode, Map<String, Object> params) {
        BooleanLogicOptions whereLogicOptions = new BooleanLogicOptions()
            .setDatabase(this)
            .setHead(whereNode)
            .setObj(databaseRecord)
            .setParams(params);
        WhereLogicHandler whereLogicHandler = new WhereLogicHandler(whereLogicOptions);
        return whereLogicHandler.evaluate();
    }

    private SObject handleSelectQuery(FieldSelector fSelector) {
        Node fieldNode = fSelector.fieldNode;

        SObject queriedRecord = fSelector.queriedRecord;
        if(fieldNode == null) {
            return queriedrecord;
        }

        ISelectHandler selectHandler = new SelectHandlerFactory(fSelector)
            .createHandler();
        queriedRecord = selectHandler.handleSelect();

        // to check the next field node in the list, 
        // the only changes are the queriedRecord and the fieldNode
        fSelector
            .setQueriedRecord(queriedRecord)
            .setFieldNode(fieldNode.left);

        // Recursion, baby!
        return handleSelectQuery(fSelector);
    }

    private SObject handleSelectQuery(sObject databaseRecord, Node selectNode, Map<String, Object> params) {
        Node fieldNode = selectNode.left;
        
        String sObjApiName = SchemaService.getSObjectName(databaseRecord);
        SObject queriedRecord = SchemaService.blankSObjectFrom(sObjApiName);
        queriedRecord.put('Id', databaseRecord.Id);

        FieldSelector fSelector = new FieldSelector()
            .setDatabaseRecord(databaseRecord)
            .setQueriedRecord(queriedRecord)
            .setFieldNode(fieldNode)
            .setParams(params)
            .setDatabase(this);

        return handleSelectQuery(fSelector);
    }

    @SuppressWarnings('PMD.ExcessiveParameterList')
    private Object handleLimitNode(Types.SOQL typeOfQuery, Node limitNode, Object results, Map<String, Object> params) {
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

    private TopLevelNodes getTopLevelNodes(Node selectNode) {
        TopLevelNodes topLevelNodes = this.topLevelNodes.get(selectNode);
        if(topLevelNodes == null) {
            topLevelNodes = new TopLevelNodes(selectNode);
            this.topLevelNodes.put(selectNode, topLevelNodes);
            return topLevelNodes;
        }
        return this.topLevelNodes.get(selectNode);
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
                .setDatabase(this)
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

    private Object handleOrderByNode(
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
    private Object handleOffsetNode(
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

    /**
     * @description Filter on the "USING SCOPE" clause
     * @param sObj The SObject to filter
     * @param usingScopeNode The "USING SCOPE" node
     * @param params The query parameters
     * @return Whether the SObject passes the filter
     */
     private Boolean handleUsingScopeNode(SObject sObj, Node usingScopeNode, Map<String, Object> params) {
        // Salesforce at some point will support evaluating formulas in Apex
        // that day is not today, so until then we're just assuming the scope is good
        // https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_formulaeval.htm&release=248&type=5
        return true;
     }
}