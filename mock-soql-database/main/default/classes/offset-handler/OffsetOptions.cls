/**
 * @description Options class for the Offset class 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class OffsetOptions {
    public Integer offset;
    public MockDatabase.QueryType type;
    public Object obj;

    /**
     * @description Sets the offset value for the query
     * @param offset `Integer`
     * @return  `OffsetOptions`
     */
    public OffsetOptions setOffset(Integer offset) {
        this.offset = offset;
        return this;
    }

    /**
     * @description Getter for the offset value 
     * @return  `Integer`
     */
    public Integer getOffset() {
        return this.offset;
    }

    /**
     * @description Setter for the type of query 
     * @param type `MockDatabase.QueryType`
     * @return  `OffsetOptions`
     */
    public OffsetOptions setType(MockDatabase.QueryType type) {
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
     * @description Setter for the object to be used in the query 
     * @param obj `List<ProtoAggregate> | List<SObject> | Integer`
     * @return  `OffsetOptions`
     */
    public OffsetOptions setObj(Object obj) {
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
}