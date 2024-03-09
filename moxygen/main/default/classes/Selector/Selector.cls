/**
 * @description Wrapper class for Database class 
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public inherited sharing class Selector implements ISelector {
    /**
     * @description Query for a list of sObjects
     * @param queryString `String`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String queryString) {
        return Database.query(queryString);
    }

    /**
     * @description Query for a list of sObjects
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String queryString, System.AccessLevel accessLevel) {
        return Database.query(queryString, accessLevel);
    }

    /**
     * @description Query for a list of sObjects with bind variables
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return Database.queryWithBinds(queryString, bindMap, accessLevel);
    }

    /**
     * @description Count the number of records returned by a query
     * @param queryString `String`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> queryAggregate(String queryString) {
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
    public List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel) {
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
    public List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        List<AggregateResult> arList = Database.queryWithBinds(queryString, bindMap, accessLevel);
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
    public Integer countQuery(String queryString) {
        return Database.countQuery(queryString);
    }

    /**
     * @description Count the number of records returned by a query
     * @param queryString `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQuery(String queryString, System.AccessLevel accessLevel) {
        return Database.countQuery(queryString, accessLevel);
    }
    
    /**
     * @description Count the number of records returned by a query
     * @param queryString `String`
     * @param bindMap `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQueryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return Database.countQueryWithBinds(queryString, bindMap, accessLevel);
    }
}