/**
 * @description Contains static methods for working with aggregates and proto-aggregates
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.CyclomaticComplexity, PMD.StdCyclomaticComplexity')
public with sharing class AggregateService {

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
                groupByFields.add(currGroupByNode.id);
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
                if(groupByFields.contains(fieldNode.id)) {
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