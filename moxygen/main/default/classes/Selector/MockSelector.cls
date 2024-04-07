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
 * @description Mock implementation of the ISelector interface for use in unit tests
 * @author Zackary Frazier
 * @since 3/9/2024
 */
@SuppressWarnings('PMD.CyclomaticComplexity')
public inherited sharing class MockSelector implements ISelector {
    Map<String, List<SObject>> queries = new Map<String, List<SObject>>();
    Map<String, List<Aggregate>> aggregateQueries = new Map<String, List<Aggregate>>();
    Map<String, Integer> countQueries = new Map<String, Integer>();

    Boolean wasCalled = false;
    Map<String, Boolean> callMap = new Map<String, Boolean>();

    MockDatabase db;
    /**
     * @description Constructor for the MockSelector class 
     * @param db 
     */
    public MockSelector(MockDatabase db) {
        this.db = db;
    }

    /**
     * @description Returns whether or not the mock object was called
     * @return Boolean
     */
    public Boolean wasCalled() {
        return this.wasCalled;
    }

    /**
     * @description Returns whether or not the mock object was called with the given query string
     * @param queryString The query string to check
     * @return Boolean
     */
    public Boolean wasCalled(String queryString) {
        return callMap.containsKey(queryString) && callMap.get(queryString);
    }

    /**
     * @description Resets the call state of the mock object
     */
    public void resetCallState() {
        this.wasCalled = false;
        this.callMap.clear();
    }

    /**
     * @description Registers a query that will return the given records when executed
     * @param queryString The query string to register
     * @param records The records to return when the query is executed
     * @return The current instance of the MockQuery
     */
    public MockSelector registerQuery(String queryString, List<SObject> records) {
        queries.put(queryString, records);
        return this;
    }

    /**
     * @description Registers a query that will throw an exception when executed
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
     * @return The current instance of the MockQuery
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

    /**
     * @description Query for records using the given query string
     * @param queryString `String`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String queryString) {
        return onQuery(queryString);
    }

    /**
     * @description Query for records using the given query string and access level
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String queryString, System.AccessLevel accessLevel) {
        return onQuery(queryString);
    }

    /**
     * @description Query for records using the given query string and bind map
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return onQuery(queryString, bindMap);
    }

    /**
     * @description Query for aggregate records using the given query string
     * @param queryString `String`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> queryAggregate(String queryString) {
        return onQueryAggregate(queryString);
    }

    /**
     * @description Query for aggregate records using the given query string and access level
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel) {
        return onQueryAggregate(queryString);
    }

    /**
     * @description Query for aggregate records using the given query string and bind map
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return onQueryAggregate(queryString, bindMap);
    }

    /**
     * @description Query for the count of records using the given query string
     * @param query `String`
     * @return  `Integer`
     */
    public Integer countQuery(String query) {
        return onQueryCount(query);
    }

    /**
     * @description Count the records using the given query string and access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQuery(String query, System.AccessLevel accessLevel) {
        return onQueryCount(query);
    }

    /**
     * @description Count the records using the given query string and bind map
     * @param query `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQueryWithBinds(String query, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return onQueryCountWithBinds(query, bindMap);
    }

    private Integer onQueryCountWithBinds(String queryString, Map<String, Object> bindMap) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(countQueries.containsKey(queryString) && countQueries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(countQueries.containsKey(queryString)) {
            return countQueries.get(queryString);
        } else {
            return (Integer) db.queryWithBinds(queryString, bindMap);
        }        
    }

    private Integer onQueryCount(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(countQueries.containsKey(queryString) && countQueries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(countQueries.containsKey(queryString)) {
            return countQueries.get(queryString);
        } else {
            return (Integer) db.query(queryString);
        }
    }

    /**
     * @description The method that is called when a query is executed
     * @param queryString The query string that was executed
     * @return The records to return
     */
    private List<SObject> onQuery(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(queries.containsKey(queryString) && queries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        } else {
            return (List<SObject>) db.query(queryString);
        }
    }

    /**
     * @description The method that is called when a query is executed
     * @param queryString `String` The query string that was executed
     * @param bindMap `Map<String, Object>`
     * @return The records to return
     */
    private List<SObject> onQuery(String queryString, Map<String, Object> bindMap) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(queries.containsKey(queryString) && queries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        } else {
            return (List<SObject>) db.queryWithBinds(queryString, bindMap);
        }
    }

    /**
     * @description The method that is called when an aggregate query is executed
     * @param queryString `String`
     * @return `List<Aggregate>`
     */
    private List<Aggregate> onQueryAggregate(String queryString) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(aggregateQueries.containsKey(queryString) && aggregateQueries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(aggregateQueries.containsKey(queryString)) {
            return aggregateQueries.get(queryString);
        } else {
            return (List<Aggregate>) db.query(queryString);
        }
    }

    /**
     * @description The method that is called when an aggregate query is executed
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @return `List<Aggregate>`
     */
    private List<Aggregate> onQueryAggregate(String queryString, Map<String, Object> bindMap) {
        this.wasCalled = true;
        callMap.put(queryString, true);

        if(aggregateQueries.containsKey(queryString) && aggregateQueries.get(queryString) == null) {
            throw new QueryException('Query failed');
        } else if(aggregateQueries.containsKey(queryString)) {
            return aggregateQueries.get(queryString);
        } else {
            return (List<Aggregate>) db.queryWithBinds(queryString, bindMap);
        }
    }
}