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
 * @description MockInsertHandler is used to mock the insert operation
 * @author Zackary Frazier
 * @since 3/9/2024
 */
@IsTest
public inherited sharing class MockInsertHandler extends MockDMLHandler {
    /**
     * @description doInsert is used to insert a record into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.SaveResult - The result of the insert operation
     */
    public Database.SaveResult doInsert(
        SObject recordToInsert,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        if (recordToInsert.Id != null) {
            if (allOrNone) {
                throw new DmlException(
                    'INVALID_FIELD_FOR_INSERT_UPDATE, cannot specify Id in an insert call: [Id]'
                );
            }
            return (Database.SaveResult) srService.createFailure(
                'Record already exists',
                Database.SaveResult.class
            );
        }
        SObject insertedRecord = setSystemFields(recordToInsert);
        DataStore.put(insertedRecord);
        return (Database.SaveResult) srService.createSuccess(
            insertedRecord.Id,
            Database.SaveResult.class
        );
    }

    /**
     * @description Does a mock insert of a record into the database
     * @param recordToInsert Record to insert
     * @param allOrNone Boolean to throw an exception if the record already exists
     * @return  `Database.SaveResult`
     * @exception DmlException
     */
    public Database.SaveResult doInsert(
        SObject recordToInsert,
        Boolean allOrNone
    ) {
        wasCalled = true;
        return doInsert(recordToInsert, allOrNone, AccessLevel.USER_MODE);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(
        List<SObject> recordsToInsert,
        Boolean allOrNone
    ) {
        wasCalled = true;
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for (SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone));
        }
        return results;
    }

    /**
     * @description Inserts a list of records into the database
     * @param recordsToInsert List of records to insert
     * @param allOrNone Boolean to throw an exception if the record already exists
     * @param accessLevel Access level of the user performing the operation
     * @return  `List<Database.SaveResult>`
     */
    public List<Database.SaveResult> doInsert(
        List<SObject> recordsToInsert,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for (SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone, accessLevel));
        }
        return results;
    }

    /**
     * @description Does a mock insert of a record into the database without setting `wasCalled` to true
     * @param recordsToInsert List of records to insert
     */
    public void doMockInsert(List<SObject> recordsToInsert) {
        for (SObject record : recordsToInsert) {
            doMockInsert(record);
        }
    }

    /**
     * @description Does a mock insert of a record into the database without setting `wasCalled` to true
     * @param recordToInsert Record to insert
     */
    public void doMockInsert(SObject recordToInsert) {
        Schema.SObjectType sot = SchemaService.getSObjectType(recordToInsert);
        recordToInsert.put('Id', fflib_IDGenerator.generate(sot));

        SObject insertedRecord = setSystemFields(recordToInsert);
        DataStore.put(insertedRecord);
    }

    /**
     * @description sets the system fields when a record is inserted
     * @param recordToInsert - The record to insert
     * @return A reference to the record in the mock database
     */
    private SObject setSystemFields(SObject recordToInsert) {
        Schema.SObjectType sot = SchemaService.getSObjectType(recordToInsert);
        String fakeId = fflib_IDGenerator.generate(sot);
        recordToInsert.put('Id', fakeId);

        Map<String, Object> readOnlyFields = getReadOnlyFields(recordToInsert);
        return Common.putReadOnlyFields(recordToInsert, readOnlyFields);
    }

    private Map<String, Object> getReadOnlyFields(SObject recordToInsert) {
        Schema.SObjectType sot = SchemaService.getSObjectType(recordToInsert);
        Map<String, Object> readOnlyFields = new Map<String, Object>{
            'CreatedDate' => Gmt.now(),
            'CreatedById' => UserInfo.getUserId(),
            'LastModifiedDate' => Gmt.now(),
            'LastModifiedById' => UserInfo.getUserId(),
            'SystemModstamp' => Gmt.now(),
            'LastActivityDate' => Gmt.today(),
            'IsDeleted' => false
        };

        if (
            SchemaService.hasField(sot, 'OwnerId') &&
            recordToInsert.get('OwnerId') == null
        ) {
            readOnlyFields.put('OwnerId', UserInfo.getUserId());
        }

        return readOnlyFields;
    }
}
