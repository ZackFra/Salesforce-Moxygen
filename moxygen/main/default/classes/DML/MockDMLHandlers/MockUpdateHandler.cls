@IsTest
public inherited sharing class MockUpdateHandler extends MockDMLHandler {
    /**
     * @description doUpdate is used to update a record in the database
     * @param recordToUpdate - The record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        wasCalled = true;
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

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.SaveResult> - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        wasCalled = true;
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
        wasCalled = true;
        return doUpdate(recordToUpdate, allOrNone);
    }

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.SaveResult> - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        wasCalled = true;
        return doUpdate(recordsToUpdate, allOrNone);
    }
}