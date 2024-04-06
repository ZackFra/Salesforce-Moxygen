/**
 * @description Order by handler for record data 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class RecordOrderByHandler extends OrderByHandler {
    /**
     * @description Constructor for RecordOrderByHandler
     * @param options `OrderByOptions`
     */
    public RecordOrderByHandler(OrderByOptions options) {
        super(options);
    }

    /**
     * @description Handles the order by clause for record data 
     * @return  `Object`
     */
    public override Object handleOrderBy() {
        return sortByOrderBy();
    }

    /**
     * @description Sorts the records by the order by clause 
     * @return  `Object`
     */
    protected override Object sortByOrderBy() {
        TopLevelNodes topLevelNodes = options.getTopLevelNodes();
        Node orderByNode = topLevelNodes.orderByNode;
        Node selectNode = topLevelNodes.selectNode;
        List<SObject> sObjects = (List<SObject>) options.getObj();

        // clone the list so we don't modify the original
        sObjects = new List<SObject>(sObjects);

        if(orderByNode == null) {
            return sObjects;
        }
        Node orderByField = orderByNode.left;

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>>();
        while(orderByField != null) {
            String fieldName = orderByField.id;
            Map<String, Object> comparables = ComparableService.getComparableDataFromNodes(orderByField, selectNode);
            String relationshipName = (String) comparables.get('relationshipName');
            String fieldApiName = (String) comparables.get('comparableField');

            String order = 'asc';
            String nullDir = 'first';
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
            fields.put(fieldName, fieldData);
            orderByField = orderByField.left;
        }
        SObjectComparator comparator = new SObjectComparator(fields);
        sObjects.sort(comparator);
        return sObjects;
    }
}