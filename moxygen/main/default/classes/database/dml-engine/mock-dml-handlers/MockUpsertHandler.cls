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
 * @description MockUpsertHandler is used to mock the upsert operation in the database
 * @author Zackary Frazier
 * @since 3/9/2024
 * @group DML Engine
 */
@SuppressWarnings('PMD.CyclomaticComplexity, PMD.CognitiveComplexity')
@IsTest
public with sharing class MockUpsertHandler extends MockDMLHandler {
    /**
     * @description Upsert a record into the database
     * @param recordToUpsert Record to upsert
     * @param externalIdField Optional field to use as the external id for the upsert operation
     * @param allOrNone Boolean to throw an exception if the record already exists
     * @return  `Database.UpsertResult`
     * @exception DmlException
     */
    public Database.UpsertResult doUpsert(
        SObject recordToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone
    ) {
        wasCalled = true;
        return doUpsert(recordToUpsert, allOrNone);
    }

    /**
     * @description doUpsert is used to upsert a list of records into the database
     * @param recordsToUpsert The records to upsert
     * @param externalIdField Optional field to use as the external id for the upsert operation
     * @param allOrNone Boolean to throw an exception if the record already exists
     * @return `List<Database.UpsertResult>`
     * @exception DmlException
     */
    public List<Database.UpsertResult> doUpsert(
        List<SObject> recordsToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone
    ) {
        wasCalled = true;
        return doUpsert(recordsToUpsert, allOrNone);
    }

    /**
     * @description Upsert a record into the database
     * @param recordToUpsert Record to upsert
     * @param externalIdField Optional field to use as the external id for the upsert operation
     * @param allOrNone Boolean to throw an exception if the record already exists
     * @param accessLevel Access level of the user performing the operation
     * @return  `Database.UpsertResult`
     * @exception DmlException
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public Database.UpsertResult doUpsert(
        SObject recordToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        return doUpsert(recordToUpsert, allOrNone);
    }

    /**
     * @description Upsers a list of records into the database
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external id for the upsert operation
     * @param allOrNone Boolean to throw an exception if any of the records already exist
     * @param accessLevel Access level of the user performing the operation
     * @return  `List<Database.UpsertResult>`
     * @exception DmlException
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public List<Database.UpsertResult> doUpsert(
        List<SObject> recordsToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        wasCalled = true;
        return doUpsert(recordsToUpsert, allOrNone);
    }

    /**
     * @description Upsers a list of records into the database
     * @param recordsToUpsert Records to upsert
     * @param allOrNone Boolean to throw an exception if any of the records already exist
     * @return  `List<Database.UpsertResult>`
     * @exception DmlException
     */
    private List<Database.UpsertResult> doUpsert(
        List<SObject> recordsToUpsert,
        Boolean allOrNone
    ) {
        List<Database.UpsertResult> results = new List<Database.UpsertResult>();
        for (SObject record : recordsToUpsert) {
            Database.UpsertResult sr = doUpsert(record, allOrNone);
            results.add(sr);
        }
        return results;
    }

    /**
     * @description doUpsert is used to upsert a record into the database
     * @param recordToUpsert - The record to upsert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @return Database.UpsertResult - The result of the upsert operation
     */
    private Database.UpsertResult doUpsert(
        SObject recordToUpsert,
        Boolean allOrNone
    ) {
        Database.SaveResult sr;
        if (recordToUpsert.Id != null) {
            sr = doUpdate(recordToUpsert, allOrNone);
        } else {
            sr = doInsert(recordToUpsert, allOrNone);
        }

        if (sr.isSuccess()) {
            return (Database.UpsertResult) srService.createSuccess(
                recordToUpsert.Id,
                Database.UpsertResult.class
            );
        } else {
            return (Database.UpsertResult) srService.createFailure(
                sr.getErrors()[0].getMessage(),
                Database.UpsertResult.class
            );
        }
    }

    /**
     * @description doInsert is used to insert a record into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.SaveResult - The result of the insert operation
     */
    private Database.SaveResult doInsert(
        SObject recordToInsert,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
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

        Schema.SObjectType sot = SchemaService.getSObjectType(recordToInsert);

        String fakeId = fflib_IDGenerator.generate(sot);
        recordToInsert.put('Id', fakeId);
        recordToInsert = setSystemFieldsOnInsert(recordToInsert);

        DataStore.put(recordToInsert);
        return (Database.SaveResult) srService.createSuccess(
            recordToInsert.Id,
            Database.SaveResult.class
        );
    }

    /**
     * @description Insert a record into the database
     * @param recordToInsert Record to insert
     * @param allOrNone Boolean to throw an exception if the record already exists
     * @return  `Database.SaveResult`
     */
    private Database.SaveResult doInsert(
        SObject recordToInsert,
        Boolean allOrNone
    ) {
        return doInsert(recordToInsert, allOrNone, AccessLevel.USER_MODE);
    }

    /**
     * @description Update a record in the database
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `Database.SaveResult`
     * @exception DMlException
     */
    private Database.SaveResult doUpdate(
        SObject recordToUpdate,
        Boolean allOrNone
    ) {
        Map<String, Object> args = new Map<String, Object>{
            'recordToUpdate' => recordToUpdate,
            'allOrNone' => allOrNone
        };
        Common.nullCheck(args);

        SObjectType sot = SchemaService.getSObjectType(recordToUpdate);
        Map<Id, sObject> mockRecords = DataStore.getAllBySot(sot);

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

        recordToUpdate = setSystemFieldsOnUpdate(recordToUpdate);
        mockRecords.put(recordToUpdate.Id, recordToUpdate);
        return (Database.SaveResult) srService.createSuccess(
            recordToUpdate.Id,
            Database.SaveResult.class
        );
    }

    private SObject setSystemFieldsOnUpdate(SObject recordToUpdate) {
        Map<String, Object> readOnlyFields = getReadOnlyFieldsForUpdate();
        return Common.putReadOnlyFields(recordToUpdate, readOnlyFields);
    }

    private Map<String, Object> getReadOnlyFieldsForUpdate() {
        Map<String, Object> readOnlyFields = new Map<String, Object>{
            'LastModifiedDate' => DateTime.now(),
            'LastModifiedById' => UserInfo.getUserId()
        };

        return readOnlyFields;
    }

    /**
     * @description sets the system fields when a record is inserted
     * @param recordToInsert - The record to insert
     * @return A reference to the record in the mock database
     */
    private SObject setSystemFieldsOnInsert(SObject recordToInsert) {
        Schema.SObjectType sot = SchemaService.getSObjectType(recordToInsert);
        String fakeId = fflib_IDGenerator.generate(sot);
        recordToInsert.put('Id', fakeId);

        Map<String, Object> readOnlyFields = getReadOnlyFieldsForInsert(
            recordToInsert
        );
        return Common.putReadOnlyFields(recordToInsert, readOnlyFields);
    }

    private Map<String, Object> getReadOnlyFieldsForInsert(
        SObject recordToInsert
    ) {
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

        if (SchemaService.hasField(sot, 'OwnerId')) {
            readOnlyFields.put('OwnerId', UserInfo.getUserId());
        }

        return readOnlyFields;
    }
}
