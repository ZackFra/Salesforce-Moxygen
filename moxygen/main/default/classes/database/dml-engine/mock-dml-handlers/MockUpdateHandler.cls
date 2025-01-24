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
 * @description MockUpdateHandler is used to mock the update operation in the database
 * @author Zackary Frazier
 * @since 3/9/2021
 */
@IsTest
public inherited sharing class MockUpdateHandler extends MockDMLHandler {
    /**
     * @description Updates a record in the database
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `Database.SaveResult`
     * @exception DMLException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public Database.SaveResult doUpdate(
        SObject recordToUpdate,
        Boolean allOrNone
    ) {
        wasCalled = true;
        Map<String, Object> args = new Map<String, Object>{
            'recordToUpdate' => recordToUpdate,
            'allOrNone' => allOrNone
        };
        Common.nullCheck(args);

        String objName = SchemaService.getSObjectName(recordToUpdate);
        Map<Id, sObject> mockRecords = MockDatabase.mockRecords.get(objName);

        if (mockRecords == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if (mockRecords.get(recordToUpdate.Id) == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if (
            mockRecords == null ||
            mockRecords.get(recordToUpdate.Id) == null
        ) {
            return (Database.SaveResult) srService.createFailure(
                'Record does not exist',
                Database.SaveResult.class
            );
        }

        Schema.SObjectType sot = SchemaService.getSObjectType(recordToUpdate);

        for (String field : recordToUpdate.getPopulatedFieldsAsMap().keySet()) {
            Schema.SObjectField sObjField = SchemaService.getField(sot, field);
            Schema.DescribeFieldResult sObjFieldDescribe = SchemaService.describeField(
                sObjField
            );

            if (!sObjFieldDescribe.isUpdateable()) {
                continue;
            }

            mockRecords.get(recordToUpdate.Id)
                .put(field, recordToUpdate.get(field));
        }

        Map<String, Object> mockRecord = (Map<String, Object>) JSON.deserializeUntyped(
            JSON.serialize(mockRecords.get(recordToUpdate.Id))
        );
        mockRecord.put('LastModifiedDate', DateTime.now());
        mockRecord.put('LastModifiedById', UserInfo.getUserId());

        recordToUpdate = (SObject) JSON.deserialize(
            JSON.serialize(mockRecord),
            Type.forName(objName)
        );
        mockRecords.put(recordToUpdate.Id, recordToUpdate);
        return (Database.SaveResult) srService.createSuccess(
            recordToUpdate.Id,
            Database.SaveResult.class
        );
    }

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.SaveResult> - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(
        List<SObject> recordsToUpdate,
        Boolean allOrNone
    ) {
        wasCalled = true;
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for (SObject record : recordsToUpdate) {
            results.add(doUpdate(record, allOrNone));
        }
        return results;
    }

    /**
     * @description Updates a record in the database
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access level of the user
     * @return  `Database.SaveResult`
     */
    public Database.SaveResult doUpdate(
        SObject recordToUpdate,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        return doUpdate(recordToUpdate, allOrNone);
    }

    /**
     * @description Updates a list of records in the database
     * @param recordsToUpdate Records to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access level of the user
     * @return  `List<Database.SaveResult>`
     */
    public List<Database.SaveResult> doUpdate(
        List<SObject> recordsToUpdate,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        return doUpdate(recordsToUpdate, allOrNone);
    }
}
