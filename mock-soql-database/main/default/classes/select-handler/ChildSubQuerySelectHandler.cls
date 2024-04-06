/**
 * @description Child subquery select handler
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class ChildSubQuerySelectHandler implements ISelectHandler {
    FieldSelector fSelector;

    /**
     * @description Constructor
     * @param fSelector 
     */
    public ChildSubQuerySelectHandler(FieldSelector fSelector) {
        Map<String, Object> args = new Map<String, Object> {
            'fSelector' => fSelector
        };
        Common.nullCheck(args);
        this.fSelector = fSelector;
    }

    /**
     * @description Handle the select 
     * @return  `SObject`
     * @exception QueryException
     */
    @SuppressWarnings('PMD.NcssMethodCount')
    public SObject handleSelect() {
        SObject queriedRecord = fSelector.queriedRecord;
        Node fieldNode = fSelector.fieldNode;
        Map<String, Object> params = fSelector.params;
        MockDatabase db = fSelector.db;

        String objApiName = SchemaService.getSObjectName(queriedRecord);
        Node subquerySelectNode = fieldNode.right;
        Node subqueryFromNode = subquerySelectNode.right;

        Node subqueryObjNode = subqueryFromNode.left;
        String subqueryChildRelationshipName = subqueryObjNode.id;

        Schema.SObjectType childObjectType = SchemaService.getSObjectType(objApiName);
        List<Schema.ChildRelationship> childRelationships = SchemaService.getChildRelationships(childObjectType);

        Schema.ChildRelationship subqueryChildRelationship = null;
        for (Schema.ChildRelationship childRelationship : childRelationships) {
            if(!SchemaService.isChildRelationship(childRelationship, subqueryChildRelationshipName)) {
                continue;
            }
            subqueryChildRelationship = childRelationship;
            break;
        }

        if(subqueryChildRelationship == null) {
            throw new QueryException('Invalid relationship name: ' + subqueryChildRelationshipName);
        }

        String subQueryObjName = SchemaService.getChildRelationshipChildSObjectName(subQueryChildRelationship);
        String subQueryFieldName = SchemaService.getChildRelationshipFieldName(subQueryChildRelationship);
        subqueryChildRelationshipName = SchemaService.getChildRelationshipName(subQueryChildRelationship);

        // clone the tree so we can modify it
        Node subqueryCloneSelectNode = subQuerySelectNode.deepClone();
        TopLevelNodes subqueryCloneTopLevelNodes = new TopLevelNodes(subqueryCloneSelectNode);

        Node subqueryCloneFromNode = subqueryCloneTopLevelNodes.fromNode;
        Node subqueryCloneWhereNode = subqueryCloneTopLevelNodes.whereNode;

        subqueryCloneFromNode.left.id = subqueryObjName.toLowerCase();
        if(subqueryCloneWhereNode == null) {
            subqueryCloneWhereNode = new NodeBuilder()
                .setId('where')
                .setNodeType('where')
                .build();
            
            // need to account for something being to the right of the from node
            Node usingScopeNode = subqueryCloneTopLevelNodes.usingScopeNode;
            if(usingScopeNode != null) {
                Node nodeToRightOfUsingScopeNode = usingScopeNode.right;
                usingScopeNode.right = subqueryCloneWhereNode;
                subqueryCloneWhereNode.right = nodeToRightOfUsingScopeNode;
            } else {
                Node nodeToRightOfFromNode = subqueryCloneFromNode.right;
                subqueryCloneFromNode.right = subqueryCloneWhereNode;
                subqueryCloneWhereNode.right = nodeToRightOfFromNode;
            }
        }

        Node queryConditionNode = new NodeBuilder()
            .setId('=')
            .setNodeType('operator')
            .setLeft(new NodeBuilder()
                .setId(subQueryFieldName.toLowerCase())
                .setNodeType('field')
                .build())
            .setRight(new NodeBuilder()
                .setId(((String) queriedRecord.Id).toLowerCase())
                .setNodeType('string')
                .build())
            .build();

        if(subqueryCloneWhereNode.left == null) {
            subqueryCloneWhereNode.left = queryConditionNode;
        } else {
            subqueryCloneWhereNode.left = new NodeBuilder()
                .setId('and')
                .setNodeType('and')
                .setLeft(queryConditionNode)
                .setRight(subqueryCloneWhereNode.left)
                .build();
        }

        List<SObject> subQueryRecords = (List<SObject>) db.doQuery(subqueryCloneSelectNode, params);

        // so we can't mock the subquery results directly, but we can serialize them and then deserialize them
        // here we serialize the subquery results, which can't be instaniated,
        // then deserialize them into a map, then add the map to the parent object
        Map<String, Object> objMap = SObjectService.mapFromSObject(queriedRecord);
        Map<String, Object> subQueryResultMap = new Map<String, Object>();
        
        subQueryResultMap.put('records', subQueryRecords);
        subQueryResultMap.put('totalSize', subQueryRecords.size());
        subQueryResultMap.put('done', true);

        objMap.put(subQueryChildRelationshipName, subQueryResultMap);

        return SObjectService.sObjectFromMap(objMap, ObjApiName);
    }
}