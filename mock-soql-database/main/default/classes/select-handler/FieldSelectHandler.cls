/**
 * @description FieldSelectHandler is a class that implements ISelectHandler. It is used to handle the selection of a field. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class FieldSelectHandler implements ISelectHandler {
    FieldSelector fSelector;

    /**
     * @description Constructor for FieldSelectHandler
     * @param fSelector 
     */
    public FieldSelectHandler(FieldSelector fSelector) {
        this.fSelector = fSelector;
    }

    /**
     * @description Handles the selection of a field
     * @return  `SObject`
     */
    public SObject handleSelect() {
        SObject queriedRecord = fSelector.queriedRecord;
        SObject databaseRecord = fSelector.databaseRecord;
        Node fieldNode = fSelector.fieldNode;

        String fieldName = fieldNode.id;
        Object fieldValue = databaseRecord.get(fieldName);

        Schema.SObjectType sot = SchemaService.getSObjectType(databaseRecord);
        String sObjectName = SchemaService.getSObjectName(sot);
        if(fieldValue != null) {
            Map<String, Object> objMap = SObjectService.mapFromSObject(queriedRecord);
            objMap.put(fieldName, fieldValue);
            
            queriedRecord = SObjectService.sObjectFromMap(objMap, SObjectName);
        }
        return queriedRecord;
    }
}