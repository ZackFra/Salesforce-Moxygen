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
 * @description This class is responsible for creating the appropriate offset handler based on the query type.
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
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
     * @param type `Types.SOQL`
     * @return  `OffsetHandlerFactory`
     */
    public OffsetHandlerFactory setType(Types.SOQL type) {
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

    private class OffsetHandlerException extends Exception {
    }

    private Integer calculateOffset() {
        Node offsetSizeNode = offsetNode.left;

        if (
            offsetNode.nodeType == 'bind variable' &&
            (params == null || !params.containsKey(offsetSizeNode.id))
        ) {
            throw new QueryException(
                'Missing bind variable: ' + offsetSizeNode.id
            );
        }
        if (offsetSizeNode.nodeType == 'bind variable') {
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
        Map<String, Object> args = new Map<String, Object>{
            'obj' => options.getObj(),
            'type' => options.getType(),
            'offsetNode' => offsetNode
        };
        Common.nullCheck(args);

        options.setOffset(calculateOffset());

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
