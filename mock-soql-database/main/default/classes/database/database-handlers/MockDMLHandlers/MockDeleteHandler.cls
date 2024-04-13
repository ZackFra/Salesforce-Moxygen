/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (ttabasehe "Software"), to deal
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
 * @description MockDeleteHandler is a class that extends MockDMLHandler and overrides the delete methods to simulate the delete operation
 * @author Zackary Frazier
 * @since 3/9/2024
 */
@IsTest
public inherited sharing class MockDeleteHandler extends MockDMLHandler {

    private SObject selectRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        SObject mockRecord = MockDatabase.mockRecords.get(sObjName).get(recordId);
        if(deletedRecords.contains(recordId)) {
            return null;
        }
        return mockRecord;
    }

    /** DELETE METHODS  **/

    /**
     * @description Deletes a record
     * @param recordToDelete Record to delete
     * @param allOrNone Boolean to indicate if all records should be deleted or none
     * @return  `Database.DeleteResult`
     * @exception DmlException
     */
    public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone) {
        wasCalled = true;
        String sObjName = SchemaService.getSObjectName(recordToDelete);
        Map<Id, SObject> mockRecords = MockDatabase.mockRecords.get(sObjName);
        if(mockRecords == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if(mockRecords == null) {
            return (Database.DeleteResult) srService.createFailure(
                'Record does not exist',
                Database.DeleteResult.class
            );
        }

        SObject mockRecord = mockRecords.get(recordToDelete.Id);
        if(mockRecord == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if(mockRecord == null) {
            return (Database.DeleteResult) srService.createFailure(
                'Record does not exist',
                Database.DeleteResult.class
            );
        }

        deletedRecords.add(recordToDelete.Id);
        
        SObject updatedRecord = Common.putReadOnlyField(mockRecord, 'IsDeleted', true);
        mockRecords.put(updatedRecord.Id, updatedRecord);

        return (Database.DeleteResult) srService.createSuccess(
            recordToDelete.Id,
            Database.DeleteResult.class
        );
    }
    /**
     * @description Deletes a list of records
     * @param recordsToDelete Records to delete
     * @param allOrNone Boolean to indicate if an exception should be thrown if any record fails to delete
     * @return  `List<Database.DeleteResult>`
     * @exception DmlException
     */
    public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        wasCalled = true;
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(SObject recordToDelete : recordsToDelete) {
            results.add(doDelete(recordToDelete, allOrNone));
        }
        return results;
    }

    /**
     * @description Deletes a record by ID
     * @param recordID Id of the record to delete
     * @param allOrNone Boolean to indicate if an exception should be thrown if the record fails to delete
     * @return  `Database.DeleteResult`
     * @exception DMLException
     */
    public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        wasCalled = true;
        SObject record = selectRecordById(recordID);
        if(record == null && allOrNone) {
            throw new DmlException('Record does not exist');
        } else if(record == null) {
            return (Database.DeleteResult) srService.createFailure(
                'Record does not exist',
                Database.DeleteResult.class
            );
        }
        return doDelete(record, allOrNone);
    }
    /**
     * @description Deletes a list of records by ID
     * @param recordIDs List of record IDs to delete
     * @param allOrNone Boolean to indicate if an exception should be thrown if any record fails to delete
     * @return  `List<Database.DeleteResult>`
     * @exception DMLException
     */
    public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        wasCalled = true;
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(Id recordId : recordIDs) {
            results.add(doDelete(recordId, allOrNone));
        }
        return results;
    }
}