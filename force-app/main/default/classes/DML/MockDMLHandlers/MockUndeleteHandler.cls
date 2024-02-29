public inherited sharing class MockUndeleteHandler extends MockDMLHandler {
    
    private SObject selectDeletedRecordById(Id recordId) {
        String sObjName = SchemaService.getSObjectName(recordId);
        if(!deletedRecords.contains(recordId)) {
            return null;
        }
        return this.mockObjects.get(sObjName).get(recordId);
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