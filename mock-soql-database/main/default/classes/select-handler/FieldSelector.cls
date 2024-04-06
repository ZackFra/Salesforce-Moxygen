/**
 * @description FieldSelector is a class that is used to select fields from a queried record based on a field node. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class FieldSelector {
    
    public SObject databaseRecord;
    public SObject queriedRecord;
    public Node fieldNode;
    public Map<String, Object> params;

    public MockDatabase db;

    /**
     * @description Setter for the `databaseRecord` property
     * @param databaseRecord 
     * @return  `FieldSelector`
     */
    public FieldSelector setDatabaseRecord(SObject databaseRecord) {
        this.databaseRecord = databaseRecord;
        return this;
    }

    /**
     * @description Setter for the `queriedRecord` property
     * @param queriedRecord 
     * @return  `FieldSelector`
     */
    public FieldSelector setQueriedRecord(SObject queriedRecord) {
        this.queriedRecord = queriedRecord;
        return this;
    }

    /**
     * @description Setter for the `fieldNode` property
     * @param fieldNode 
     * @return  `FieldSelector`
     */
    public FieldSelector setFieldNode(Node fieldNode) {
        this.fieldNode = fieldNode;
        return this;
    }

    /**
     * @description Setter for the `params` property
     * @param params 
     * @return  `FieldSelector`
     */
    public FieldSelector setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }

    /**
     * @description Setter for the `db` property 
     * @param db 
     * @return  `FieldSelector`
     */
    public FieldSelector setDatabase(MockDatabase db) {
        this.db = db;
        return this;
    }
}