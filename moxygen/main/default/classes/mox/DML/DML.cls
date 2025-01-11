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
 * @description DML class to handle DML operations, wrapper around Database methods
 *              to allow for mocking and stubbing in unit tests.
 * @group Moxygen
 */
@SuppressWarnings('PMD.ExcessivePublicCount, PMD.CognitiveComplexity, PMD.CyclomaticComplexity')
public inherited sharing class DML {

    final static Integer MAX_DML_CHUNKING = 10;

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToDelete - The record to delete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.DeleteResult - The result of the delete operation
     */
    public static Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doDelete(recordToDelete, allOrNone);
        }
        return Database.delete(recordToDelete, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToDelete - The records to delete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.DeleteResult> - The result of the delete operation
     */
    public static List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doDelete(recordsToDelete, allOrNone);
        }
        sortToPreventChunkingErrors(recordsToDelete);
        return Database.delete(recordsToDelete, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordID - The ID of the record to delete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.DeleteResult - The result of the delete operation
     */
    public static Database.DeleteResult doDelete(Id recordID, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doDelete(recordID, allOrNone);
        }
        return Database.delete(recordID, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordIDs - The IDs of the records to delete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.DeleteResult> - The result of the delete operation
     */
    public static List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doDelete(recordIDs, allOrNone);
        }
        return Database.delete(recordIDs, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToInsert - The record to insert
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.SaveResult - The result of the insert operation
     */
    public static Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doInsert(recordToInsert, allOrNone);
        }
        return Database.insert(recordToInsert, allOrNone);
    }
    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToInsert - The records to insert
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.SaveResult> - The result of the insert operation
     */
    public static List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doInsert(recordsToInsert, allOrNone);
        }
        sortToPreventChunkingErrors(recordsToInsert);
        return Database.insert(recordsToInsert, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToInsert - The record to insert
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return Database.SaveResult - The result of the update operation
     */
    public static  Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doInsert(recordToInsert, allOrNone, accessLevel);
        }
        return Database.insert(recordToInsert, allOrNone, accessLevel);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToInsert - The records to insert
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return List<Database.SaveResult> - The result of the update operation
     */
    public static List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doInsert(recordsToInsert, allOrNone, accessLevel);
        }
        sortToPreventChunkingErrors(recordsToInsert);
        return Database.insert(recordsToInsert, allOrNone, accessLevel);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToUpdate - The record to update
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.SaveResult - The result of the update operation
     */
    public static Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpdate(recordToUpdate, allOrNone);
        }
        return Database.update(recordToUpdate, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToUpdate - The records to update
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.SaveResult> - The result of the update operation
     */
    public static List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpdate(recordsToUpdate, allOrNone);
        }
        sortToPreventChunkingErrors(recordsToUpdate);
        return Database.update(recordsToUpdate, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToUpdate - The record to update
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return Database.SaveResult - The result of the update operation
     */
    public static Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpdate(recordToUpdate, allOrNone, accessLevel);
        }
        return Database.update(recordToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToUpdate - The records to update
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return List<Database.SaveResult> - The result of the update operation
     */
    public static List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpdate(recordsToUpdate, allOrNone, accessLevel);
        }
        sortToPreventChunkingErrors(recordsToUpdate);
        return Database.update(recordsToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToUpsert - The record to upsert
     * @param externalIdField - The field to use as the external ID
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.UpsertResult - The result of the upsert operation
     */
    public static Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpsert(recordToUpsert, externalIdField, allOrNone);
        }
        return Database.upsert(recordToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToUpsert - The records to upsert
     * @param externalIdField - The field to use as the external ID
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.UpsertResult> - The result of the upsert operation
     */
    public static List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpsert(recordsToUpsert, externalIdField, allOrNone);
        }
        sortToPreventChunkingErrors(recordsToUpsert);
        return Database.upsert(recordsToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToUpsert - The record to upsert
     * @param externalIdField - The field to use as the external ID
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return Database.UpsertResult - The result of the upsert operation
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpsert(recordToUpsert, externalIdField, allOrNone, accessLevel);
        }
        return Database.upsert(recordToUpsert, externalIdField, allOrNone, accessLevel);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToUpsert - The records to upsert
     * @param externalIdField - The field to use as the external ID
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return List<Database.UpsertResult> - The result of the upsert operation
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUpsert(recordsToUpsert, externalIdField, allOrNone, accessLevel);
        }
        sortToPreventChunkingErrors(recordsToUpsert);
        return Database.upsert(recordsToUpsert, externalIdField, allOrNone, accessLevel);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public static  Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUndelete(recordToUndelete, allOrNone);
        }
        return Database.undelete(recordToUndelete, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordsToUndelete - The records to undelete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.UndeleteResult> - The result of the undelete operation
     */
    public static List<Database.UndeleteResult> doUndelete(List<SObject> recordsToUndelete, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUndelete(recordsToUndelete, allOrNone);
        }
        sortToPreventChunkingErrors(recordsToUndelete);
        return Database.undelete(recordsToUndelete, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordID - The ID of the record to undelete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public static Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUndelete(recordID, allOrNone);
        }
        return Database.undelete(recordID, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordIDs - The IDs of the records to undelete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @return List<Database.UndeleteResult> - The result of the undelete operation
     */
    public static List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUndelete(recordIDs, allOrNone);
        }
        return Database.undelete(recordIDs, allOrNone);
    }

    /**
     * @description Wrapper around Database methods to allow for mocking and stubbing in unit tests
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - If true, the operation is an all-or-none operation. If false, the operation allows partial success.
     * @param accessLevel - The access level for the operation
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public static Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel) {
        if(ORM.isUnitTest()) {
            return MockDatabase.doUndelete(recordToUndelete, allOrNone, accessLevel);
        }
        return Database.undelete(recordToUndelete, allOrNone, accessLevel);
    }

    @TestVisible
    private static void doMockInsert(SObject recordToInsert) {
        ORM.validateUnitTestContext();
        MockDatabase.doMockInsert(recordToInsert);
    } 

    @TestVisible 
    private static void doMockInsert(List<SObject> recordsToInsert) {
        ORM.validateUnitTestContext();
        MockDatabase.doMockInsert(recordsToInsert);
    }

    /**
     * @description Returns whether any DML operation was called 
     * @return  `Boolean`
     */
    @TestVisible
    private static Boolean didAnyDML() {
        ORM.validateUnitTestContext();
        return MockDatabase.dmlHandler.wasCalled();
    }

    /**
     * @description Returns whether a specific DML operation was called
     * @param dmlType 
     * @return  `Boolean`
     */
    @TestVisible
    private static Boolean didDML(Types.DML dmlType) {
        ORM.validateUnitTestContext();
        return MockDatabase.dmlHandler.wasCalled(dmlType);
    }

    /**
     * @description Methods taken from James Simone's blog post on mocking DML operations
     * @param records `List<SObject>`
     */
    private static void sortToPreventChunkingErrors(List<SObject> records) {
        // prevents a chunking error that can occur if SObject types are in the list out of order.
        // no need to sort if the list size is below the limit
        if (records.size() >= MAX_DML_CHUNKING) {
          records.sort();
        }
      }
}