/**
 * @description This class is response for handling SOQL queries to the mock database
 * @author Zackary Frazier
 * @since 4/13/2024
 * @group Soql Engine
 */
public with sharing class SoqlEngine {
    MockRecordQueryHandler recordQueryHandler = new MockRecordQueryHandler();
    MockCountQueryHandler countQueryHandler = new MockCountQueryHandler();
    MockAggregateQueryHandler aggregateQueryHandler = new MockAggregateQueryHandler();

    /**
     * @description Query the database for records
     * @param query `String`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String query) {
        return recordQueryHandler.query(query);
    }

    /**
     * @description Query the database for records, with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> query(String query, System.AccessLevel accessLevel) {
        return recordQueryHandler.query(query, accessLevel);
    }

    /**
     * @description Query the database for records, with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public List<SObject> queryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return recordQueryHandler.queryWithBinds(query, binds, accessLevel);
    }

    /**
     * @description Perform a count query
     * @param query `String`
     * @return  `Integer`
     */
    public Integer countQuery(String query) {
        return countQueryHandler.countQuery(query);
    }

    /**
     * @description Perform a count query with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQuery(String query, System.AccessLevel accessLevel) {
        return countQueryHandler.countQuery(query, accessLevel);
    }

    /**
     * @description Perform a count query with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public Integer countQueryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return countQueryHandler.countQueryWithBinds(query, binds, accessLevel);
    }

    /**
     * @description Perform an aggregate query
     * @param query `String`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> aggregateQuery(String query) {
        return aggregateQueryHandler.aggregateQuery(query);
    }

    /**
     * @description Perform an aggregate query with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> aggregateQuery(
        String query,
        System.AccessLevel accessLevel
    ) {
        return aggregateQueryHandler.aggregateQuery(query, accessLevel);
    }

    /**
     * @description Perform an aggregate query with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public List<Aggregate> aggregateQueryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return aggregateQueryHandler.aggregateQueryWithBinds(
            query,
            binds,
            accessLevel
        );
    }

    /**
     * @description Internal, do not use this method
     * @param head `Node`
     * @param params `Map<String, Object>`
     * @return  `List<SObject>`
     */
    public List<SObject> doSelectQueryInternal(
        Node head,
        Map<String, Object> params
    ) {
                   return recordQueryHandler.doQuery(head, params);
    }
}
