@IsTest
public with sharing class MockDML implements IDML {
    Map<String, Map<Id, SObject>> db = new Map<String, Map<Id, SObject>>();
    Set<Id> deletedRecords = new Set<Id>();
    SaveResultService srService = new SaveResultService();

    public SObject selectDeletedRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        return this.db.get(sObjName).get(recordId);
    }

    public SObject selectRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        SObject mockRecord = this.db.get(sObjName).get(recordId);
        if(deletedRecords.contains(recordId)) {
            return null;
        }
        return mockRecord;
    }
    
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
    public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(SObject record : recordsToDelete) {
            results.add(doDelete(record, allOrNone));
        }
        return results;
    }
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
    public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(Id recordId : recordIDs) {
            results.add(doDelete(recordId, allOrNone));
        }
        return results;
    }

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

    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        return doInsert(recordToInsert, allOrNone, AccessLevel.USER_MODE);
    }

    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone));
        }
        return results;
    }

    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToInsert) {
            results.add(doInsert(record, allOrNone, accessLevel));
        }
        return results;
    }

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
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        List<Database.SaveResult> results = new List<Database.SaveResult>();
        for(SObject record : recordsToUpdate) {
            results.add(doUpdate(record, allOrNone));
        }
        return results;
    }
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUpdate(recordToUpdate, allOrNone);
    }
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

    // WE ARE NOT SUPPORTING EXTERNAL ID BULLSHIT
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return doUpsert(recordToUpsert, allOrNone);
    }

    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return doUpsert(recordsToUpsert, allOrNone);
    }
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUpsert(recordToUpsert, allOrNone);
    }
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUpsert(recordsToUpsert, allOrNone);
    }

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
    public List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone) {
        List<Database.UndeleteResult> results = new List<Database.UndeleteResult>();
        for(Id recordId : recordIDs) {
            results.add(doUndelete(recordId, allOrNone));
        }
        return results;
    }
    public Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel) {
        return doUndelete(recordToUndelete, allOrNone);
    }
}