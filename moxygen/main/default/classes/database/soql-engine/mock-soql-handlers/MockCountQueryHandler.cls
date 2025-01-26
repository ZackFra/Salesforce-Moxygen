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
 * @description This class is responsible for handling count SOQL queries to the mock database
 * @author Zackary Frazier
 * @since 4/13/2024
 * @group Soql Engine
 */
public with sharing class MockCountQueryHandler extends MockSOQLHandler {
    /**
     * @description Perform a count query
     * @param query `String`
     * @return  `Integer`
     */
    public Integer countQuery(String query) {
        return doQuery(query, null);
    }

    /**
     * @description Perform a count query with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQuery(String query, System.AccessLevel accessLevel) {
        return doQuery(query, null);
    }

    /**
     * @description Perform a count query with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQueryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
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
        SObjectType sot = SchemaService.getSObjectType(objName);

        // otherwise valid query, but there's no data in the database
        Map<Id, sObject> mockObjects = DataStore.getAllBySot(sot);
        if (mockObjects == null) {
            return emptyResponse();
        }

        Boolean isCountQuery = NodeService.isSingularCount(topLevelNodes);
        if (!isCountQuery) {
            throw new QueryException(
                'Only count queries are supported for calls to countQuery()'
            );
        }

        // results will either be a count, a list of sObjects, or a list of aggregates
        Integer count = 0;

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
            count++;
        }

        count = (Integer) handleOffsetNode(
            Types.SOQL.COUNT,
            offsetNode,
            count,
            params
        );
        count = (Integer) handleLimitNode(
            Types.SOQL.COUNT,
            limitNode,
            count,
            params
        );

        removeTopLevelNodesFor(selectNode);
        return count;
    }

    private Integer emptyResponse() {
        return 0;
    }
}
