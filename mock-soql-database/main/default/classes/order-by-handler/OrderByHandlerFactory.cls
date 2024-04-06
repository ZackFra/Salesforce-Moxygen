/**
 * @description Factory class for creating OrderByHandler instances 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class OrderByHandlerFactory {
    OrderByOptions options = new OrderByOptions();
    
    private class OrderByException extends Exception {}

    /**
     * @description Setter for the type of query to be executed 
     * @param type `MockDatabase.QueryType`
     * @return  `OrderByHandlerFactory`
     */
    public OrderByHandlerFactory setType(MockDatabase.QueryType type) {
        options.setType(type);
        return this;
    }

    /**
     * @description Setter for the object to be queried 
     * @param obj `List<ProtoAggregate> | List<SObject>`
     * @return  `OrderByHandlerFactory`
     */
    public OrderByHandlerFactory setObj(Object obj) {
        options.setObj(obj);
        return this;
    }

    /**
     * @description Setter for the top level nodes of the query
     * @param topLevelNodes `TopLevelNodes`
     * @return  `OrderByHandlerFactory`
     */
    public OrderByHandlerFactory setTopLevelNodes(TopLevelNodes topLevelNodes) {
        options.setTopLevelNodes(topLevelNodes);
        return this;
    }

    /**
     * @description Create a new instance of the OrderByHandler class
     * @return  `OrderByHandler`
     * @exception OrderByException
     */
    public OrderByHandler createHandler() {
        Map<String, Object> args = new Map<String, Object> {
            'type' => options.getType(),
            'obj' => options.getObj(),
            'topLevelNodes' => options.getTopLevelNodes()
        };
        Common.nullCheck(args);

        MockDatabase.QueryType type = options.getType();
        switch on type {
            when RECORD {
                return new RecordOrderByHandler(options);
            }
            when AGGREGATE {
                return new AggregateOrderByHandler(options);
            }
            when else {
                throw new OrderByException('Unsupported OrderByOptions type');
            }
        }
    }
}