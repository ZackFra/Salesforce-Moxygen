/**
 * @description This class is responsible for handling the WHERE clause logic 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public with sharing class WhereLogicHandler extends BooleanLogicHandler {
    /**
     * @description Constructor
     * @param options - the options to be used for the handler
     */
    public WhereLogicHandler(BooleanLogicOptions options) {
        super(options);
    }

    /**
     * @description Checks if the WHERE clause is met
     * @param operatorNode 
     * @return  `Boolean`
     * @exception QueryException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity, PMD.NcssMethodCount, PMD.CognitiveComplexity')
    public override Boolean isCompareConditionMet(Node operatorNode) {
        Node fieldNode = operatorNode.left;
        Node valueNode = operatorNode.right;
        SObject sObj = (SObject) this.obj;
        Map<String, Object> params = this.params;
        
        Object fieldValue = this.db.utils.getFieldNodeValue(valueNode, sObj, params);
        
        String fieldName = fieldNode.id;
        Object sObjectFieldValue;

        Boolean isParentField = fieldName.contains('.');

        // if the field is a parent field, we need to get the parent record
        // further down, we can't say for sure whether the field is a parent field or not
        // so we'll need to store our object and field name in a variable
        sObject parentRecord = sObj;
        String finalField = fieldName;

        // the Type field on a polymorphic relationship is a special case
        Boolean isPolyType = false;

        if(!isParentField) {
            sObjectFieldValue = sObj.get(fieldName);
        } else {
            List<String> fieldParts = fieldName.split('\\.');
            finalField = fieldParts[fieldParts.size()-1];
            fieldParts.remove(fieldParts.size()-1);
            
            Map<String, Object> parentInfo;
            String parentObjApiName;
            SObject childRecord;
            do {
                String field = fieldParts[0];
                childRecord = parentRecord;
                parentInfo = ComparableService.getParentObject(db, parentRecord, field);
                parentRecord = (sObject) parentInfo.get('parentRecord');
                parentObjApiName = (String) parentInfo.get('parentObjApiName');
                fieldParts.remove(0);
            } while(!fieldParts.isEmpty());
            
            String finalFieldApiName;
            String fieldRelationshipName = (String) parentInfo.get('fieldRelationshipName');

            Schema.SObjectType childRecordSObjType = SchemaService.getSObjectType(childRecord);
            Boolean isPolymorphic = SchemaService.isRelationshipPolymorphic(childRecordSObjType, fieldRelationshipName);
            Map<String, String> polymorphicFieldMap = SchemaService.getPolymorphicFieldMap();
            Boolean isPolyField = polymorphicFieldMap.containsKey(finalField);
            
            if(isPolymorphic && isPolyField) {
                finalFieldApiName = polymorphicFieldMap.get(finalField);
            } else {
                Schema.SObjectType parentSot = SchemaService.getSObjectType(parentRecord);
                Schema.SObjectField parentField = SchemaService.getField(parentSot, finalField);
                finalFieldApiName = SchemaService.getFieldName(parentField);
            }

            if(finalFieldApiName == 'Type') {
                isPolyType = true;
                sObjectFieldValue = SchemaService.getSObjectName(parentRecord);
            } else if(isPolymorphic && isPolyField) {
                try {
                    sObjectFieldValue = parentRecord.get(finalField);
                } catch(Exception e) {
                    sObjectFieldValue = null;
                }
            } else {
                parentRecord = this.db.get(parentObjApiName).get(parentRecord.Id);
                sObjectFieldValue = parentRecord.get(finalFieldApiName);
            }
        }

        OperatorHandlerFactory handlerFactory = new OperatorHandlerFactory();

        IOperatorHandler handler = handlerFactory.getHandler(operatorNode.id);
        if(isPolyType) {
            return handler.handle(sObjectFieldValue, fieldValue);
        }
        
        Schema.SObjectType parentSot = SchemaService.getSObjectType(parentRecord);
        Schema.DisplayType fieldType = SchemaService.getFieldType(parentSot, finalField);
        
        if(handler instanceof IncludesHandler) {
            if(fieldType != Schema.DisplayType.MULTIPICKLIST) {
                throw new QueryException('Invalid field type for INCLUDES operator');
            }
        }

        if(handler instanceof ExcludesHandler) {
            if(fieldType != Schema.DisplayType.MULTIPICKLIST) {
                throw new QueryException('Invalid field type for EXCLUDES operator');
            }
        }

        return handler.handle(sObjectFieldValue, fieldValue);
    }
}