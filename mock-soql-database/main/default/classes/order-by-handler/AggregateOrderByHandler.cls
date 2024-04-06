/**
 * @description Handles the ORDER BY clause for aggregate queries 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AggregateOrderByHandler extends OrderByHandler {
    /**
     * @description Constructor
     * @param options `OrderByOptions`
     */
    public AggregateOrderByHandler(OrderByOptions options) {
        super(options);
    }

    /**
     * @description Handles the ORDER BY clause for aggregate queries 
     * @return  `Object`
     */
    public override Object handleOrderBy() {
        return sortByOrderBy();
    }

    /**
     * @description Sorts the list of aggregates by the ORDER BY clause 
     * @return  `Object`
     */
    protected override Object sortByOrderBy() {
        TopLevelNodes topLevelNodes = options.getTopLevelNodes();
        List<ProtoAggregate> aggregates = (List<ProtoAggregate>) options.getObj();
        Node selectNode = topLevelNodes.selectNode;
        Node orderByNode = topLevelNodes.orderByNode;

        // clone the list so we don't modify the original
        aggregates = new List<ProtoAggregate>(aggregates);

        if(orderByNode == null) {
            return aggregates;
        }
        Node orderByField = orderByNode.left;
        
        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>>();
        while(orderByField != null) {
            String relationshipName;
            String fieldApiName;

            Map<String, String> aliasData = AliasService.getAlias(selectNode, orderByField);
            fieldApiName = aliasData.get('fieldApiName');
            relationshipName = aliasData.get('relationshipName');
            
            String nullDir = 'first';
            String order = 'asc';
            Node curr = orderByField.right;
            if(curr != null && curr.nodeType == 'direction') {
                order = orderByField.right.id;
                curr = curr.right;
            }
            if(curr != null && curr.nodeType == 'nulls direction') {
                if(curr.id == 'nulls last') {
                    nullDir = 'last';
                }
            }


            Map<String, String> fieldData = new Map<String, String> {
                'fieldApiName' => fieldApiName,
                'relationshipName' => relationshipName,
                'order' => order,
                'nullDir' => nullDir
            };
            fields.put(fieldApiName, fieldData);
            orderByField = orderByField.left;
        }
        AggregateComparator comparator = new AggregateComparator(fields);
        aggregates.sort(comparator);
        return aggregates;
    }
}