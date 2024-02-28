public interface IDML {
    Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone);
    List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone);
    Database.DeleteResult doDelete(Id recordID, Boolean allOrNone);
    List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone);

    Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone);
    List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone);
    Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel);
    List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel);

    Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone);
    List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone);
    Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel);
    List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel);

    Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone);
    List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone);
    Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel);
    List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel);

    Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone);
    List<Database.UndeleteResult> doUndelete(List<SObject> recordsToUndelete, Boolean allOrNone);
    Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone);
    List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone);
    Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel);
}