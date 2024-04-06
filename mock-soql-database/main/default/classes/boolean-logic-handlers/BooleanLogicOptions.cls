/**
 * @description This class is used to store the options for the BooleanLogic class 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class BooleanLogicOptions {

    /** 
     * @description Parameters for bind variables in the query
     */
    public Map<String, Object> params;

    /**
     * @description The object being compared (either SObject or Aggregate)
     */
    public Object obj;

    /**
     * @description The head conditional node
     */
    public Node head;

    /**
     * @description The database to use for queries
     */
    public MockDatabase db;

    /**
     * @description The select node to compare against
     */
    public Node selectNode;

    /**
     * @description Setter for `params`
     * @param params 
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }

    /**
     * @description Setter for `db` 
     * @param db 
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setDatabase(MockDatabase db) {
        this.db = db;
        return this;
    }

    /**
     * @description Setter for `obj` 
     * @param obj 
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Setter for `head` node 
     * @param head 
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setHead(Node head) {
        this.head = head;
        return this;
    }

    /**
     * @description Setter for `selectNode`
     * @param selectNode 
     * @return  `BooleanLogicOptions`
     */
    public BooleanLogicOptions setSelectNode(Node selectNode) {
        this.selectNode = selectNode;
        return this;
    }

}