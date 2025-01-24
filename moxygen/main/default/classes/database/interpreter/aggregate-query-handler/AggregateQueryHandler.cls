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
 * @description This class is responsible for handling the aggregate queries
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public inherited sharing class AggregateQueryHandler {
    TopLevelNodes topLevelNodes;

    AggregateProcessor standardProcessor;

    /**
     * @description Constructor
     * @param topLevelNodes
     * @exception AggregateQueryException
     */
    public AggregateQueryHandler(TopLevelNodes topLevelNodes) {
        this.topLevelNodes = topLevelNodes;

        Node groupByNode = topLevelNodes.groupByNode;

        if (isRollup(groupByNode)) {
            throw new AggregateQueryException(
                'GROUP BY ROLLUP is not supported'
            );
        }

        if (isCube(groupByNode)) {
            throw new AggregateQueryException('GROUP BY CUBE is not supported');
        }

        standardProcessor = new AggregateStandardProcessor()
            .setTopLevelNodes(topLevelNodes);
    }

    /**
     * @description Finish the processing of the aggregate query
     * @return  `List<ProtoAggregate>`
     */
    public List<ProtoAggregate> finish() {
        List<ProtoAggregate> finalResults = new List<ProtoAggregate>();
        finalResults.addAll(standardProcessor.finish());
        finalResults = replaceWithAliases(finalResults);
        return finalResults;
    }

    /**
     * @description Process the record
     * @param databaseRecord
     */
    public void processRecord(SObject databaseRecord) {
        standardProcessor.processRecord(databaseRecord);
    }

    /**
     * @description Exception class for Aggregate Query
     */
    public class AggregateQueryException extends Exception {
    }

    private List<ProtoAggregate> replaceWithAliases(
        List<ProtoAggregate> aggregates
    ) {
        List<ProtoAggregate> aggregateResults = new List<ProtoAggregate>(
            aggregates
        );
        Node selectNode = topLevelNodes.selectNode;

        for (ProtoAggregate aggr : aggregateResults) {
            for (
                Node currSelect = selectNode.left;
                currSelect != null;
                currSelect = currSelect.left
            ) {
                String fieldOrAliasFromSelect = AliasService.getAlias(
                        selectNode,
                        currSelect
                    )
                    .get('fieldApiName');
                for (String key : aggr.keySet()) {
                    if (
                        key.toLowerCase() == currSelect.id &&
                        key != fieldOrAliasFromSelect
                    ) {
                        aggr.put(fieldOrAliasFromSelect, aggr.get(key));
                        aggr.remove(key);
                        break;
                    }
                }
            }
        }

        return aggregateResults;
    }

    private Boolean isRollup(Node groupByNode) {
        return (groupByNode != null && groupByNode.id == 'rollup');
    }

    private Boolean isCube(Node groupByNode) {
        return (groupByNode != null && groupByNode.id == 'cube');
    }
}
