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
 * @description The MockDatabase class is used to simulate the Salesforce database in Apex unit tests
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Mock Database
 */
@SuppressWarnings(
    'PMD.CognitiveComplexity, PMD.CyclomaticComplexity, PMD.StdCyclomaticComplexity, PMD.ExcessivePublicCount'
)
public inherited sharing class MockDatabase {
    public static DmlEngine dmlHandler = new DmlEngine();
    public static SoqlEngine soqlHandler = new SoqlEngine();

    public static MockDatabaseUtils utils = new MockDatabaseUtils();

    /** Utility methods (For Testing) */

    /**
     * @description Reset the DML handlers call state
     */
    public static void resetHandlers() {
        dmlHandler.resetHandlers();
    }

    /**
     * @description wasDeleted is used to check if a record was deleted from the database
     * @param recordId - The Id of the record to check
     * @return Boolean - Whether the record was deleted
     */
    public static Boolean isDeleted(Id recordId) {
        SObject record = utils.findRecord(recordId);
        return (record.get('IsDeleted') == true);
    }

    /**
     * @description Returns the deleted record by Id
     * @param recordId
     * @return  `SObject`
     */
    public static SObject selectRecordById(Id recordId) {
        return utils.findRecord(recordId);
    }

    /** DML methods **/

    /**
     * @description doMockInsert is used to insert a record into the mock database without setting the `wasCalled` flag
     * @param recordToInsert - The record to insert
     */
    public static void doMockInsert(SObject recordToInsert) {
        dmlHandler.doMockInsert(recordToInsert);
    }

    /**
     * @description doMockInsert is used to insert a list of records into the mock database without setting the `wasCalled` flag
     * @param recordsToInsert - The records to insert
     */
    public static void doMockInsert(List<SObject> recordsToInsert) {
        dmlHandler.doMockInsert(recordsToInsert);
    }

    /**
     * @description Deletes a record from the mock database
     * @param recordToDelete - The record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public static Database.DeleteResult doDelete(
        SObject recordToDelete,
        Boolean allOrNone
    ) {
        return dmlHandler.doDelete(recordToDelete, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordsToDelete - The records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public static List<Database.DeleteResult> doDelete(
        List<SObject> recordsToDelete,
        Boolean allOrNone
    ) {
        return dmlHandler.doDelete(recordsToDelete, allOrNone);
    }

    /**
     * @description doDelete is used to delete a record from the database
     * @param recordID - The Id of the record to delete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.DeleteResult - The result of the delete operation
     */
    public static Database.DeleteResult doDelete(
        Id recordID,
        Boolean allOrNone
    ) {
        return dmlHandler.doDelete(recordID, allOrNone);
    }

    /**
     * @description doDelete is used to delete a list of records from the database
     * @param recordIDs - The Ids of the records to delete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.DeleteResult> - The results of the delete operations
     */
    public static List<Database.DeleteResult> doDelete(
        List<Id> recordIDs,
        Boolean allOrNone
    ) {
        return dmlHandler.doDelete(recordIDs, allOrNone);
    }

    /**
     * @description doInsert is used to insert a record into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if the record already exists
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.SaveResult - The result of the insert operation
     */
    public static Database.SaveResult doInsert(
        SObject recordToInsert,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doInsert(recordToInsert, allOrNone, accessLevel);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordToInsert - The record to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public static Database.SaveResult doInsert(
        SObject recordToInsert,
        Boolean allOrNone
    ) {
        return dmlHandler.doInsert(recordToInsert, allOrNone);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public static List<Database.SaveResult> doInsert(
        List<SObject> recordsToInsert,
        Boolean allOrNone
    ) {
        return dmlHandler.doInsert(recordsToInsert, allOrNone);
    }

    /**
     * @description doInsert is used to insert a list of records into the database
     * @param recordsToInsert - The records to insert
     * @param allOrNone - Whether to throw an exception if any of the records already exist
     * @param accessLevel - The access level of the user performing the operation
     * @return List<Database.SaveResult> - The results of the insert operations
     */
    public static List<Database.SaveResult> doInsert(
        List<SObject> recordsToInsert,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doInsert(recordsToInsert, allOrNone, accessLevel);
    }

    /**
     * @description doUpdate is used to update a record in the database
     * @param recordToUpdate - The record to update
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.SaveResult - The result of the update operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public static Database.SaveResult doUpdate(
        SObject recordToUpdate,
        Boolean allOrNone
    ) {
        return dmlHandler.doUpdate(recordToUpdate, allOrNone);
    }

    /**
     * @description doUpdate is used to update a list of records in the database
     * @param recordsToUpdate - The records to update
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return `List<Database.SaveResult>` - The results of the update operations
     */
    public static List<Database.SaveResult> doUpdate(
        List<SObject> recordsToUpdate,
        Boolean allOrNone
    ) {
        return dmlHandler.doUpdate(recordsToUpdate, allOrNone);
    }

    /**
     * @description Updates a record in the mock database
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel AccessLevel of the user performing the operation
     * @return  `Database.SaveResult`
     */
    public static Database.SaveResult doUpdate(
        SObject recordToUpdate,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doUpdate(recordToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Update a list of records in the mock database
     * @param recordsToUpdate Records to update
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @param accessLevel Access Level of the user performing the operation
     * @return  `List<Database.SaveResult>`
     */
    public static List<Database.SaveResult> doUpdate(
        List<SObject> recordsToUpdate,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doUpdate(recordsToUpdate, allOrNone, accessLevel);
    }

    /**
     * @description Upserts a record into the mock database
     * @param recordToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external ID
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `Database.UpsertResult`
     */
    public static Database.UpsertResult doUpsert(
        SObject recordToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone
    ) {
        return dmlHandler.doUpsert(recordToUpsert, externalIdField, allOrNone);
    }

    /**
     * @description Upserts a record in the mock database
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional field to use as the external ID
     * @param allOrNone Boolean to throw an exception if the record does not exist
     * @return  `List<Database.UpsertResult>`
     */
    public static List<Database.UpsertResult> doUpsert(
        List<SObject> recordsToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone
    ) {
        return dmlHandler.doUpsert(recordsToUpsert, externalIdField, allOrNone);
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
    public static Database.UpsertResult doUpsert(
        SObject recordToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doUpsert(
            recordToUpsert,
            externalIdField,
            allOrNone,
            accessLevel
        );
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
    public static List<Database.UpsertResult> doUpsert(
        List<SObject> recordsToUpsert,
        SObjectField externalIdField,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doUpsert(
            recordsToUpsert,
            externalIdField,
            allOrNone,
            accessLevel
        );
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     * @throws DmlException - If the record does not exists and allOrNone is true
     */
    public static Database.UndeleteResult doUndelete(
        sObject recordToUndelete,
        Boolean allOrNone
    ) {
        return dmlHandler.doUndelete(recordToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordsToUndelete - The records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public static List<Database.UndeleteResult> doUndelete(
        List<sObject> recordsToUndelete,
        Boolean allOrNone
    ) {
        return dmlHandler.doUndelete(recordsToUndelete, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordID - The Id of the record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public static Database.UndeleteResult doUndelete(
        Id recordID,
        Boolean allOrNone
    ) {
        return dmlHandler.doUndelete(recordID, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a list of records from the database
     * @param recordIDs - The Ids of the records to undelete
     * @param allOrNone - Whether to throw an exception if any of the records do not exist
     * @return List<Database.UndeleteResult> - The results of the undelete operations
     * @throws DmlException - If any of the records do not exists and allOrNone is true
     */
    public static List<Database.UndeleteResult> doUndelete(
        List<Id> recordIDs,
        Boolean allOrNone
    ) {
        return dmlHandler.doUndelete(recordIDs, allOrNone);
    }

    /**
     * @description doUndelete is used to undelete a record from the database
     * @param recordToUndelete - The record to undelete
     * @param allOrNone - Whether to throw an exception if the record does not exist
     * @param accessLevel - The access level of the user performing the operation
     * @return Database.UndeleteResult - The result of the undelete operation
     */
    public static Database.UndeleteResult doUndelete(
        SObject recordToUndelete,
        Boolean allOrNone,
        System.AccessLevel accessLevel
    ) {
        return dmlHandler.doUndelete(recordToUndelete, allOrNone, accessLevel);
    }

    /** SOQL methods **/

    /**
     * @description Internal method to handle the select query
     * @param head `Node`
     * @param params `Map<String, Object>`
     * @return  `List<SObject>`
     */
    public static List<SObject> doSelectQueryInternal(
        Node head,
        Map<String, Object> params
    ) {
        return soqlHandler.doSelectQueryInternal(head, params);
    }

    /**
     * @description This method is used to query the mock database by traversing the AST
     * @param query : the query string
     * @return : the query results
     */
    public static List<SObject> query(String query) {
        return soqlHandler.query(query);
    }

    /**
     * @description Query the database for records, with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public static List<SObject> query(
        String query,
        System.AccessLevel accessLevel
    ) {
        return soqlHandler.query(query, accessLevel);
    }

    /**
     * @description Query the database for records, with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<SObject>`
     */
    public static List<SObject> queryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return soqlHandler.queryWithBinds(
            query,
            lowercaseParams(binds),
            accessLevel
        );
    }

    /**
     * @description Perform a count query
     * @param query `String`
     * @return  `Integer`
     */
    public static Integer countQuery(String query) {
        return soqlHandler.countQuery(query);
    }

    /**
     * @description Perform a count query with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public static Integer countQuery(
        String query,
        System.AccessLevel accessLevel
    ) {
        return soqlHandler.countQuery(query, accessLevel);
    }

    /**
     * @description Perform a count query with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `Integer`
     */
    public static Integer countQueryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return soqlHandler.countQueryWithBinds(
            query,
            lowercaseParams(binds),
            accessLevel
        );
    }

    /**
     * @description Perform an aggregate query
     * @param query `String`
     * @return  `List<Aggregate>`
     */
    public static List<Aggregate> aggregateQuery(String query) {
        return soqlHandler.aggregateQuery(query);
    }

    /**
     * @description Perform an aggregate query with access level
     * @param query `String`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public static List<Aggregate> aggregateQuery(
        String query,
        System.AccessLevel accessLevel
    ) {
        return soqlHandler.aggregateQuery(query, accessLevel);
    }

    /**
     * @description Perform an aggregate query with binds
     * @param query `String`
     * @param binds `Map<String, Object>`
     * @param accessLevel `System.AccessLevel`
     * @return  `List<Aggregate>`
     */
    public static List<Aggregate> aggregateQueryWithBinds(
        String query,
        Map<String, Object> binds,
        System.AccessLevel accessLevel
    ) {
        return soqlHandler.aggregateQueryWithBinds(
            query,
            lowercaseParams(binds),
            accessLevel
        );
    }

    private static Map<String, Object> lowercaseParams(
        Map<String, Object> params
    ) {
        Map<String, Object> lowerCaseParams = new Map<String, Object>();
        for (String key : params.keySet()) {
            lowerCaseParams.put(key.toLowerCase(), params.get(key));
        }
        return lowerCaseParams;
    }

    /**
     * @description Given a record and a field, return the parent record (i.e. the record that field looks up to)
     * @param sObj : the record
     * @param fieldName : the field name
     * @return : the parent record
     * @throws QueryException : if the parent record does not exist
     */
    public static ParentRecordData findParentRecord(
        sObject sObj,
        String fieldName
    ) {
        return utils.findParentRecord(sObj, fieldName);
    }
}
