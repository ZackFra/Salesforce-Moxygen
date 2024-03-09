@IsTest
public inherited sharing class MockDeleteHandler extends MockDMLHandler {

    private SObject selectRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        SObject mockRecord = this.mockObjects.get(sObjName).get(recordId);
        if(deletedRecords.contains(recordId)) {
            return null;
        }
        return mockRecord;
    }

    /** DELETE METHODS  */

    public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone) {
        wasCalled = true;
        String sObjName = SchemaService.getSObjectName(recordToDelete);
        Map<Id, SObject> mockRecords = this.mockObjects.get(sObjName);
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
        wasCalled = true;
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(SObject recordToDelete : recordsToDelete) {
            results.add(doDelete(recordToDelete, allOrNone));
        }
        return results;
    }


    public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        wasCalled = true;
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
        wasCalled = true;
        List<Database.DeleteResult> results = new List<Database.DeleteResult>();
        for(Id recordId : recordIDs) {
            results.add(doDelete(recordId, allOrNone));
        }
        return results;
    }
}