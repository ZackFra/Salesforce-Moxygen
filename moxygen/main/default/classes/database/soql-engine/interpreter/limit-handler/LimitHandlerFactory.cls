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
 * @description Used to create a limit handler based on the query type
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class LimitHandlerFactory {
    private LimitOptions options = new LimitOptions();

    Node limitNode;
    Map<String, Object> params;

    /**
     * @description Sets the type of the query
     * @param type `Types.SOQL`
     * @return  `LimitHandlerFactory`
     */
    public LimitHandlerFactory setType(Types.SOQL type) {
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

        if (
            limitSizeNode.nodeType == 'bind variable' &&
            (params == null || !params.containsKey(limitSizeNode.id))
        ) {
            throw new QueryException(
                'Missing bind variable: ' + limitSizeNode.id
            );
        }

        if (limitSizeNode.nodeType == 'bind variable') {
            return (Integer) params.get(limitSizeNode.id);
        }
        return Integer.valueOf(limitSizeNode.id);
    }

    private class LimitHandlerException extends Exception {
    }

    /**
     * @description Creates the appropriate limit handler based on the query type
     * @return  `ILimitHandler`
     * @exception LimitHandlerException
     */
    public ILimitHandler createHandler() {
        Map<String, Object> args = new Map<String, Object>{
            'type' => options.getType(),
            'limitNode' => limitNode,
            'obj' => options.getObj()
        };
        Common.nullCheck(args);

        options.setLimitSize(calculateLimitSize());

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
