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
 * @description Contains static methods for working with aggregates and proto-aggregates
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.CyclomaticComplexity, PMD.StdCyclomaticComplexity')
public inherited sharing class AggregateService {

    public final static List<String> SUPPORTED_NUMERIC_FUNCS = new List<String> {
        'avg',
        'count',
        'count_distinct',
        'min',
        'max',
        'sum'
    };

    public final static List<String> SUPPORTED_DATE_FUNCS = new List<String> {
        'calendar_month',
        'calendar_year'
    };

    @SuppressWarnings('PMD.PropertyNamingConventions')
    public final static List<String> SUPPORTED_AGGREGATE_FUNCS {
        get {
            List<String> supportedAggregateFuncs = new List<String>();
            supportedAggregateFuncs.addAll(SUPPORTED_NUMERIC_FUNCS);
            supportedAggregateFuncs.addAll(SUPPORTED_DATE_FUNCS);
            return supportedAggregateFuncs;
        }
    }

    /**
     * @description Returns whether this function is a date function
     * @param nodeType `String`
     * @param nodeId `String`
     * @return  `Boolean`
     */
    public static Boolean isDateFunc(String nodeType, String nodeId) {
        if(nodeType != 'aggregate function') {
            return false;
        }
        return SUPPORTED_DATE_FUNCS.contains(nodeId);
    }

    /**
     * @description Returns whether this function is a numeric function
     * @param nodeType `String`
     * @param nodeId `String`
     * @return  `Boolean`
     */
    public static Boolean isNumericFunc(String nodeType, String nodeId) {
        if(nodeType != 'aggregate function') {
            return false;
        }
        return SUPPORTED_NUMERIC_FUNCS.contains(nodeType);
    }

    /**
     * @description Returns whether the node is an aggregate function 
     * @param nodeType `String`
     * @param nodeId `String`
     * @return  `Boolean`
     */
    public static Boolean isAggregateFunc(String nodeType, String nodeId) {
        return isNumericFunc(nodeType, nodeId) || isDateFunc(nodeType, nodeId);
    }

    /**
     * @description : given the top level nodes, return a map with the fields to group by and the fields to select
     * @param topLevelNodes : the top level nodes of the query
     * @return : a map with the fields to group by and the fields to select
     */
    @SuppressWarnings('PMD.CyclomaticComplexity, PMD.CognitiveComplexity, PMD.StdCyclomaticComplexity, PMD.NcssMethodCount')
    public static Map<String, List<String>> getAggregateFields(TopLevelNodes topLevelNodes) {
        Node selectNode = topLevelNodes.selectNode;
        Node groupByNode = topLevelNodes.groupByNode;

        if(groupByNode == null) {
            return new Map<String, List<String>> {
                'groupByFields' => new List<String>(),
                'selectFields' => new List<String>()
            };
        }
        List<String> groupByFields = new List<String>();
        List<String> selectFields = new List<String>();

        if(groupByNode != null) {
            Node currGroupByNode = groupByNode.left;
            while(currGroupByNode != null) {
                if(isDateFunc(currGroupByNode.nodeType, currGroupByNode.id)) {
                    groupByFields.add(currGroupByNode.right.id);
                } else if(isAggregateFunc(currGroupByNode.nodeType, currGroupByNode.id) && !isDateFunc(currGroupByNode.nodeType, currGroupByNode.id)) {
                    throw new QueryException('Only date aggregate functions are allowed as grouping expressions: ' + currGroupByNode.id);
                } else {
                    groupByFields.add(currGroupByNode.id); 
                }
                currGroupByNode = currGroupByNode.left;
            }
        }

        Node currSelectNode = selectNode.left;
        Set<String> aliases = new Set<String>();
        while(currSelectNode != null) {
            // begin with error-handling for the aggregate query

            if(currSelectNode.nodeType == 'field') {
                // check that selected fields are grouped or aggregated
                if(!groupByFields.contains(currSelectNode.id)) {
                    throw new QueryException('Field must be grouped or aggregated: ' + currSelectNode.id);
                }

                // check for duplicate aliases
                Node aliasNode = currSelectNode.right;
                String alias;
                if(aliasNode != null) {
                    alias = aliasNode.id;
                } else if(currSelectNode.id.contains('.')){
                    List<String> aliasParts = currSelectNode.id.split('\\.');
                    alias = aliasParts[aliasParts.size()-1];
                } else {
                    alias = currSelectNode.id;
                }

                Integer initAliasSize = aliases.size();
                aliases.add(alias);
                
                if(initAliasSize == aliases.size()) {
                    throw new QueryException('Duplicate alias: ' + alias);
                }

                selectFields.add(currSelectNode.id);
            } else if(currSelectNode.nodeType == 'aggregate function') {
                // check that aggregated fields are not grouped
                Node fieldNode = currSelectNode.right;
                if(groupByFields.contains(fieldNode.id) && !isDateFunc(currSelectNode.nodeType, currSelectNode.id)) {
                    throw new QueryException('Grouped field should not be aggregated: ' + fieldNode.id);
                }
            }
            currSelectNode = currSelectNode.left;
        }
        
        Map<String, List<String>> aggregateFields = new Map<String, List<String>> {
            'groupByFields' => groupByFields,
            'selectFields' => selectFields
        };
        return aggregateFields;
    }
}