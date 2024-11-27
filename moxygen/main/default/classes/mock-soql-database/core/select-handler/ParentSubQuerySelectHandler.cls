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

        fieldParts = new List<String>(fieldParts);
        String fieldPart = fieldParts[0];

        Map<String, Object> parentInfo = ComparableService.getParentObject(MockDatabase.selectRecordById(sObj.Id), fieldPart);
        sObject parentRecord = (sObject) parentInfo.get('parentRecord');
        String fieldApiName = (String) parentInfo.get('fieldApiName');
        String fieldRelationshipName = (String) parentInfo.get('fieldRelationshipName');
        String objApiName = (String) parentInfo.get('objApiName');

        Map<String, Object> sObjClone = Common.mapFromRecord(sObj);
        String parentRecordApiName = (String) parentInfo.get('parentObjApiName');
        fieldParts.remove(0);
        if(!fieldParts.isEmpty()) {
            if(sObjClone.containsKey(fieldRelationshipName)) {
                parentRecord = Common.recordFromMap((Map<String, Object>)sObjClone.get(fieldRelationshipName), parentRecordApiName);
            }
            sObject nextParent = buildObjWithRelations(parentRecord, fieldParts, finalField);
            sObjClone.put(fieldApiName, nextParent.Id);
            sObjClone.put(fieldRelationshipName, nextParent);
        } else {
            Map<Id, sObject> mockRecords = MockDatabase.get(parentRecordApiName);
            
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

            Map<String, Object> parentRecordData = Common.mapFromRecord(parentRecord);

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
                Attributes attributes = new Attributes(parentRecord.Id);
                
                parentRecordData.put('attributes', attributes);
            } else {
                parentRecordData.put(finalFieldApiName, mockRecords.get(parentRecord.Id).get(finalFieldApiName));
            }
            sObjClone.put(fieldApiName, parentRecord.Id);
            sObjClone.put(fieldRelationshipName, parentRecordData);
        }
        return Common.recordFromMap(sObjClone, objApiName);
    }
}