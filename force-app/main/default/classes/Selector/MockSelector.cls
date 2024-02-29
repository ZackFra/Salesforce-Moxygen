@IsTest
public inherited sharing class MockSelector implements ISelector {
    Map<String, List<SObject>> queries = new Map<String, List<SObject>>();
    Boolean wasCalled = false;
    Map<String, Boolean> callMap = new Map<String, Boolean>();

    public Boolean wasCalled() {
        return this.wasCalled;
    }

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

    public List<SObject> onQuery(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(queries.containsKey(queryString) && queries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        }
        return new List<SObject>();
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
}