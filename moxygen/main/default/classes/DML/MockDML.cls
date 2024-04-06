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
 * @description MockDML is a mock implementation of the IDML interface. It is used to mock DML operations in 
 *              unit tests.
 */
@SuppressWarnings('PMD.CognitiveComplexity, PMD.ExcessivePublicCount, PMD.CyclomaticComplexity')
@IsTest
public inherited sharing class MockDML implements IDML {
    @TestVisible
    Map<String, Map<Id, SObject>> mockObjects = new Map<String, Map<Id, SObject>>();
    
    @TestVisible
    Set<Id> deletedRecords = new Set<Id>();

    SaveResultService srService = new SaveResultService();
    
    MockDeleteHandler deleteHandler;
    MockInsertHandler insertHandler;
    MockUpdateHandler updateHandler;
    MockUpsertHandler upsertHandler;
    MockUndeleteHandler undeleteHandler;

    private Map<Types.DML, MockDMLHandler> handlerMap;
    MockDatabase db;

    /**
     * @description MockDML is the constructor for the MockDML class
     */
    public MockDML() {
        resetHandlers();
    }

    public MockDML(MockDatabase db) {
        this.db = db;
        this.mockObjects = db.db;
        resetHandlers();
    }

    /**
     * @description Returns the number of records in the mock database
     * @return Integer - The number of records in the mock database
     */
    public Integer count() {
        Integer count = 0;
        for(String sObjName : mockObjects.keySet()) {
            List<SObject> records = mockObjects.get(sObjName).values();
            count += countRecords(records);
        }
        return count;
    }

    private Integer countRecords(List<SObject> records) {
        Integer count = 0;
        for(SObject record : records) {
            if(!deletedRecords.contains(record.Id)) {
                count++;
            }
        }
        return count;
    }

    /**
     * @description Returns the number of deleted records in the mock database
     * @return Integer - The number of deleted records in the mock database
     */
    public Integer deletedCount() {
        return deletedRecords.size();
    }

    /**
     * @description resetHandlers is used to reset the DML handlers to their default state
     */
    public void resetHandlers() {
        setHandlers();
        setMockObjects(mockObjects);
        setDeletedRecords(deletedRecords);        
    }

    private void setHandlers() {
        this.deleteHandler = new MockDeleteHandler();
        this.insertHandler = new MockInsertHandler();
        this.updateHandler = new MockUpdateHandler();
        this.upsertHandler = new MockUpsertHandler();
        this.undeleteHandler = new MockUndeleteHandler();
        this.handlerMap = new Map<Types.DML, MockDMLHandler> {
            Types.DML.INSERTED => insertHandler,
            Types.DML.UPDATED => updateHandler,
            Types.DML.UPSERTED => upsertHandler,
            Types.DML.DELETED => deleteHandler,
            Types.DML.UNDELETED => undeleteHandler
        };
    }

    private void setMockObjects(Map<String, Map<Id, SObject>> mockObjects) {
        this.mockObjects = mockObjects;
        this.deleteHandler.setMockObjects(mockObjects);
        this.insertHandler.setMockObjects(mockObjects);
        this.updateHandler.setMockObjects(mockObjects);
        this.upsertHandler.setMockObjects(mockObjects);
        this.undeleteHandler.setMockObjects(mockObjects);
    }

    private void setDeletedRecords(Set<Id> deletedRecords) {
        this.deletedRecords = deletedRecords;
        this.deleteHandler.setDeletedRecords(deletedRecords);
        this.insertHandler.setDeletedRecords(deletedRecords);
        this.updateHandler.setDeletedRecords(deletedRecords);
        this.upsertHandler.setDeletedRecords(deletedRecords);
        this.undeleteHandler.setDeletedRecords(deletedRecords);
    }

    /**
     * @description Returns whether a specific DML operation was called
     * @param type - The type of DML operation to check
     * @return Boolean - Whether the DML operation was called
     */
    public Boolean wasCalled(Types.DML type) {
        if(type == null) {
            throw new IllegalArgumentException('Type cannot be null');
        }
        return handlerMap.get(type).wasCalled();
    }

    /**
     * @description Returns whether any DML operation was called
     * @return Boolean - Whether any DML operation was called
     */
    public Boolean wasCalled() {
        for(Types.DML type : Types.DML.values()) {
            if(wasCalled(type)) {
                return true;
            }
        }
        return false;
    }

    /**
     * @description wasDeleted is used to check if a record was deleted from the database
     * @param recordId - The Id of the record to check
     * @return Boolean - Whether the record was deleted
     */
    public Boolean isDeleted(Id recordId) {
        return this.deletedRecords.contains(recordId);
    }

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
        return this.mockObjects.get(sObjName).get(recordId);
    }

    /**
     * @description selectRecordById is used to select a record from the database by its Id. This method
     *            is used to select a record from the database only if it has not been deleted.
     * @param recordId - The Id of the record to select
     * @return SObject - The record with the given Id
     */
    public SObject selectRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        SObject mockRecord = this.mockObjects.get(sObjName).get(recordId);
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
        return deleteHandler.doDelete(recordToDelete, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordsToDelete - The records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        return deleteHandler.doDelete(recordsToDelete, allOrNone);
    }

    /**
     * @description doDelete is used to delete a record from the database
     * @param recordID - The Id of the record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        return deleteHandler.doDelete(recordID, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordIDs - The Ids of the records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        return deleteHandler.doDelete(recordIDs, allOrNone);
    }

    /**
     * @description doMockInsert is used to insert a record into the mock database without setting the `wasCalled` flag
     * @param recordToInsert - The record to insert
     */
    public void doMockInsert(SObject recordToInsert) {
        insertHandler.doMockInsert(recordToInsert);
    }

    /**
     * @description doMockInsert is used to insert a list of records into the mock database without setting the `wasCalled` flag
     * @param recordsToInsert - The records to insert
     */
    public void doMockInsert(List<SObject> recordsToInsert) {
        insertHandler.doMockInsert(recordsToInsert);
    }

    /**
     * @description doInsert is used to insert a record into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.SaveResult - The result of the insert operation
     */
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        return insertHandler.doInsert(recordToInsert, allOrNone, accessLevel);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        return insertHandler.doInsert(recordToInsert, allOrNone);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        return insertHandler.doInsert(recordsToInsert, allOrNone);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @param accessLevel - The access level of the user performing the operation
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        return insertHandler.doInsert(recordsToInsert, allOrNone, accessLevel);
    }

    /**
     * @description doUpdate is used to update a record in the database
     * @param recordToUpdate - The record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        return updateHandler.doUpdate(recordToUpdate, allOrNone);
    }

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return `List<Database.SaveResult>` - The results of the update operations
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        return updateHandler.doUpdate(recordsToUpdate, allOrNone);
    }

    /**
     * @description Updates a record in the mock database
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel AccessLevel of the user performing the operation
     * @return  `Database.SaveResult`
     */
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return updateHandler.doUpdate(recordToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Update a list of records in the mock database
     * @param recordsToUpdate Records to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access Level of the user performing the operation
     * @return  `List<Database.SaveResult>`
     */
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return updateHandler.doUpdate(recordsToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Upserts a record into the mock database
     * @param recordToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external ID
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `Database.UpsertResult`
     */
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return upsertHandler.doUpsert(recordToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Upserts a record in the mock database
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external ID
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `List<Database.UpsertResult>`
     */
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return upsertHandler.doUpsert(recordsToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Upserts a record in the mock database
     * @param recordToUpsert Record to upsert
     * @param externalIdField Optional external ID field
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access level of the user performing the operation
     * @return  `Database.UpsertResult`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return upsertHandler.doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel);
    }

    /**
     * @description Upsert a list of records in the mock database
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional external ID field
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access level of the user performing the operation
     * @return  `List<Database.UpsertResult>`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return upsertHandler.doUpsert(recordsToUpsert, externalIdField, allOrNone, accessLevel);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone) {
        return undeleteHandler.doUndelete(recordToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordsToUndelete - The records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public List<Database.UndeleteResult> doUndelete(List<sObject> recordsToUndelete, Boolean allOrNone) {
        return undeleteHandler.doUndelete(recordsToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordID - The Id of the record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone) {
        return undeleteHandler.doUndelete(recordID, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordIDs - The Ids of the records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone) {
        return undeleteHandler.doUndelete(recordIDs, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel) {
        return undeleteHandler.doUndelete(recordToUndelete, allOrNone, accessLevel);
    }
}