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
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        wasCalled = true;
        if(recordToInsert.Id != null) {
            if(allOrNone) {
                throw new DmlException('INVALID_FIELD_FOR_INSERT_UPDATE, cannot specify Id in an insert call: [Id]');
            }
            return (Database.SaveResult) srService.createFailure(
                'Record already exists',
                Database.SaveResult.class
            );
        }
        SObject insertedRecord = setSystemFields(recordToInsert);
        String objName = SchemaService.getSObjectName(insertedRecord);
        Map<Id, SObject> mockRecords = this.mockObjects.get(objName);
        if(mockRecords == null) {
            mockRecords = new Map<Id, SObject>();
            this.mockObjects.put(objName, mockRecords);
        }
        mockRecords.put(insertedRecord.Id, insertedRecord);
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
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        wasCalled = true;
        return doInsert(recordToInsert, allOrNone, AccessLevel.USER_MODE);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        wasCalled = true;
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToInsert) {
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
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        wasCalled = true;
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone, accessLevel));
        }
        return results;
    }

    /**
     * @description Does a mock insert of a record into the database without setting `wasCalled` to true
     * @param recordsToInsert List of records to insert
     * @return  `List<SObject>`
     */
    public List<SObject> doMockInsert(List<SObject> recordsToInsert) {
        List<SObject> insertedRecords = new List<SObject>();
        for(SObject record : recordsToInsert) {
            insertedRecords.add(doMockInsert(record));
        }
        return insertedRecords;
    }

    /**
     * @description Does a mock insert of a record into the database without setting `wasCalled` to true
     * @param recordToInsert Record to insert
     * @return  `SObject`
     */
    public SObject doMockInsert(SObject recordToInsert) {
        SObject insertedRecord = setSystemFields(recordToInsert);
        String objName = SchemaService.getSObjectName(insertedRecord);
        Map<Id, SObject> mockRecords = this.mockObjects.get(objName);
        if(mockRecords == null) {
            mockRecords = new Map<Id, SObject>();
            this.mockObjects.put(objName, mockRecords);
        }
        mockRecords.put(insertedRecord.Id, insertedRecord);
        return insertedRecord;
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
        Map<String, Object> recordMap = (Map<String, Object>) JSON.deserializeUntyped( 
            JSON.serialize(recordToInsert)
        );

        recordMap.put('CreatedDate', DateTime.now());
        recordMap.put('CreatedById', UserInfo.getUserId());
        recordMap.put('LastModifiedDate', DateTime.now());
        recordMap.put('LastModifiedById', UserInfo.getUserId());
        recordMap.put('SystemModstamp', DateTime.now());
        recordMap.put('LastActivityDate', Date.today());
        recordMap.put('IsDeleted', false);
        if(SchemaService.hasField(sot, 'OwnerId')) {
            recordMap.put('OwnerId', UserInfo.getUserId());
        }
        
        String apiName = SchemaService.getSObjectName(recordToInsert);
        return (SObject) JSON.deserialize(JSON.serialize(recordMap), Type.forName(apiName));
    }
}