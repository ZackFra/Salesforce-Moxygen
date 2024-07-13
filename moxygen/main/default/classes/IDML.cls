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
 * @description Interface for DML operations
 * @author Zackary Frazier
 * @since 3/9/2024
 */
@SuppressWarnings('PMD.ExcessiveParameterList')
public interface IDML {
    /**
     * @description Deletes a record
     * @param recordToDelete SObject to delete
     * @param allOrNone Boolean to determine if all records should be deleted or none
     * @return  `Database.DeleteResult` object
     */
    Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone);

    /**
     * @description Deletes a list of records
     * @param recordsToDelete Records to delete
     * @param allOrNone Boolean to determine if all records should be deleted or none
     * @return  `List<Database.DeleteResult>`
     */
    List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone);

    /**
     * @description Deletes a record
     * @param recordID ID of the record to delete
     * @param allOrNone Boolean to determine if all records should be deleted or none
     * @return  `Database.DeleteResult`
     */
    Database.DeleteResult doDelete(Id recordID, Boolean allOrNone);

    /**
     * @description Deletes a list of records
     * @param recordIDs Ids of the records to delete
     * @param allOrNone Boolean to determine if all records should be deleted or none
     * @return  `List<Database.DeleteResult>`
     */
    List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone);

    /**
     * @description Inserts a record
     * @param recordToInsert Record to insert
     * @param allOrNone Boolean to determine if all records should be inserted or none
     * @return  `Database.SaveResult`
     */
    Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone);

    /**
     * @description Inserts a list of records
     * @param recordsToInsert Records to insert
     * @param allOrNone Boolean to determine if all records should be inserted or none
     * @return  `List<Database.SaveResult>`
     */
    List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone);

    /**
     * @description Inserts a recordf
     * @param recordToInsert Record to insert
     * @param allOrNone Boolean to determine if all records should be inserted or none
     * @param accessLevel Access level for the record
     * @return  `Database.SaveResult`
     */
    Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel);

    /**
     * @description Inserts a list of records
     * @param recordsToInsert Records to insert
     * @param allOrNone Boolean to determine if all records should be inserted or none
     * @param accessLevel Access level for the record
     * @return  `List<Database.SaveResult>`
     */
    List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel);

    /**
     * @description Updates a record
     * @param recordToUpdate Record to update
     * @param allOrNone Boolean to determine if all records should be updated or none
     * @return  `Database.SaveResult`
     */
    Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone);

    /**
     * @description Updates a list of records
     * @param recordsToUpdate Records to update
     * @param allOrNone Boolean to determine if all records should be updated or none
     * @return  `List<Database.SaveResult>`
     */
    List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone);
    /**
     * @description Updates a record
     * @param recordToUpdate Records to update
     * @param allOrNone Boolean to determine if all records should be updated or none
     * @param accessLevel Access Level for the record
     * @return  `Database.SaveResult`
     */
    Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel);
    
    /**
     * @description Updates a list of records
     * @param recordsToUpdate Records to update
     * @param allOrNone Boolean to determine if all records should be updated or none
     * @param accessLevel Access Level for the record
     * @return  `List<Database.SaveResult>`
     */
    List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel);

    /**
     * @description Upserts a record
     * @param recordToUpsert Record to upsert
     * @param externalIdField Optional external ID field to use for upsert
     * @param allOrNone Boolean to determine if all records should be upserted or none
     * @return  `Database.UpsertResult`
     */
    Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone);
    
    /**
     * @description Upserts a list of records
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional external ID field to use for upsert
     * @param allOrNone Boolean to determine if all records should be upserted or none
     * @return  `List<Database.UpsertResult>`
     */
    List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone);
    /**
     * @description Upserts a record
     * @param recordToUpsert Record to upsert
     * @param externalIdField Optional external ID field to use for upsert
     * @param allOrNone Boolean to determine if all records should be upserted or none
     * @param accessLevel Access Level for the record
     * @return  `Database.UpsertResult`
     */
    Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel);
    
    /**
     * @description Upserts a list of records
     * @param recordsToUpsert Records to upsert
     * @param externalIdField Optional external ID field to use for upsert
     * @param allOrNone Boolean to determine if all records should be upserted or none
     * @param accessLevel Access Level for the record
     * @return  `List<Database.UpsertResult>`
     */
    List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel);

    /**
     * @description Undeletes a record
     * @param recordToUndelete Record to undelete
     * @param allOrNone Boolean to determine if all records should be undeleted or none
     * @return  `Database.UndeleteResult`
     */
    Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone);
    /**
     * @description Undeletes a list of records
     * @param recordsToUndelete Records to undelete
     * @param allOrNone Boolean to determine if all records should be undeleted or none
     * @return  `List<Database.UndeleteResult>`
     */
    List<Database.UndeleteResult> doUndelete(List<SObject> recordsToUndelete, Boolean allOrNone);

    /**
     * @description Undeletes a record
     * @param recordID ID of the record to undelete
     * @param allOrNone Boolean to determine if all records should be undeleted or none
     * @return  `Database.UndeleteResult`
     */
    Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone);

    /**
     * @description Undeletes a list of records
     * @param recordIDs IDs of the records to undelete
     * @param allOrNone Boolean to determine if all records should be undeleted or none
     * @return  `List<Database.UndeleteResult>`
     */
    List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone);
    /**
     * @description Undeletes a record
     * @param recordToUndelete Record to undelete
     * @param allOrNone Boolean to determine if all records should be undeleted or none
     * @param accessLevel Access Level for the record
     * @return  `Database.UndeleteResult`
     */
    Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel);
}