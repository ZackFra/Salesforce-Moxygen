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
 * @description Select handler for TYPEOF operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public inherited sharing class PolymorphicSelectHandler implements ISelectHandler {
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
        SObject parentRecord = MockDatabase.selectRecordById(parentRecordId);
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
            parentRecordData = Common.mapFromRecord(queriedRecord.getSObject(relName));
        }

        for(String parentRecordFieldApiName : selectFields) {
            parentRecordData.put(parentRecordFieldApiName, parentRecord.get(parentRecordFieldApiName));
        }
        parentRecordData.put('Id', parentRecord.Id);
        Attributes attributes = new Attributes(parentRecord);
        parentRecordData.put('attributes', attributes);
        Map<String, Object> sObjClone = Common.mapFromRecord(queriedRecord);

        Schema.DescribeFieldResult dfr = SchemaService.describeField(objApiName, fieldApiName);
        String relApiName = dfr.getRelationshipName();

        sObjClone.put(relApiName, parentRecordData);
        sObjClone.put(fieldApiName, parentRecord.Id);
        return Common.recordFromMap(sObjClone, objApiName);
    }
}