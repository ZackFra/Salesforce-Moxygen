/**
 * @description The options to be passed into an ILimitHandler
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class LimitOptions {
    public Integer limitSize;
    public MockDatabase.QueryType type;
    public Object obj;

    /**
     * @description Setter for the type of query 
     * @param type `MockDatabase.QueryType`
     * @return  `LimitOptions`
     */
    public LimitOptions setType(MockDatabase.QueryType type) {
        this.type = type;
        return this;
    }

    /**
     * @description Getter for the type of query
     * @return  `MockDatabase.QueryType`
     */
    public MockDatabase.QueryType getType() {
        return this.type;
    }

    /**
     * @description Sets the object to be used in the query
     * @param obj `List<ProtoAggregate> | List<SObject> | Integer`
     * @return  `LimitOptions`
     */
    public LimitOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Getter for the object to be used in the query 
     * @return  `Object`
     */
    public Object getObj() {
        return this.obj;
    }

    /**
     * @description Setter for the limit size
     * @param limitSize `Integer`
     * @return  `LimitOptions`
     */
    public LimitOptions setLimitSize(Integer limitSize) {
        this.limitSize = limitSize;
        return this;
    }

    /**
     * @description Getter for the limit size 
     * @return  `Integer`
     */
    public Integer getLimitSize() {
        return this.limitSize;
    }
}