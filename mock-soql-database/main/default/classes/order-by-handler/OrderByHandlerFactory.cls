/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

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