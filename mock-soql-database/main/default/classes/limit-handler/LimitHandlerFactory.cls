/**
 * @description Used to create a limit handler based on the query type
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class LimitHandlerFactory {

    private LimitOptions options = new LimitOptions();

    Node limitNode;
    Map<String, Object> params;

    /**
     * @description Sets the type of the query 
     * @param type `MockDatabase.QueryType`
     * @return  `LimitHandlerFactory`
     */
    public LimitHandlerFactory setType(MockDatabase.QueryType type) {
        options.setType(type);
        return this;
    }

    /**
     * @description Sets the object to which the limit is applied
     * @param obj `List<ProtoAggregate> | List<SObject> | Integer`
     * @return  `LimitHandlerFactory`
     */
    public LimitHandlerFactory setObj(Object obj) {
        options.setObj(obj);
        return this;
    }

    /**
     * @description Sets the limit node
     * @param limitNode `Node`
     * @return  `LimitHandlerFactory`
     */
    public LimitHandlerFactory setLimitNode(Node limitNode) {
        this.limitNode = limitNode;
        return this;
    }

    /**
     * @description Sets the params for a queryWithBinds call
     * @param params `Map<String, Object>`
     * @return  `LimitHandlerFactory`
     */
    public LimitHandlerFactory setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }

    private Integer calculateLimitSize() {
        Node limitSizeNode = limitNode.left;

        if(limitSizeNode.nodeType == 'bind variable' && (params == null || !params.containsKey(limitSizeNode.id))) {
            throw new QueryException('Missing bind variable: ' + limitSizeNode.id);
        }

        if(limitSizeNode.nodeType == 'bind variable') {
            return (Integer) params.get(limitSizeNode.id);
        }
        return Integer.valueOf(limitSizeNode.id);      
    }

    private class LimitHandlerException extends Exception {}

    /**
     * @description Creates the appropriate limit handler based on the query type 
     * @return  `ILimitHandler`
     * @exception LimitHandlerException
     */
    public ILimitHandler createHandler() {
        Map<String, Object> args = new Map<String, Object> {
            'type' => options.getType(),
            'limitNode' => limitNode,
            'obj' => options.getObj()
        };
        Common.nullCheck(args);

        options.setLimitSize(
            calculateLimitSize()
        );

        switch on options.type {
            when RECORD {
                return new RecordLimitHandler(options);
            }
            when AGGREGATE {
                return new AggregateLimitHandler(options);
            }
            when COUNT {
                return new CountLimitHandler(options);
            }
            when else {
                throw new LimitHandlerException('Unsupported limit type');
            }
        }
    }
}