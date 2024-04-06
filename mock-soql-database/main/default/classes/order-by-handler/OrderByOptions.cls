/**
 * @description Options class for OrderBy 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class OrderByOptions {
    private Object obj;
    private TopLevelNodes topLevelNodes;
    private MockDatabase.QueryType type;

    /**
     * @description Getter for the type of query 
     * @return  `MockDatabase.QueryType`
     */
    public MockDatabase.QueryType getType() {
        return type;
    }

    /**
     * @description Setter for the type of query 
     * @param type `MockDatabase.QueryType`
     * @return  `OrderByOptions`
     */
    public OrderByOptions setType(MockDatabase.QueryType type) {
        this.type = type;
        return this;
    }
    
    /**
     * @description Setter for the object to be queried 
     * @param obj `List<ProtoAggreate> | List<SObject>`
     * @return  `OrderByOptions`
     */
    public OrderByOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Getter for the object to be ordered 
     * @return  `Object`
     */
    public Object getObj() {
        return obj;
    }

    /**
     * @description Setter for the top level nodes
     * @param topLevelNodes `TopLevelNodes`
     * @return  `OrderByOptions`
     */
    public OrderByOptions setTopLevelNodes(TopLevelNodes topLevelNodes) {
        this.topLevelNodes = topLevelNodes;
        return this;
    }

    /**
     * @description Getter for the top level nodes
     * @return  `TopLevelNodes`
     */
    public TopLevelNodes getTopLevelNodes() {
        return topLevelNodes;
    }
}