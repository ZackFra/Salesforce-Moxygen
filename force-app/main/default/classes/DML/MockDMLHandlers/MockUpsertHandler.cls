public inherited sharing class MockUpsertHandler extends MockDMLHandler {

    /**
     * @description doUpsert is used to upsert a list of records into the database
     * @param recordsToUpsert - The records to upsert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.UpsertResult> - The results of the upsert operations
     */
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        wasCalled = true;
        return doUpsert(recordToUpsert, allOrNone);
    }

    /**
     * @description doUpsert is used to upsert a list of records into the database
     * @param recordsToUpsert - The records to upsert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.UpsertResult> - The results of the upsert operations
     */
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        wasCalled = true;
        return doUpsert(recordsToUpsert, allOrNone);
    }

    /**
     * @description doUpsert is used to upsert a record into the database
     * @param recordToUpsert - The record to upsert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.UpsertResult - The result of the upsert operation
     */
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        wasCalled = true;
        return doUpsert(recordToUpsert, allOrNone);
    }

    /**
     * @description doUpsert is used to upsert a list of records into the database
     * @param recordsToUpsert - The records to upsert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @param accessLevel - The access level of the user performing the operation
     * @return List<Database.UpsertResult> - The results of the upsert operations
     */
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        wasCalled = true;
        return doUpsert(recordsToUpsert, allOrNone);
    }

    /**
     * @description doUpsert is used to upsert a record into the database
     * @param recordToUpsert - The record to upsert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @return List<Database.UpsertResult> - The result of the upsert operation
     */
    private List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, Boolean allOrNone) {
        List<Database.UpsertResult> results = new List<Database.UpsertResult>();
        for(SObject record : recordsToUpsert) {
            Database.UpsertResult sr = doUpsert(record, allOrNone);
        }
        return results;
    }
    
    /**
     * @description doUpsert is used to upsert a record into the database
     * @param recordToUpsert - The record to upsert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @return Database.UpsertResult - The result of the upsert operation
     */
    private Database.UpsertResult doUpsert(SObject recordToUpsert, Boolean allOrNone) {
        Database.SaveResult sr;
        if(recordToUpsert.Id != null) {
            sr = doUpdate(recordToUpsert, allOrNone);
        }
        sr = doInsert(recordToUpsert, allOrNone);

        if(sr.isSuccess()) {
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
    private Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(recordToInsert.Id != null) {
            if(allOrNone) {
                throw new DmlException('INVALID_FIELD_FOR_INSERT_UPDATE, cannot specify Id in an insert call: [Id]');
            }
            return (Database.SaveResult) srService.createFailure(
                'Record already exists',
                Database.SaveResult.class
            );
        }

        String objName = SchemaService.getSObjectName(recordToInsert);
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
        recordToInsert = (SObject) JSON.deserialize(JSON.serialize(recordMap), Type.forName(apiName));

        Map<Id, SObject> mockRecords = this.mockObjects.get(objName);
        if(mockRecords == null) {
            mockRecords = new Map<Id, SObject>();
            this.mockObjects.put(objName, mockRecords);
        }
        mockRecords.put(recordToInsert.Id, recordToInsert);
        return (Database.SaveResult) srService.createSuccess(
            recordToInsert.Id,
            Database.SaveResult.class
        ); 
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    private Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        return doInsert(recordToInsert, allOrNone, AccessLevel.USER_MODE);
    }

    /**
     * @description doUpdate is used to update a record in the database
     * @param recordToUpdate - The record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    private Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        Map<String, Object> args = new Map<String, Object> {
            'recordToUpdate' => recordToUpdate,
            'allOrNone' => allOrNone
        };
        Common.nullCheck(args);

        String objName = SchemaService.getSObjectName(recordToUpdate);
        Map<Id, sObject> mockRecords = this.mockObjects.get(objName);

        if (mockRecords == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if (mockRecords.get(recordToUpdate.Id) == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if(mockRecords == null || mockRecords.get(recordToUpdate.Id) == null) {
            return (Database.SaveResult) srService.createFailure(
                'Record does not exist',
                Database.SaveResult.class
            );
        }

        Schema.SObjectType sot = SchemaService.getSObjectType(recordToUpdate);
        
        for(String field : recordToUpdate.getPopulatedFieldsAsMap().keySet()) {
            Schema.SObjectField sObjField = SchemaService.getField(sot, field);
            Schema.DescribeFieldResult sObjFieldDescribe = SchemaService.describeField(sObjField);

            if(!sObjFieldDescribe.isUpdateable()) {
                continue;
            }

            mockRecords.get(recordToUpdate.Id).put(field, recordToUpdate.get(field));
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
}