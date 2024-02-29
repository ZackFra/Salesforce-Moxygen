public interface ISelector {
    List<SObject> query(String queryString);
    List<SObject> query(String queryString, System.AccessLevel accessLevel);
    List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
    
    List<Aggregate> queryAggregate(String queryString);
    List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel);
    List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);

    Integer countQuery(String queryString);
    Integer countQuery(String queryString, System.AccessLevel accessLevel);
    Integer countQueryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
}