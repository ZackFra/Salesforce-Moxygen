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
}