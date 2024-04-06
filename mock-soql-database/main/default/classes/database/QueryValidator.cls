/**
 * @description Validate the AST of a query, this does not validate the query against the schema,
 * but rather checks for invalid queries that are not supported by the SOQL parser
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
    }

    private void validateForUpdate() {
        Node selectNode = topLevelNodes.selectNode;
        Node forUpdateNode = topLevelNodes.forUpdateNode;
        Boolean isAggregateQuery = isAggregateQuery(selectNode);
        Boolean isCount = isSingularCount(selectNode);

        if(isAggregateQuery && forUpdateNode != null) {
            throw new QueryException('FOR UPDATE not allowed in this context');
        }

        if(isCount && forUpdateNode != null) {
            throw new QueryException('FOR UPDATE not allowed in this context');
        }
    }

    private void validateOffset() {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;
        Node offsetNode = topLevelNodes.offsetNode;
        Boolean isAggregateQuery = isAggregateQuery(selectNode);

        if(isAggregateQuery && groupByNode == null && offsetNode != null) {
            throw new QueryException('Non-grouped query that uses overall aggregate functions cannot also use OFFSET');
        }
    }

    private void validateLimit() {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;
        Node limitNode = topLevelNodes.limitNode;
        Boolean isAggregateQuery = isAggregateQuery(selectNode);

        if(isAggregateQuery && groupByNode == null && limitNode != null) {
            throw new QueryException('Non-grouped query that uses overall aggregate functions cannot also use LIMIT');
        }
    }

    private void validateCount() {
        Node selectNode = topLevelNodes.selectNode;
        Node orderByNode = topLevelNodes.orderByNode;
        Boolean isCount = isSingularCount(selectNode);
        if(isCount && orderByNode != null) {
            throw new QueryException('COUNT() and ORDER BY may not be used together');
        }
    }

    private void validateTypeOf() {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;
        Node whereNode = topLevelNodes.whereNode;
        if(isTypeOfQuery(selectNode) && groupByNode != null) {
            throw new QueryException('TYPEOF not supported with GROUP BY');
        }

        if(isTypeOfInWhereClause(whereNode)) {
            throw new QueryException('TYPEOF not supported in outer join');
        }        
    }

    private void validateDuplicates() {
        Node selectNode = topLevelNodes.selectNode;
        if(hasDuplicateSubQueries(selectNode)) {
            throw new QueryException('Cannot follow the same aggregate relationship twice');
        }

        if(hasDuplicateFields(selectNode)) {
            throw new QueryException('Duplicate field selected');
        }
    }

    /**
        * @description Check if this is an aggregate query
        * @param selectNode : the select node
        * @return : true if this is an aggregate query
     */
    private Boolean isAggregateQuery(Node selectNode) {
        Node groupByNode = topLevelNodes.groupByNode;

        if(isSingularCount(selectNode)) {
            return false;
        }

        Node curr = selectNode;
        while(curr != null) {
            if(curr.nodeType == 'aggregate function') {
                return true;
            }
            curr = curr.left;
        }

        if(groupByNode != null) {
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
        while(curr != null) {
            if(curr.nodeType == 'typeof') {
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
        if(whereNode == null) {
            return false;
        }
        if(whereNode.nodeType == 'typeof') {
            return true;
        }
        return isTypeOfInWhereClause(whereNode.left) || isTypeOfInWhereClause(whereNode.right);
    }

    /**
     * @description Check if duplicate fields are selected in the select node
     * @param selectNode : the select node
     * @return : true if duplicate fields are selected
     */
    private Boolean hasDuplicateFields(Node selectNode) {
        Node curr = selectNode;
        Set<String> fieldNames = new Set<String>();
        while(curr != null) {
            if(curr.nodeType == 'field') {
                String fieldName = curr.id;
                if(fieldNames.contains(fieldName)) {
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
        while(curr != null) {
            if(curr.nodeType == 'subquery') {
                Node subQuerySelectNode = curr.right;
                Node subQueryFromNode = subQuerySelectNode.right;
                Node subQueryObjectNode = subQueryFromNode.left;
                String subQueryRelationshipName = subQueryObjectNode.id;

                if(subQueryRelationshipNames.contains(subQueryRelationshipName)) {
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
        return (selectNode.left.id == 'count' && selectNode.left.right == null && selectNode.left.left == null);
    }

}