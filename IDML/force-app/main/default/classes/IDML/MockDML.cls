/**
 * @description MockDML is a mock implementation of the IDML interface. It is used to mock DML operations in 
 *              unit tests.
 */
@IsTest
public inherited sharing class MockDML implements IDML {
    Map<String, Map<Id, SObject>> db = new Map<String, Map<Id, SObject>>();
    Set<Id> deletedRecords = new Set<Id>();
    SaveResultService srService = new SaveResultService();

    /**
     * @description selectDeletedRecordById is used to select a record from the database by its Id. This method
     *             is used to select a record from the database regardless of whether it has been deleted or not.
     * @param recordId - The Id of the record to select
     * @return SObject - The record with the given Id
     */
    public SObject selectDeletedRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        if(!deletedRecords.contains(recordId)) {
            return null;
        }
        return this.db.get(sObjName).get(recordId);
    }

    /**
     * @description selectRecordById is used to select a record from the database by its Id. This method
     *            is used to select a record from the database only if it has not been deleted.
     * @param recordId - The Id of the record to select
     * @return SObject - The record with the given Id
     */
    public SObject selectRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        SObject mockRecord = this.db.get(sObjName).get(recordId);
        if(deletedRecords.contains(recordId)) {
            return null;
        }
        return mockRecord;
    }
    
    /**
     * @description Deletes a record from the mock database
     * @param recordToDelete - The record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone) {
        String sObjName = SchemaService.getSObjectName(recordToDelete);
        Map<Id, SObject> mockRecords = this.db.get(sObjName);
        if(mockRecords == null) {
            if(allOrNone) {
                throw new DmlException('Record does not exist');
            }
            return (Database.DeleteResult) srService.createFailure(
                'Record does not exist',
                Database.DeleteResult.class
            );
        }

        SObject mockRecord = mockRecords.get(recordToDelete.Id);
        if(mockRecord == null) {
            if(allOrNone) {
                throw new DmlException('Record does not exist');
            }
            return (Database.DeleteResult) srService.createFailure(
                'Record does not exist',
                Database.DeleteResult.class
            );
        }

        deletedRecords.add(recordToDelete.Id);

        return (Database.DeleteResult) srService.createSuccess(
            recordToDelete.Id,
            Database.DeleteResult.class
        );
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordsToDelete - The records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(SObject record : recordsToDelete) {
            results.add(doDelete(record, allOrNone));
        }
        return results;
    }

    /**
     * @description doDelete is used to delete a record from the database
     * @param recordID - The Id of the record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        SObject record = selectRecordById(recordID);
        if(record == null) {
            if(allOrNone) {
                throw new DmlException('Record does not exist');
            }
            return (Database.DeleteResult) srService.createFailure(
                'Record does not exist',
                Database.DeleteResult.class
            );
        }
        return doDelete(record, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordIDs - The Ids of the records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(Id recordId : recordIDs) {
            results.add(doDelete(recordId, allOrNone));
        }
        return results;
    }

    /**
     * @description doInsert is used to insert a record into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.SaveResult - The result of the insert operation
     */
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
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

        Map<Id, SObject> mockRecords = this.db.get(objName);
        if(mockRecords == null) {
            mockRecords = new Map<Id, SObject>();
            this.db.put(objName, mockRecords);
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
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        return doInsert(recordToInsert, allOrNone, AccessLevel.USER_MODE);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone));
        }
        return results;
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @param accessLevel - The access level of the user performing the operation
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone, accessLevel));
        }
        return results;
    }

    /**
     * @description doUpdate is used to update a record in the database
     * @param recordToUpdate - The record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        Map<String, Object> args = new Map<String, Object> {
            'recordToUpdate' => recordToUpdate,
            'allOrNone' => allOrNone
        };
        Common.nullCheck(args);

        String objName = SchemaService.getSObjectName(recordToUpdate);
        Map<Id, sObject> mockRecords = this.db.get(objName);

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

        
        for(String field : recordToUpdate.getPopulatedFieldsAsMap().keySet()) {
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

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.SaveResult> - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToUpdate) {
            results.add(doUpdate(record, allOrNone));
        }
        return results;
    }

    /**
     * @description doUpdate is used to update a record in the database
     * @param recordID - The Id of the record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUpdate(recordToUpdate, allOrNone);
    }

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.SaveResult> - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUpdate(recordsToUpdate, allOrNone);
    }

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
     * @description doUpsert is used to upsert a list of records into the database
     * @param recordsToUpsert - The records to upsert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.UpsertResult> - The results of the upsert operations
     */
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return doUpsert(recordToUpsert, allOrNone);
    }

    /**
     * @description doUpsert is used to upsert a list of records into the database
     * @param recordsToUpsert - The records to upsert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.UpsertResult> - The results of the upsert operations
     */
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
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
        return doUpsert(recordsToUpsert, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone) {
        if(!deletedRecords.contains(recordToUndelete.Id)) {
            if(allOrNone) {
                throw new DmlException('Record does not exist');
            }
            return (Database.UndeleteResult) srService.createFailure(
                'Record does not exist',
                Database.UndeleteResult.class
            );
        }
        deletedRecords.remove(recordToUndelete.Id);
        return (Database.UndeleteResult) srService.createSuccess(
            recordToUndelete.Id,
            Database.UndeleteResult.class
        );
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordsToUndelete - The records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public List<Database.UndeleteResult> doUndelete(List<sObject> recordsToUndelete, Boolean allOrNone) {
        List<Database.UndeleteResult> results = new List<Database.UndeleteResult>();
        for(SObject record : recordsToUndelete) {
            results.add(doUndelete(record, allOrNone));
        }
        return results;
    }
    public Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone) {
        SObject recordToUndelete = selectDeletedRecordById(recordID);
        if(recordToUndelete == null) {
            if(allOrNone) {
                throw new DmlException('Record does not exist');
            }
            return (Database.UndeleteResult) srService.createFailure(
                'Record does not exist',
                Database.UndeleteResult.class
            );
        }
        return doUndelete(recordToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordIDs - The Ids of the records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone) {
        List<Database.UndeleteResult> results = new List<Database.UndeleteResult>();
        for(Id recordId : recordIDs) {
            results.add(doUndelete(recordId, allOrNone));
        }
        return results;
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUndelete(recordToUndelete, allOrNone);
    }
}