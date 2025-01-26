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
 * @description Creates Aggregate objects from ProtoAggregates
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Utilities
 */
public with sharing class AggregateBuilder {
    List<ProtoAggregate> protoAggregates;
    TopLevelNodes topLevelNodes;
    Map<String, Object> params;

    /**
     * @description Setter for proto-aggregates
     * @param protoAggregates the proto-aggregates
     * @return the aggregate builder
     */
    public AggregateBuilder setProtoAggregates(
        List<ProtoAggregate> protoAggregates
    ) {
        this.protoAggregates = protoAggregates;
        return this;
    }

    /**
     * @description sets the top level nodes
     * @param topLevelNodes the top level nodes
     * @return the aggregate builder
     */
    public AggregateBuilder setTopLevelNodes(TopLevelNodes topLevelNodes) {
        this.topLevelNodes = topLevelNodes;
        return this;
    }

    /**
     * @description sets the params
     * @param params the bind params
     * @return the aggregate builder
     */
    public AggregateBuilder setParams(Map<String, Object> params) {
        this.params = params;
        return this;
    }

    /**
     * @description Remove the fields that are not in the select clause
     * @return The cleaned up aggregate result list
     */
    public List<Aggregate> build() {
        // get list of all fields to group by, if is aggregate query
        Map<String, List<String>> aggregateFields = AggregateService.getAggregateFields(
            topLevelNodes
        );
        List<String> groupByFields = aggregateFields.get('groupByFields');
        List<String> selectFields = aggregateFields.get('selectFields');

        List<Aggregate> aggregateResultsList = new List<Aggregate>();
        for (Integer i = 0; i < protoAggregates.size(); i++) {
            ProtoAggregate ar = protoAggregates[i];

            ar = cleanUpAggregateResult(ar, groupByFields, selectFields);
            Aggregate arp = new Aggregate(ar.getPrototype());
            aggregateResultsList.add(arp);
        }
        return aggregateResultsList;
    }

    private ProtoAggregate cleanUpAggregateResult(
        ProtoAggregate aggr,
        List<String> groupByFields,
        List<String> selectFields
    ) {
        aggr = aggr.clone();

        // remove any fields that are grouped by, but not selected
        for (String groupByField : groupByFields) {
            if (selectFields.contains(groupByField)) {
                continue;
            }

            for (String key : aggr.keySet()) {
                if (key.toLowerCase() == groupByField) {
                    aggr.remove(key);
                }
            }
        }

        // remove the internal fields used for COUNT_DISTINCT and AVG
        for (String key : aggr.keySet()) {
            Boolean isAvg = key.endsWith('__n');
            Boolean isDistinct = key.endsWith('__distinct');
            if (isAvg || isDistinct) {
                aggr.remove(key);
            }
        }
        return aggr;
    }
}
