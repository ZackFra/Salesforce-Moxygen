/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

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
        
        Object fieldValue = MockDatabase.utils.getFieldNodeValue(valueNode, sObj, params);
        if(!(fieldValue instanceOf List<Object>)) {
            fieldValue = String.valueOf(fieldValue);
        }
        
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
        if(AggregateService.isDateFunc(fieldNode.nodeType, fieldNode.id)) {
            // in this sceneario, fieldNode's actually an aggregate, so fieldNode.right is the actual field
            fieldName = SchemaService.getFieldName(sObj, fieldNode.right.id);
            finalField = fieldName;
            Object dateOrDateTimeValue = sobj.get(fieldName);
            Boolean isDateFunc = AggregateService.isDateFunc(fieldNode.nodeType, fieldNode.id);
            if(isDateFunc) {
                sObjectFieldValue = DateFuncs.execute(fieldNode.id, dateOrDateTimeValue);
            } else {
                throw new QueryException('Unsupported date function');
            }
        } else if(!isParentField) {
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
                parentInfo = ComparableService.getParentObject(parentRecord, field);
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
                parentRecord = MockDatabase.get(parentObjApiName).get(parentRecord.Id);
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
        
        Object comparate = fieldValue;
        String objectType = TypeOf.forObject(sObjectFieldValue);
        if(handler instanceof IncludesHandler && (fieldType != Schema.DisplayType.MULTIPICKLIST)) {
            throw new QueryException('Invalid field type for INCLUDES operator');
        } else if(handler instanceof ExcludesHandler && (fieldType != Schema.DisplayType.MULTIPICKLIST)) {
            throw new QueryException('Invalid field type for EXCLUDES operator');
        } else if(sObjectFieldValue != null && (handler instanceOf ComparisonHandler)) {
            comparate = DynamicCast.castTo(TypeOf.forObject(sObjectFieldValue), fieldValue);
            if(objectType == ApexTypes.XSTRING) {
                return handler.handle(((String) sObjectFieldValue).toLowerCase(), ((String) fieldValue).toLowerCase());
            } else {
                return handler.handle(sObjectFieldValue, comparate);
            }
        }

        return handler.handle(sObjectFieldValue, comparate);
    }
}