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

    private Object recordFieldValue;
    private Object comparate;
    private Schema.DisplayType fieldType;
    private SObject record;

    private Boolean isPolymorphicTypeField = false;

    /**
     * @description Constructor
     * @param options - the options to be used for the handler
     */
    public WhereLogicHandler(BooleanLogicOptions options) {
        super(options);
        this.record = (SObject) this.obj;
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
        
        this.comparate = MockDatabase.utils.getFieldNodeValue(valueNode, this.record, params);
        if(!(this.comparate instanceOf List<Object>)) {
            this.comparate = String.valueOf(this.comparate);
        }
        
        String fieldName = fieldNode.id;

        Boolean isParentField = fieldName.contains('.');

        // if the field is a parent field, we need to get the parent record
        // further down, we can't say for sure whether the field is a parent field or not
        // so we'll need to store our object and field name in a variable
        sObject parentRecord = this.record;
        String finalField = fieldName;

        // the Type field on a polymorphic relationship is a special case
        if(AggregateService.isDateFunc(fieldNode.nodeType, fieldNode.id)) {
            finalField = resolveDateFunc(fieldNode);
        } else if(!isParentField) {
            this.recordFieldValue = sObj.get(fieldName);
        } else {
            ParentFieldLookupInfo info = resolveParentFieldLookup(parentRecord, finalField);
            parentRecord = info.parentRecord;
            finalField = info.finalField;
        }

        OperatorHandlerFactory handlerFactory = new OperatorHandlerFactory();

        IOperatorHandler handler = handlerFactory.getHandler(operatorNode.id);
        if(this.isPolymorphicTypeField) {
            return handler.handle(this.recordFieldValue, this.comparate);
        }
        
        Schema.SObjectType parentSot = SchemaService.getSObjectType(parentRecord);
        this.fieldType = SchemaService.getFieldType(parentSot, finalField);

        validateListOperators(handler);

        if(valueNode.nodeType == NodeType.DATE_LITERAL) {
            if(this.fieldType != Schema.DisplayType.DATE && this.fieldType != Schema.DisplayType.DATETIME) {
                throw new QueryException('Invalid field type for date literal');
            }

            if(this.fieldType == Schema.DisplayType.DATE && this.comparate == Token.TODAY_LITERAL) {
                this.comparate = Common.dateToSoqlString(GMT.today());
            } else if(this.fieldType == Schema.DisplayType.DATETIME && this.comparate == Token.TODAY_LITERAL) {
                this.comparate = Common.dateToSoqlString(GMT.today());
                if(this.recordFieldValue != null) {
                    this.recordFieldValue = GMT.date((DateTime) this.recordFieldValue);
                }
            } else if(this.fieldType == Schema.DisplayType.DATE && this.comparate == Token.YESTERDAY_LITERAL) {
                this.comparate = Common.dateToSoqlString(GMT.today().addDays(-1));
            } else if(this.fieldType == Schema.DisplayType.DATETIME && this.comparate == Token.YESTERDAY_LITERAL) {
                this.comparate = Common.dateToSoqlString(GMT.today().addDays(-1));
                if(this.recordFieldValue != null) {
                    this.recordFieldValue = GMT.date((DateTime) this.recordFieldValue);
                }
            }
        }

        if(isDateOrDateTime() && this.comparate instanceOf String) {
            this.comparate = ((String) this.comparate).toUpperCase();
        }

        return handler.handle(this.recordFieldValue, this.comparate);
    }

    private void validateListOperators(IOperatorHandler handler) {
        Boolean isMultiSelect = (this.fieldType == Schema.DisplayType.MULTIPICKLIST);
        Boolean isIncludes = (handler instanceof IncludesHandler);
        Boolean isExcludes = (handler instanceof ExcludesHandler);
        if((isIncludes || isExcludes) && !isMultiSelect) {
            throw new QueryException('Invalid field type for INCLUDES operator');
        }
    }

    private Boolean isDateOrDateTime() {
        List<Schema.DisplayType> dateTypes = new List<Schema.DisplayType> {
            Schema.DisplayType.DATE,
            Schema.DisplayType.DATETIME
        };
        return dateTypes.contains(this.fieldType);
    }

    private String resolveDateFunc(Node fieldNode) {
        // in this sceneario, fieldNode's actually an aggregate, so fieldNode.right is the actual field
        String fieldName = SchemaService.getFieldName(this.record, fieldNode.right.id);
        Object dateOrDateTimeValue = this.record.get(fieldName);
        Boolean isDateFunc = AggregateService.isDateFunc(fieldNode.nodeType, fieldNode.id);
        if(isDateFunc) {
            this.recordFieldValue = DateFuncs.execute(fieldNode.id, dateOrDateTimeValue);
        } else {
            throw new QueryException('Unsupported date function');
        }
        return fieldName;
    }

    /**
     * @description Resolves the value of a parent field lookup
     * @param lookupFieldValue `String` String on the form of ParentField.ChildField.ChildField...
     * @param parentRecord `sObject` The first (and possibly last) parent record
     * @return  `String`
     */
    private ParentFieldLookupInfo resolveParentFieldLookup(SObject parentRecord, String lookupFieldValue) {
        List<String> fieldParts = lookupFieldValue.split('\\.');
        String finalField = fieldParts[fieldParts.size()-1];
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
            this.isPolymorphicTypeField = true;
            this.recordFieldValue = SchemaService.getSObjectName(parentRecord);
        } else if(isPolymorphic && isPolyField) {
            try {
                this.recordFieldValue = parentRecord.get(finalField);
            } catch(Exception e) {
                this.recordFieldValue = null;
            }
        } else {
            parentRecord = MockDatabase.get(parentObjApiName).get(parentRecord.Id);
            this.recordFieldValue = parentRecord.get(finalFieldApiName);
        }

        return new ParentFieldLookupInfo(parentRecord, finalField);
    }

    class ParentFieldLookupInfo {
        public SObject parentRecord;
        public String finalField;
        public ParentFieldLookupInfo(SObject parentRecord, String finalField) {
            this.parentRecord = parentRecord;
            this.finalField = finalField;
        }
    }
}