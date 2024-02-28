public interface ISelector {
    List<SObject> query(String queryString);
    List<SObject> query(String queryString, System.AccessLevel accessLevel);
    List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);
}