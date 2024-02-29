public inherited sharing class Selector implements ISelector {
    public List<SObject> query(String queryString) {
        return Database.query(queryString);
    }

    public List<SObject> query(String queryString, System.AccessLevel accessLevel) {
        return Database.query(queryString, accessLevel);
    }

    public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        return Database.queryWithBinds(queryString, bindMap, accessLevel);
    }

    public List<Aggregate> queryAggregate(String queryString) {
        List<AggregateResult> arList = Database.query(queryString);
        List<Aggregate> agList = new List<Aggregate>();
        for (AggregateResult ar : arList) {
            agList.add(new Aggregate(ar));
        }
        return agList;
    }

    public List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel) {
        List<AggregateResult> arList = Database.query(queryString, accessLevel);
        List<Aggregate> agList = new List<Aggregate>();
        for (AggregateResult ar : arList) {
            agList.add(new Aggregate(ar));
        }
        return agList;
    }

    public List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        List<AggregateResult> arList = Database.queryWithBinds(queryString, bindMap, accessLevel);
        List<Aggregate> agList = new List<Aggregate>();
        for (AggregateResult ar : arList) {
            agList.add(new Aggregate(ar));
        }
        return agList;
    }
}