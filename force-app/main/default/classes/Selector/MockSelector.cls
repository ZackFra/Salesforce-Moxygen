@IsTest
public inherited sharing class MockSelector implements ISelector {
    Map<String, List<SObject>> queries = new Map<String, List<SObject>>();
    Map<String, List<Aggregate>> aggregateQueries = new Map<String, List<Aggregate>>();
    Map<String, Integer> countQueries = new Map<String, Integer>();

    Boolean wasCalled = false;
    Map<String, Boolean> callMap = new Map<String, Boolean>();

    /**
     * @Description Returns whether or not the mock object was called
     * @return Boolean
     */
    public Boolean wasCalled() {
        return this.wasCalled;
    }

    /**
     * @Description Returns whether or not the mock object was called with the given query string
     * @param queryString The query string to check
     * @return Boolean
     */
    public Boolean wasCalled(String queryString) {
        return callMap.containsKey(queryString) && callMap.get(queryString);
    }

    /**
     * @Description Resets the call state of the mock object
     * @return void
     * @note Does NOT reset the registered queries
     */
    public void resetCallState() {
        this.wasCalled = false;
        this.callMap.clear();
    }

    /**
     * @Description Registers a query that will return the given records when executed
     * @param queryString The query string to register
     * @param records The records to return when the query is executed
     */
    public MockSelector registerQuery(String queryString, List<SObject> records) {
        queries.put(queryString, records);
        return this;
    }

    /**
     * @Description Registers a query that will throw an exception when executed
     * @param queryString The query string to register
     * @return The current instance of the MockQuery
     */
    public MockSelector registerFailedQuery(String queryString) {
        queries.put(queryString, null);
        return this;
    }

    /**
     * @description Registers an aggregate query that will return the given records when executed
     * @param queryString The query string to register
     * @param records The records to return when the query is executed
     */
    public MockSelector registerAggregateQuery(String queryString, List<Aggregate> records) {
        aggregateQueries.put(queryString, records);
        return this;
    }

    /**
     * @description Registers an aggregate query that will throw an exception when executed
     * @param queryString The query string to register
     * @return The current instance of the MockQuery
     */
    public MockSelector registerFailedAggregateQuery(String queryString) {
        aggregateQueries.put(queryString, null);
        return this;
    }

    /**
     * @description Registers a count query that will return the given count when executed
     * @param queryString The query string to register
     * @param count The count to return when the query is executed
     * @return The current instance of the MockQuery
     */
    public MockSelector registerCountQuery(String queryString, Integer count) {
        countQueries.put(queryString, count);
        return this;
    }

    /**
     * @description Registers a count query that will throw an exception when executed
     * @param queryString The query string to register
     * @return The current instance of the MockQuery
     */
    public MockSelector registerFailedCountQuery(String queryString) {
        countQueries.put(queryString, null);
        return this;
    }


    public List<SObject> query(String queryString) {
        return onQuery(queryString);
    }

    public List<SObject> query(String queryString, System.AccessLevel accessLevel) {
        return onQuery(queryString);
    }

    public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return onQuery(queryString);
    }

    public List<Aggregate> queryAggregate(String queryString) {
        return onQueryAggregate(queryString);
    }

    public List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel) {
        return onQueryAggregate(queryString);
    }

    public List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return onQueryAggregate(queryString);
    }

    public Integer countQuery(String query) {
        return onCountQuery(query);
    }

    public Integer countQuery(String query, System.AccessLevel accessLevel) {
        return onCountQuery(query);
    }

    public Integer countQueryWithBinds(String query, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return onCountQuery(query);
    }

    private Integer onCountQuery(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(countQueries.containsKey(queryString) && countQueries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(countQueries.containsKey(queryString)) {
            return countQueries.get(queryString);
        }
        return 0;
    }

    private List<SObject> onQuery(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(queries.containsKey(queryString) && queries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        }
        return new List<SObject>();
    }

    private List<Aggregate> onQueryAggregate(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(aggregateQueries.containsKey(queryString) && aggregateQueries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(aggregateQueries.containsKey(queryString)) {
            return aggregateQueries.get(queryString);
        }
        return new List<Aggregate>();
    }
}