/**
 * @description Strategy for getting the field value of a parent field
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public with sharing class WhereLogicParentFieldStrategy implements IWhereLogicComparisonStrategy {
    /**
     * @description Get the field value of a parent field
     * @param record `SObject`
     * @param fieldNode `Node`
     * @return  `WhereLogicComparisonResults`
     */
    public WhereLogicComparisonResults getFieldValue(
        SObject record,
        Node fieldNode
    ) {
        SObject parentRecord = record;
        String fieldName = fieldNode.id;
        List<String> fieldParts = fieldName.split('\\.');
        String finalField = fieldParts[fieldParts.size() - 1];
        fieldParts.remove(fieldParts.size() - 1);

        Map<String, Object> parentInfo;
        String parentObjApiName;
        SObject childRecord;
        do {
            String field = fieldParts[0];
            childRecord = parentRecord;
            parentInfo = ComparableService.getParentObject(parentRecord, field);
            parentRecord = (sObject) parentInfo.get('parentRecord');
            parentObjApiName = (String) parentInfo.get('parentObjApiName');
            fieldParts.remove(0);
        } while (!fieldParts.isEmpty());

        String finalFieldApiName;
        String fieldRelationshipName = (String) parentInfo.get(
            'fieldRelationshipName'
        );

        Schema.SObjectType childRecordSObjType = SchemaService.getSObjectType(
            childRecord
        );
        Boolean isPolymorphic = SchemaService.isRelationshipPolymorphic(
            childRecordSObjType,
            fieldRelationshipName
        );
        Map<String, String> polymorphicFieldMap = SchemaService.getPolymorphicFieldMap();
        Boolean isPolyField = polymorphicFieldMap.containsKey(finalField);

        if (isPolymorphic && isPolyField) {
            finalFieldApiName = polymorphicFieldMap.get(finalField);
        } else {
            Schema.SObjectType parentSot = SchemaService.getSObjectType(
                parentRecord
            );
            Schema.SObjectField parentField = SchemaService.getField(
                parentSot,
                finalField
            );
            finalFieldApiName = SchemaService.getFieldName(parentField);
        }

        Boolean isPolyType = false;
        Object recordFieldValue;
        if (finalFieldApiName == 'Type') {
            isPolyType = true;
            recordFieldValue = SchemaService.getSObjectName(parentRecord);
        } else if (isPolymorphic && isPolyField) {
            try {
                recordFieldValue = parentRecord.get(finalField);
            } catch (Exception e) {
                recordFieldValue = null;
            }
        } else {
            parentRecord = DataStore.getById(parentRecord.Id);
            recordFieldValue = parentRecord.get(finalFieldApiName);
        }

        return new WhereLogicComparisonResults.Builder()
            .setRecordFieldValue(recordFieldValue)
            .setFinalField(finalField)
            .setIsPolymorphicTypeField(isPolyType)
            .setParentRecord(parentRecord)
            .build();
    }
}
