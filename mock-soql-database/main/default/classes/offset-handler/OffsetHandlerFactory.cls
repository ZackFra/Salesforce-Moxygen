/**
 * @description This class is responsible for creating the appropriate offset handler based on the query type.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class OffsetHandlerFactory {
    OffsetOptions options = new OffsetOptions();
    
    Node offsetNode;
    Map<String, Object> params;

    /**
     * @description Setter for the offset node
     * @param offsetNode `Node`
     * @return  `OffsetHandlerFactory`
     */
    public OffsetHandlerFactory setOffsetNode(Node offsetNode) {
        this.offsetNode = offsetNode;
        return this;
    }

    /**
     * @description Setter for the bind parameters
     * @param params `Map<String, Object>`
     * @return  `OffsetHandlerFactory`
     */
    public OffsetHandlerFactory setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }

    /**
     * @description Setter for the query type 
     * @param type `MockDatabase.QueryType`
     * @return  `OffsetHandlerFactory`
     */
    public OffsetHandlerFactory setType(MockDatabase.QueryType type) {
        this.options.setType(type);
        return this;
    }

    /**
     * @description Setter for the offsetted object
     * @param obj `List<ProtoAggregate> | List<SObject> | Integer`
     * @return  `OffsetHandlerFactory`
     */
    public OffsetHandlerFactory setObj(Object obj) {
        this.options.setObj(obj);
        return this;
    }

    private class OffsetHandlerException extends Exception {}


    private Integer calculateOffset() {
        Node offsetSizeNode = offsetNode.left;
    
        if(offsetNode.nodeType == 'bind variable' && (params == null || !params.containsKey(offsetSizeNode.id))) {
            throw new QueryException('Missing bind variable: ' + offsetSizeNode.id);
        }
        if(offsetSizeNode.nodeType == 'bind variable') {
            return (Integer) params.get(offsetSizeNode.id);
        }
        return Integer.valueOf(offsetSizeNode.id);
    }

    /**
     * @description Creates an offset handler 
     * @return  `IOffsetHandler`
     * @exception OffsetHandlerException
     */
    public IOffsetHandler createHandler() {
        Map<String, Object> args = new Map<String, Object> {
            'obj' => options.getObj(),
            'type' => options.getType(),
            'offsetNode' => offsetNode
        };
        Common.nullCheck(args);

        options.setOffset(
            calculateOffset()
        );

        switch on options.type {
            when RECORD {
                return new RecordOffsetHandler(options);
            }
            when COUNT {
                return new CountOffsetHandler(options);
            }
            when Aggregate {
                return new AggregateOffsetHandler(options);
            }
            when else {
                throw new OffsetHandlerException('Invalid type of query');
            }

        }
    }
}