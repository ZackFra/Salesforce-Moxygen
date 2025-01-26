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
 * @description This class is responsible for handling record SOQL queries to the mock database
 * @author Zackary Frazier
 * @since 4/12/2024
 * @group Soql Engine
 */
public with sharing class MockRecordQueryHandler extends MockSOQLHandler {
    /**
     * @description Query the database for records
     * @param query `String`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String query) {
        return doQuery(query, null);
    }

    /**
     * @description Query the database for records, with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String query, System.AccessLevel accessLevel) {
        return doQuery(query, null);
    }

    /**
     * @description Query the database for records, with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> queryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return doQuery(query, binds);
    }

    // @description: This method is used to query the mock database by traversing the AST
    private List<SObject> doQuery(String query, Map<String, Object> params) {
        Parser parser = new Parser();
        Node selectNode = parser.parse(query);
        return doQuery(selectNode, params);
    }

    /**
     * @description Used internally, do not use this method
     * @param selectNode The select node
     * @param params The query parameters
     * @return The query results
     * @exception QueryException If the query is invalid
     */
    @SuppressWarnings('PMD.NcssMethodCount')
    public List<SObject> doQuery(Node selectNode, Map<String, Object> params) {
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
        SObjectType sot = SchemaService.getSObjectType(objName);

        // otherwise valid query, but there's no data in the database
        Map<Id, SObject> mockObjects = DataStore.getAllBySot(sot);
        if (mockObjects == null) {
            return emptyResponse();
        }

        Boolean isAggregateQuery = NodeService.isAggregateQuery(topLevelNodes);
        Boolean isCountQuery = NodeService.isSingularCount(topLevelNodes);
        Boolean isRecordQuery = (!isCountQuery && !isAggregateQuery);

        if (!isRecordQuery) {
            throw new QueryException(
                'Only record queries are supported for calls to query()'
            );
        }

        List<SObject> records = new List<sObject>();

        // process the query, whether it's a count, aggregate, or regular query
        for (sObject databaseRecord : mockObjects.values()) {
            if (databaseRecord.get('IsDeleted') == true) {
                continue;
            }

            if (!checkWhereClause(databaseRecord, whereNode, params)) {
                continue;
            }

            if (!handleUsingScopeNode(databaseRecord, usingScopeNode, params)) {
                continue;
            }

            // handle fields
            SObject queriedRecord = handleSelectQuery(
                databaseRecord,
                selectNode,
                params
            );
            records.add(queriedRecord);
        }

        records = (List<SObject>) handleOrderByNode(
            Types.SOQL.RECORD,
            records,
            selectNode
        );
        records = (List<SObject>) handleOffsetNode(
            Types.SOQL.RECORD,
            offsetNode,
            records,
            params
        );
        records = (List<SObject>) handleLimitNode(
            Types.SOQL.RECORD,
            limitNode,
            records,
            params
        );

        removeTopLevelNodesFor(selectNode);
        return records;
    }

    private static SObject handleSelectQuery(
        sObject databaseRecord,
        Node selectNode,
        Map<String, Object> params
    ) {
        Node fieldNode = selectNode.left;

        String sObjApiName = SchemaService.getSObjectName(databaseRecord);
        SObject queriedRecord = SchemaService.blankSObjectFrom(sObjApiName);
        queriedRecord.put('Id', databaseRecord.Id);

        FieldSelector fSelector = new FieldSelector()
            .setDatabaseRecord(databaseRecord)
            .setQueriedRecord(queriedRecord)
            .setFieldNode(fieldNode)
            .setParams(params);

        return handleSelectQuery(fSelector);
    }

    private static SObject handleSelectQuery(FieldSelector fSelector) {
        Node fieldNode = fSelector.fieldNode;

        SObject queriedRecord = fSelector.queriedRecord;
        if (fieldNode == null) {
            return queriedrecord;
        }

        ISelectHandler selectHandler = new SelectHandlerFactory(fSelector)
            .createHandler();
        queriedRecord = selectHandler.handleSelect();

        // to check the next field node in the list,
        // the only changes are the queriedRecord and the fieldNode
        fSelector.setQueriedRecord(queriedRecord).setFieldNode(fieldNode.left);

        // Recursion, baby!
        return handleSelectQuery(fSelector);
    }

    private List<SObject> emptyResponse() {
        return new List<SObject>();
    }
}
