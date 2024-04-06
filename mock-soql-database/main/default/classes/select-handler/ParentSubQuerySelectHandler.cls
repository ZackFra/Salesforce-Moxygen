/**
 * @description Handles the selection of a field that is a parent relationship in a subquery 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class ParentSubQuerySelectHandler implements ISelectHandler {
    
    FieldSelector fSelector;
    /**
     * @description Constructor for ParentSubQuerySelectHandler
     * @param fSelector 
     */
    public ParentSubQuerySelectHandler(FieldSelector fSelector) {
        Map<String, Object> args = new Map<String, Object>{ 
            'fSelector' => fSelector 
        };
        Common.nullCheck(args);
        this.fSelector = fSelector;
    }

    /**
     * @description Selects the field from the queried record 
     * @return  `SObject`
     */
    public SObject handleSelect() {
        SObject queriedRecord = fSelector.queriedRecord;
        Node fieldNode = fSelector.fieldNode;

        String fieldName = fieldNode.id;

        List<String> fieldParts = fieldName.split('\\.');
        String finalField = fieldParts[fieldParts.size()-1];
        fieldParts.remove(fieldParts.size()-1);
        return buildObjWithRelations(queriedRecord, fieldParts, finalField);
    }

    @SuppressWarnings('PMD.NcssMethodCount, PMD.CognitiveComplexity, PMD.CyclomaticComplexity')
    private sObject buildObjWithRelations(SObject sObj, List<String> fieldParts, String finalField) {
        MockDatabase db = fSelector.db;

        fieldParts = new List<String>(fieldParts);
        String fieldPart = fieldParts[0];

        Map<String, Object> parentInfo = ComparableService.getParentObject(db, db.findRecord(sObj.Id), fieldPart);

        sObject parentRecord = (sObject) parentInfo.get('parentRecord');
        String fieldApiName = (String) parentInfo.get('fieldApiName');
        String fieldRelationshipName = (String) parentInfo.get('fieldRelationshipName');
        String objApiName = (String) parentInfo.get('objApiName');

        Map<String, Object> sObjClone = SObjectService.mapFromSObject(sObj);
        String parentRecordApiName = (String) parentInfo.get('parentObjApiName');
        fieldParts.remove(0);
        if(!fieldParts.isEmpty()) {
            if(sObjClone.containsKey(fieldRelationshipName)) {
                parentRecord = SObjectService.sObjectFromMap((Map<String, Object>)sObjClone.get(fieldRelationshipName), parentRecordApiName);
            }
            sObject nextParent = buildObjWithRelations(parentRecord, fieldParts, finalField);
            sObjClone.put(fieldApiName, nextParent.Id);
            sObjClone.put(fieldRelationshipName, nextParent);
        } else {
            Map<Id, sObject> mockRecords = db.get(parentRecordApiName);
            
            Schema.SObjectType parentRecordSObjType = SchemaService.getSObjectType(parentRecord);
            Boolean isRelationshipPolymorphic = (Boolean) parentInfo.get('isPolymorphic');
            Map<String, String> polymorphicFieldMap = SchemaService.getPolymorphicFieldMap();
            Boolean isNameField = polymorphicFieldMap.containsKey(finalField);
            String finalFieldApiName;
            if(isRelationshipPolymorphic && isNameField)  {
                finalFieldApiName = polymorphicFieldMap.get(finalField);
            } else {
                finalFieldApiName = SchemaService.getFieldName(parentRecordSObjType, finalField);
            }

            Map<String, Object> parentRecordData = SObjectService.mapFromSObject(parentRecord);

            if(sObjClone.containsKey(fieldRelationshipName)) {
                parentRecordData = (Map<String, Object>) sObjClone.get(fieldRelationshipName);
            } 
            
            if(isRelationshipPolymorphic) {
                if(finalFieldApiName == 'Type') {
                    parentRecordData.put(finalFieldApiName, parentRecordApiName);
                } else {
                    SObject parentRecordFromDatabase = mockRecords.get(parentRecord.Id);
                    try {
                        parentRecordData.put(finalFieldApiName, parentRecordFromDatabase.get(finalFieldApiName));
                    } catch(System.SObjectException e) {
                        parentRecordData.put(finalFieldApiName, null);
                    } catch(Exception e) {
                        throw e;
                    }
                }

                // the "Name" object is a hidden SF object for polymorphic relationships
                Schema.SObjectType polymorphicSObjectSot = SchemaService.getPolymorphicSObjectType();
                String polymorphicSObjectName = SchemaService.getSObjectName(polymorphicSObjectSot);

                Map<String, String> attributes = new Map<String, String> {
                    'type' => polymorphicSObjectName,
                    'url' => '/' + parentRecord.Id
                };
                
                parentRecordData.put('attributes', attributes);
            } else {
                parentRecordData.put(finalFieldApiName, mockRecords.get(parentRecord.Id).get(finalFieldApiName));
            }
            sObjClone.put(fieldApiName, parentRecord.Id);
            sObjClone.put(fieldRelationshipName, parentRecordData);
        }
        return SObjectService.sObjectFromMap(sObjClone, objApiName);
    }
}