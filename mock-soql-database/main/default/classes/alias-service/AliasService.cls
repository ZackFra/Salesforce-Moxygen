/**
 * @description Tool for finding the aliases on nodes
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AliasService {
    /**
     * @description Get the field alias 
     * @param curr 
     * @param fieldNode 
     * @param selectNode 
     * @return  `Map<String, String>`
     */
    public static Map<String, String> getFieldAlias(Node curr, Node fieldNode, Node selectNode) {
        Node aliasNode = curr.right;
        String fieldApiName;
        String relationshipName;
        if(aliasNode != null) {
            fieldApiName = aliasNode.id;
            relationshipName = null;
        } else {
            Map<String, Object> comparables = ComparableService.getComparableDataFromNodes(fieldNode, selectNode);
            relationshipName = (String) comparables.get('relationshipName');
            fieldApiName = (String) comparables.get('comparableField');
        }

        return new Map<String, String> {
            'fieldApiName' => fieldApiName,
            'relationshipName' => relationshipName
        };       
    }

    private static Map<String, String> getAggrFuncAlias(Node curr, Integer exprNumber) {
        Node aggrFieldNode = curr.right;
        Node aliasNode = aggrFieldNode.left;
        String fieldApiName;
        if(aliasNode != null) {
            fieldApiName = aliasNode.id;
        } else {
            fieldApiName = 'expr' + exprNumber;
        }

        return new Map<String, String> {
            'fieldApiName' => fieldApiName,
            'relationshipName' => null
        };
    }
    /**
     * @description Get the alias for a field node
     * @param selectNode 
     * @param fieldNode 
     * @return  `Map<String, String>`
     * @exception 
     */
    public static Map<String, String> getAlias(Node selectNode, Node fieldNode) {
        Integer exprNumber = 0;

        Node curr = selectNode.left;
        while(curr != null) {
            Boolean isField = (curr.nodeType == 'field');
            Boolean isSameId = (curr.id == fieldNode.id);
            
            Boolean isAggregateFunc = (curr.nodeType == 'aggregate function');
            Boolean isSameAggrField = (isAggregateFunc && curr.right.id == fieldNode?.right?.id);

            if(isField && isSameId) {
                return getFieldAlias(curr, fieldNode, selectNode);
            } else if(isAggregateFunc && isSameAggrField && isSameId) {
                return getAggrFuncAlias(curr, exprNumber);
            } else if(isAggregateFunc) {
                exprNumber++;
            }
            curr = curr.left;
        }
        throw new QueryException('No alias found');
    }
}