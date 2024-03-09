/**
 * @description Interface for the Selector class, which is used to query the database 
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public interface ISelector {
    /**
     * @description Queries the database and returns a list of SObjects
     * @param queryString `String` The query string to be executed
     * @return  `List<SObject>`
     */
    List<SObject> query(String queryString);

    /**
     * @description Queries the database and returns a list of SObjects
     * @param queryString `String` The query string to be executed
     * @param accessLevel Access level to be used for the query
     * @return  `List<SObject>`
     */
    List<SObject> query(String queryString, System.AccessLevel accessLevel);

    /**
     * @description Queries the database and returns a list of SObjects, with bind variables
     * @param queryString `String` The query string to be executed
     * @param bindMap The bind variables to be used in the query
     * @param accessLevel Access level to be used for the query
     * @return  `List<SObject>`
     */
    List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
    
    /**
     * @description Queries the database and returns a list of Aggregates
     * @param queryString `String` The query string to be executed
     * @return  `List<Aggregate>`
     */
    List<Aggregate> queryAggregate(String queryString);

    /**
     * @description Queries the database and returns a list of Aggregates
     * @param queryString `String` The query string to be executed
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `List<Aggregate>`
     */
    List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel);

    /**
     * @description Queries the database and returns a list of Aggregates, with bind variables
     * @param queryString `String` The query string to be executed
     * @param bindMap `Map<String, Object>` The bind variables to be used in the query
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `List<Aggregate>`
     */
    List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);

    /**
     * @description `countQuery` Queries the database and returns the number of records returned
     * @param queryString `String` The query string to be executed
     * @return  `Integer`
     */
    Integer countQuery(String queryString);

    /**
     * @description Queries the database and returns the number of records returned
     * @param queryString `String` The query string to be executed
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `Integer`
     */
    Integer countQuery(String queryString, System.AccessLevel accessLevel);

    /**
     * @description Queries the database and returns the number of records returned, with bind variables
     * @param queryString `String` The query string to be executed
     * @param bindMap `Map<String, Object>` The bind variables to be used in the query
     * @param accessLevel `System.AccessLevel` Access level to be used for the query
     * @return  `Integer`
     */
    Integer countQueryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
}