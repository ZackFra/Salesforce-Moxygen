/**
 * @description DML class to handle DML operations, wrapper around Database methods
 *              to allow for mocking and stubbing in unit tests
 *              Note: There is no test class, because there is no consistent way to test this in
 *              a way that would be meaningful. The methods are all wrappers around Database methods
 */
public inherited sharing class DML implements IDML {
    public Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone) {
        return Database.delete(recordToDelete, allOrNone);
    }
    public List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        return Database.delete(recordsToDelete, allOrNone);
    }
    public Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        return Database.delete(recordID, allOrNone);
    }
    public List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        return Database.delete(recordIDs, allOrNone);
    }

    public Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        return Database.insert(recordToInsert, allOrNone);
    }
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        return Database.insert(recordsToInsert, allOrNone);
    }
    public  Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.insert(recordToInsert, allOrNone, accessLevel);
    }
    public List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.insert(recordsToInsert, allOrNone, accessLevel);
    }

    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        return Database.update(recordToUpdate, allOrNone);
    }
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        return Database.update(recordsToUpdate, allOrNone);
    }
    public Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.update(recordToUpdate, allOrNone, accessLevel);
    }
    public List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.update(recordsToUpdate, allOrNone, accessLevel);
    }

    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return Database.upsert(recordToUpsert, externalIdField, allOrNone);
    }
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        return Database.upsert(recordsToUpsert, externalIdField, allOrNone);
    }
    public Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.upsert(recordToUpsert, externalIdField, allOrNone, accessLevel);
    }
    public List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.upsert(recordsToUpsert, externalIdField, allOrNone, accessLevel);
    }

    public  Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone) {
        return Database.undelete(recordToUndelete, allOrNone);
    }
    public List<Database.UndeleteResult> doUndelete(List<sObject> recordsToUndelete, Boolean allOrNone) {
        return Database.undelete(recordsToUndelete, allOrNone);
    }
    public Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone) {
        return Database.undelete(recordID, allOrNone);
    }
    public List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone) {
        return Database.undelete(recordIDs, allOrNone);
    }
    public Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel) {
        return Database.undelete(recordToUndelete, allOrNone, accessLevel);
    }
}