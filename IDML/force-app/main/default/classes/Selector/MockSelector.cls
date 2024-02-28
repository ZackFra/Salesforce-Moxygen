@IsTest
public inherited sharing class MockSelector implements ISelector {
    Map<String, List<SObject>> queries = new Map<String, List<SObject>>();

    public MockSelector registerQuery(String queryString, List<SObject> records) {
        queries.put(queryString, records);
        return this;
    }

    public List<SObject> query(String queryString) {
        if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        }
        return new List<SObject>();
    }
    public List<SObject> query(String queryString, System.AccessLevel accessLevel) {
        if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        }
        return new List<SObject>();
    }
    public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel) {
        if(queries.containsKey(queryString)) {
            return queries.get(queryString);
        }
        return new List<SObject>();
    }
}