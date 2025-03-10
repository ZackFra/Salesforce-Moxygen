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
 * @description Validate the AST of a query, this does not validate the query against the schema,
 * but rather checks for invalid queries that are not supported by the SOQL parser
 * @group Soql Engine
 */
@SuppressWarnings('PMD.CyclomaticComplexity, PMD.CognitiveComplexity')
public with sharing class QueryValidator {
    /**
     * @description : The top level nodes of the query
     */
    TopLevelNodes topLevelNodes;

    /**
     * @description : Constructor
     * @param topLevelNodes : the top level nodes of the query
     */
    public QueryValidator(TopLevelNodes topLevelNodes) {
        this.topLevelNodes = topLevelNodes;
    }
    /**
     * @description : given a select node, validate whether this query can be performed
     * @throws QueryException : if the query is invalid
     */
    public void validate() {
        validateTypeOf();
        validateDuplicates();
        validateCount();
        validateLimit();
        validateOffset();
        validateForUpdate();
        validateGroupableFields();
    }

    private void validateForUpdate() {
        Node selectNode = topLevelNodes.selectNode;
        Node forUpdateNode = topLevelNodes.forUpdateNode;
        Boolean isAggregateQuery = isAggregateQuery(selectNode);
        Boolean isCount = isSingularCount(selectNode);

        if (isAggregateQuery && forUpdateNode != null) {
            throw new QueryException('FOR UPDATE not allowed in this context');
        }

        if (isCount && forUpdateNode != null) {
            throw new QueryException('FOR UPDATE not allowed in this context');
        }
    }

    private void validateOffset() {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;
        Node offsetNode = topLevelNodes.offsetNode;
        Boolean isAggregateQuery = isAggregateQuery(selectNode);

        if (isAggregateQuery && groupByNode == null && offsetNode != null) {
            throw new QueryException(
                'Non-grouped query that uses overall aggregate functions cannot also use OFFSET'
            );
        }
    }

    private void validateLimit() {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;
        Node limitNode = topLevelNodes.limitNode;
        Boolean isAggregateQuery = isAggregateQuery(selectNode);

        if (isAggregateQuery && groupByNode == null && limitNode != null) {
            throw new QueryException(
                'Non-grouped query that uses overall aggregate functions cannot also use LIMIT'
            );
        }
    }

    private void validateCount() {
        Node selectNode = topLevelNodes.selectNode;
        Node orderByNode = topLevelNodes.orderByNode;
        Boolean isCount = isSingularCount(selectNode);
        if (isCount && orderByNode != null) {
            throw new QueryException(
                'COUNT() and ORDER BY may not be used together'
            );
        }
    }

    private void validateTypeOf() {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;
        Node whereNode = topLevelNodes.whereNode;
        if (isTypeOfQuery(selectNode) && groupByNode != null) {
            throw new QueryException('TYPEOF not supported with GROUP BY');
        }

        if (isTypeOfInWhereClause(whereNode)) {
            throw new QueryException('TYPEOF not supported in outer join');
        }
    }

    private void validateDuplicates() {
        Node selectNode = topLevelNodes.selectNode;
        if (hasDuplicateSubQueries(selectNode)) {
            throw new QueryException(
                'Cannot follow the same aggregate relationship twice'
            );
        }

        if (hasDuplicateFields(selectNode)) {
            throw new QueryException('Duplicate field selected');
        }
    }

    private void validateGroupableFields() {
        Node groupByNode = topLevelNodes.groupByNode;
        if (groupByNode == null) {
            return;
        }
        Node selectNode = topLevelNodes.selectNode;

        Node currGroupByNode = groupByNode.left;
        while (currGroupByNode != null) {
            if (
                AggregateService.isDateFunc(
                    currGroupByNode.nodeType,
                    currGroupByNode.id
                )
            ) {
                currGroupByNode = currGroupByNode.left;
                continue;
            }
            if (
                AggregateService.isAggregateFunc(
                    currGroupByNode.nodeType,
                    currGroupByNode.id
                )
            ) {
                throw new QueryException(
                    'Only date aggregate functions are allowed as grouping expressions: ' +
                    currGroupByNode.id
                );
            }

            // we can't trust that this isn't something like GROUP BY Account.CreatedDate, so we need to get comparables
            Map<String, Object> comparableData = ComparableService.getComparableDataFromNodes(
                currGroupByNode,
                selectNode
            );
            String fieldName = (String) comparableData.get('comparableField');
            SObject comparableRecord = (SObject) comparableData.get(
                'comparableRecord'
            );
            String sObjectName = SchemaService.getSObjectName(comparableRecord);

            if (!SchemaService.isFieldGroupable(sObjectName, fieldName)) {
                throw new QueryException(
                    'Field is not groupable: ' + groupByNode.id
                );
            }
            currGroupByNode = currGroupByNode.left;
        }
    }

    /**
     * @description Check if this is an aggregate query
     * @param selectNode : the select node
     * @return : true if this is an aggregate query
     */
    private Boolean isAggregateQuery(Node selectNode) {
        Node groupByNode = topLevelNodes.groupByNode;

        if (isSingularCount(selectNode)) {
            return false;
        }

        Node curr = selectNode;
        while (curr != null) {
            if (curr.nodeType == 'aggregate function') {
                return true;
            }
            curr = curr.left;
        }

        if (groupByNode != null) {
            return true;
        }

        return false;
    }

    /**
     * @description Check if typeof is in the select node
     * @param selectNode : the select node
     * @return : true if TYPEOF is in the select node
     */
    private Boolean isTypeOfQuery(Node selectNode) {
        Node curr = selectNode;
        while (curr != null) {
            if (curr.nodeType == 'typeof') {
                return true;
            }
            curr = curr.left;
        }
        return false;
    }

    /**
     * @description Check if TYPEOF is in the where clause
     * @param whereNode : the where node
     * @return : true if TYPEOF is not in the where clause
     */
    private Boolean isTypeOfInWhereClause(Node whereNode) {
        if (whereNode == null) {
            return false;
        }
        if (whereNode.nodeType == 'typeof') {
            return true;
        }
        return isTypeOfInWhereClause(whereNode.left) ||
            isTypeOfInWhereClause(whereNode.right);
    }

    /**
     * @description Check if duplicate fields are selected in the select node
     * @param selectNode : the select node
     * @return : true if duplicate fields are selected
     */
    private Boolean hasDuplicateFields(Node selectNode) {
        Node curr = selectNode;
        Set<String> fieldNames = new Set<String>();
        while (curr != null) {
            if (curr.nodeType == 'field') {
                String fieldName = curr.id;
                if (fieldNames.contains(fieldName)) {
                    return true;
                }
                fieldNames.add(fieldName);
            }
            curr = curr.left;
        }
        return false;
    }
    /**
     * @description Check if there are multiple subqueries on the same SObject in the SELECT clause
     *  @param selectNode The select node
     *  @return true if there are multiple subqueries on the same SObject in the SELECT clause
     */
    private Boolean hasDuplicateSubQueries(Node selectNode) {
        Node curr = selectNode;
        Set<String> subQueryRelationshipNames = new Set<String>();
        while (curr != null) {
            if (curr.nodeType == 'subquery') {
                Node subQuerySelectNode = curr.right;
                Node subQueryFromNode = subQuerySelectNode.right;
                Node subQueryObjectNode = subQueryFromNode.left;
                String subQueryRelationshipName = subQueryObjectNode.id;

                if (
                    subQueryRelationshipNames.contains(subQueryRelationshipName)
                ) {
                    return true;
                }
                subQueryRelationshipNames.add(subQueryRelationshipName);
            }
            curr = curr.left;
        }
        return false;
    }

    /**
     * @description Check if this is a query with just COUNT
     * @param selectNode The select node
     * @return true if this is a query with just COUNT
     */
    private Boolean isSingularCount(Node selectNode) {
        return (selectNode.left.id == 'count' &&
        selectNode.left.right == null &&
        selectNode.left.left == null);
    }
}
