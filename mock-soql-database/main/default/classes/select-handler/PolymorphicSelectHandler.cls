/**
 * @description Select handler for TYPEOF operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public with sharing class PolymorphicSelectHandler implements ISelectHandler {
    private FieldSelector fSelector;

    /**
     * @description Constructor
     * @param fSelector 
     */
    public PolymorphicSelectHandler(FieldSelector fSelector) {
        this.fSelector = fSelector;
    }

    /**
     * @description Handles the TYPEOF operator in a SELECT statement 
     * @return  `SObject`
     * @exception QueryException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity, PMD.NcssMethodCount')
    public SObject handleSelect() {
        SObject databaseRecord = fSelector.databaseRecord;
        SObject queriedRecord = fSelector.queriedRecord;
        Node fieldNode = fSelector.fieldNode;
        MockDatabase db = fSelector.db;

        if(fieldNode.nodeType != 'typeof') {
            throw new QueryException('Unexpected error');
        }

        Node whenNode = fieldNode.right;
        String relName = fieldNode.id;

        Schema.SObjectType sot = SchemaService.getSObjectType(queriedRecord);
        String fieldApiName = SchemaService.getFieldNameForRelationship(sot, relName);
        String objApiName = SchemaService.getSObjectName(queriedRecord);
        Schema.SObjectField field = SchemaService.getField(sot, fieldApiName);

        if(!SchemaService.isFieldPolymorphic(field)) {
            throw new QueryException('TYPEOF operand "' + fieldApiName + '" is not a polymorphic relationship field');
        }

        Id parentRecordId = (Id) databaseRecord.get(fieldApiName);

        if(parentRecordId == null) {
            return queriedRecord;
        }
        SObject parentRecord = db.findRecord(parentRecordId);
        String parentObjApiName = SchemaService.getSObjectName(parentRecord).toLowerCase();

        Node curr = whenNode;
        Node fieldListNode;
        while(true) {
            if(curr == null) {
                fieldListNode = null;
                break;
            }

            Node objNode = curr.left;
            Node thenNode = curr.right;
            if(curr.nodeType == 'else') {
                fieldListNode = curr.right;
                break;
            }

            String expectedObjName = objNode.id;
            if(expectedObjName == parentObjApiName) {
                fieldListNode = thenNode;
                break;
            }

            curr = curr.right.right;
        }

        if(fieldListNode == null) {
            return queriedRecord;
        }

        curr = fieldListNode;
        List<String> selectFields = new List<String>();
        while(curr != null) {
            Schema.SObjectType parentRecordSot = SchemaService.getSObjectType(parentRecord);
            String parentRecordFieldApiName = SchemaService.getFieldName(parentRecordSot, curr.id);
            selectFields.add(parentRecordFieldApiName);
            curr = curr.left;
        }

        Map<String, Object> parentRecordData = new Map<String, Object>();
        if(queriedRecord.getSObject(relName) != null) {
            parentRecordData = SObjectService.mapFromSObject(queriedRecord.getSObject(relName));
        }

        for(String parentRecordFieldApiName : selectFields) {
            parentRecordData.put(parentRecordFieldApiName, parentRecord.get(parentRecordFieldApiName));
        }
        parentRecordData.put('Id', parentRecord.Id);
        
        Map<String, String> attributes = new Map<String, String> {
            'type' => SchemaService.getSObjectName(parentRecord),
            'url' => '/' + parentRecord.Id
        };
        parentRecordData.put('attributes', attributes);
        Map<String, Object> sObjClone = SObjectService.mapFromSObject(queriedRecord);

        Schema.DescribeFieldResult dfr = SchemaService.describeField(objApiName, fieldApiName);
        String relApiName = dfr.getRelationshipName();

        sObjClone.put(relApiName, parentRecordData);
        sObjClone.put(fieldApiName, parentRecord.Id);
        return SObjectService.sObjectFromMap(sObjClone, objApiName);
    }
}