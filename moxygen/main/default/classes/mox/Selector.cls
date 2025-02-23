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
 * @description Wrapper class for Database class's query methods. This class is used to allow for mocking of the Database class in unit tests.
 * @author Zackary Frazier
 * @since 3/9/2024
 * @group Moxygen
 */
@SuppressWarnings('PMD.CognitiveComplexity, PMD.CyclomaticComplexity')
public inherited sharing class Selector {
    /*** UNIT TEST ATTRIBUTES  */
    static Map<String, List<SObject>> queries = new Map<String, List<SObject>>();
    static Map<String, List<Aggregate>> aggregateQueries = new Map<String, List<Aggregate>>();
    static Map<String, Integer> countQueries = new Map<String, Integer>();

    static Boolean wasCalled = false;
    static Map<String, Boolean> callMap = new Map<String, Boolean>();

    /**
     * @description Query for a list of sObjects
     * @param queryString SOQL Query to be executed
     * @return Returns a list of records that match the query. Will parse backticks out of the query string.
     */
    public static List<SObject> query(String queryString) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQuery(queryString);
        }
        return Database.query(queryString);
    }

    /**
     * @description Query for a list of sObjects
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public static List<SObject> query(
        String queryString,
        System.AccessLevel accessLevel
    ) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQuery(queryString);
        }
        return Database.query(queryString, accessLevel);
    }

    /**
     * @description Query for a list of sObjects with bind variables
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public static List<SObject> queryWithBinds(
        String queryString,
        Map<String, Object> bindMap,
        System.AccessLevel accessLevel
    ) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQuery(queryString, bindMap, accessLevel);
        }
        return Database.queryWithBinds(queryString, bindMap, accessLevel);
    }

    /**
     * @description perform an aggregate query
     * @param queryString `String`
     * @return  `List<Aggregate>`
     */
    public static List<Aggregate> aggregateQuery(String queryString) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQueryAggregate(queryString);
        }
        List<AggregateResult> arList = Database.query(queryString);
        List<Aggregate> agList = new List<Aggregate>();
        for (AggregateResult ar : arList) {
            agList.add(new Aggregate(ar));
        }
        return agList;
    }

    /**
     * @description Query for a list of sObjects
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public static List<Aggregate> aggregateQuery(
        String queryString,
        System.AccessLevel accessLevel
    ) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQueryAggregate(queryString);
        }
        List<AggregateResult> arList = Database.query(queryString, accessLevel);
        List<Aggregate> agList = new List<Aggregate>();
        for (AggregateResult ar : arList) {
            agList.add(new Aggregate(ar));
        }
        return agList;
    }

    /**
     * @description Query for a list of sObjects with bind variables
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public static List<Aggregate> aggregateQueryWithBinds(
        String queryString,
        Map<String, Object> bindMap,
        System.AccessLevel accessLevel
    ) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQueryAggregate(queryString, bindMap, accessLevel);
        }
        List<AggregateResult> arList = Database.queryWithBinds(
            queryString,
            bindMap,
            accessLevel
        );
        List<Aggregate> agList = new List<Aggregate>();
        for (AggregateResult ar : arList) {
            agList.add(new Aggregate(ar));
        }
        return agList;
    }

    /**
     * @description Count the number of records returned by a query
     * @param queryString `String`
     * @return  `Integer`
     */
    public static Integer countQuery(String queryString) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQueryCount(queryString);
        }
        return Database.countQuery(queryString);
    }

    /**
     * @description Count the number of records returned by a query
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public static Integer countQuery(
        String queryString,
        System.AccessLevel accessLevel
    ) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQueryCount(queryString);
        }
        return Database.countQuery(queryString, accessLevel);
    }

    /**
     * @description Count the number of records returned by a query
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public static Integer countQueryWithBinds(
        String queryString,
        Map<String, Object> bindMap,
        System.AccessLevel accessLevel
    ) {
        queryString = parseBackTicks(queryString);

        if (ORM.isUnitTest()) {
            return onQueryCountWithBinds(queryString, bindMap, accessLevel);
        }
        return Database.countQueryWithBinds(queryString, bindMap, accessLevel);
    }

    private static String parseBackTicks(String queryString) {
        if (ORM.isBacktickReplacementEnabled()) {
            queryString = queryString.replaceAll('`', '\'');
        }
        return queryString;
    }

    /** Unit Test Logic */

    /**
     * @description Returns whether or not the mock object was called
     * @return `Boolean`
     */
    @TestVisible
    private static Boolean calledAnyQuery() {
        ORM.validateUnitTestContext();
        return wasCalled;
    }

    /**
     * @description Returns whether or not the mock object was called with the given query string
     * @param queryString The query string to check
     * @return Boolean
     */
    @TestVisible
    private static Boolean calledQuery(String queryString) {
        ORM.validateUnitTestContext();
        return callMap.containsKey(queryString) && callMap.get(queryString);
    }

    /**
     * @description Resets the call state of the mock object
     */
    @TestVisible
    private static void resetCallState() {
        ORM.validateUnitTestContext();
        wasCalled = false;
        callMap.clear();
    }

    /**
     * @description Registers a query that will return the given records when executed
     * @param queryString The query string to register
     * @param records The records to return when the query is executed
     */
    @TestVisible
    private static void registerQuery(
        String queryString,
        List<SObject> records
    ) {
        ORM.validateUnitTestContext();
        queries.put(queryString, records);
    }

    /**
     * @description Registers a query that will throw an exception when executed
     * @param queryString The query string to register
     */
    @TestVisible
    private static void registerFailedQuery(String queryString) {
        ORM.validateUnitTestContext();
        queries.put(queryString, null);
    }

    /**
     * @description Registers an aggregate query that will return the given records when executed
     * @param queryString The query string to register
     * @param records The records to return when the query is executed
     */
    @TestVisible
    private static void registerAggregateQuery(
        String queryString,
        List<Aggregate> records
    ) {
        ORM.validateUnitTestContext();
        aggregateQueries.put(queryString, records);
    }

    /**
     * @description Registers an aggregate query that will throw an exception when executed
     * @param queryString The query string to register
     */
    @TestVisible
    private static void registerFailedAggregateQuery(String queryString) {
        ORM.validateUnitTestContext();
        aggregateQueries.put(queryString, null);
    }

    /**
     * @description Registers a count query that will return the given count when executed
     * @param queryString The query string to register
     * @param count The count to return when the query is executed
     */
    @TestVisible
    private static void registerCountQuery(String queryString, Integer count) {
        ORM.validateUnitTestContext();
        countQueries.put(queryString, count);
    }

    /**
     * @description Registers a count query that will throw an exception when executed
     * @param queryString The query string to register
     */
    @TestVisible
    private static void registerFailedCountQuery(String queryString) {
        ORM.validateUnitTestContext();
        countQueries.put(queryString, null);
    }

    /**
     * @description Selects a record by its Id
     * @param recordId `Id`
     * @return  `SObject`
     */
    @TestVisible
    private static SObject selectRecordById(Id recordId) {
        ORM.validateUnitTestContext();
        return DataStore.getById(recordId);
    }

    private static Integer onQueryCountWithBinds(
        String queryString,
        Map<String, Object> bindMap,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        callMap.put(queryString, true);

        if (isFailedCountQuery(queryString)) {
            throw new QueryException('Query failed');
        } else if (countQueries.containsKey(queryString)) {
            return countQueries.get(queryString);
        } else {
            return MockDatabase.countQueryWithBinds(
                queryString,
                bindMap,
                accessLevel
            );
        }
    }

    private static Integer onQueryCount(String queryString) {
        wasCalled = true;
        callMap.put(queryString, true);

        if (isFailedCountQuery(queryString)) {
            throw new QueryException('Query failed');
        } else if (countQueries.containsKey(queryString)) {
            return countQueries.get(queryString);
        } else {
            return MockDatabase.countQuery(queryString);
        }
    }

    /**
     * @description The method that is called when a query is executed
     * @param queryString The query string that was executed
     * @return The records to return
     */
    private static List<SObject> onQuery(String queryString) {
        wasCalled = true;
        callMap.put(queryString, true);

        if (isFailedQuery(queryString)) {
            throw new QueryException('Query failed');
        } else if (queries.containsKey(queryString)) {
            return queries.get(queryString);
        } else {
            return MockDatabase.query(queryString);
        }
    }

    /**
     * @description The method that is called when a query is executed
     * @param queryString `String` The query string that was executed
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return The records to return
     */
    private static List<SObject> onQuery(
        String queryString,
        Map<String, Object> bindMap,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        callMap.put(queryString, true);

        if (isFailedQuery(queryString)) {
            throw new QueryException('Query failed');
        } else if (queries.containsKey(queryString)) {
            return queries.get(queryString);
        } else {
            return MockDatabase.queryWithBinds(
                queryString,
                bindMap,
                accessLevel
            );
        }
    }

    /**
     * @description The method that is called when an aggregate query is executed
     * @param queryString `String`
     * @return `List<Aggregate>`
     */
    private static List<Aggregate> onQueryAggregate(String queryString) {
        wasCalled = true;
        callMap.put(queryString, true);

        if (isFailedAggregateQuery(queryString)) {
            throw new QueryException('Query failed');
        } else if (aggregateQueries.containsKey(queryString)) {
            return aggregateQueries.get(queryString);
        } else {
            return MockDatabase.aggregateQuery(queryString);
        }
    }

    /**
     * @description The method that is called when an aggregate query is executed
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return `List<Aggregate>`
     */
    private static List<Aggregate> onQueryAggregate(
        String queryString,
        Map<String, Object> bindMap,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        callMap.put(queryString, true);

        if (isFailedAggregateQuery(queryString)) {
            throw new QueryException('Query failed');
        } else if (aggregateQueries.containsKey(queryString)) {
            return aggregateQueries.get(queryString);
        } else {
            return MockDatabase.aggregateQueryWithBinds(
                queryString,
                bindMap,
                accessLevel
            );
        }
    }

    private static Boolean isFailedAggregateQuery(String queryString) {
        return aggregateQueries.containsKey(queryString) &&
            aggregateQueries.get(queryString) == null;
    }

    private static Boolean isFailedQuery(String queryString) {
        return queries.containsKey(queryString) &&
            queries.get(queryString) == null;
    }

    private static Boolean isFailedCountQuery(String queryString) {
        return countQueries.containsKey(queryString) &&
            countQueries.get(queryString) == null;
    }
}
