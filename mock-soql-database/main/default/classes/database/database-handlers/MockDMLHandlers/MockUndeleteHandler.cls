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
 * @description MockUndeleteHandler is used to mock the Database.UndeleteResult class and the Database.undelete method 
 * @author Zackary Frazier
 * @since 3/9/2024
 */
@IsTest
public inherited sharing class MockUndeleteHandler extends MockDMLHandler {
    
    private SObject selectDeletedRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        if(!deletedRecords.contains(recordId)) {
            return null;
        }
        return MockDatabase.mockRecords.get(sObjName).get(recordId);
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
        String sObjName = SchemaService.getSObjectName(recordToUndelete);
        Map<Id, SObject> mockRecords = MockDatabase.mockRecords.get(sObjName);
        SObject mockRecord = mockRecords.get(recordToUndelete.Id);
        SObject updatedRecord = Common.putReadOnlyField(mockRecord, 'IsDeleted', false);
        mockRecords.put(updatedRecord.Id, updatedRecord);

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

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordID - The Id of the record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     */
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