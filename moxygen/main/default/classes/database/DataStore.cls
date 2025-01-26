/**
 * @description Static data store for records
 * @author Zackary Frazier
 * @since 1/25/2025
 * @group Data Store
 */
public with sharing class DataStore {
    private static Map<SObjectType, Map<Id, SObject>> mockRecords = new Map<SObjectType, Map<Id, SObject>>();
    private static Set<Id> deletedRecords = new Set<Id>();

    /**
     * @description return all SObjects of a given type
     * @param sot The SObjectType to get records for
     * @return Map of records by id for the given object type
     */
    public static Map<Id, SObject> getAllBySot(SObjectType sot) {
        return mockRecords.get(sot);
    }

    /**
     * @description Get a record by id
     * @param recordId Id of the record to get
     * @return The record with the given id
     */
    public static SObject getById(Id recordId) {
        SObjectType sot = SchemaService.getSObjectType(recordId);
        return getAllBySot(sot).get(recordId);
    }

    /**
     * @description Returns whether a record exists in the data store
     * @param recordId Record id to check
     * @return Whether the record exists in the data store
     */
    public static Boolean isRecordInDataStore(Id recordId) {
        return getById(recordId) != null;
    }

    /**
     * @description Count the number of records in the data store
     * @return Number of records in the static data store
     */
    public static Integer count() {
        Integer count = 0;
        for (SObjectType sot : mockRecords.keySet()) {
            count += getAllBySot(sot).size();
        }
        return count;
    }

    /**
     * @description Delete a record from the data store
     * @param recordId The record id
     */
    public static void softDelete(Id recordId) {
        deletedRecords.add(recordId);
    }

    /**
     * @description Undelete a record that was soft deleted in the data store
     * @param recordId Id of the record to undelete
     */
    public static void restore(Id recordId) {
        deletedRecords.remove(recordId);
    }

    /**
     * @description Returns if a record has been deleted
     * @param recordId Id of the record
     * @return Whether the record has been deleted
     */
    public static Boolean isSoftDeleted(Id recordId) {
        return deletedRecords.contains(recordId);
    }

    /**
     * @description Put a record into the data store, or update it if it already exists
     * @param insertedRecord Record to be upserted
     * @exception IllegalArgumentException if the id is null
     */
    public static void put(SObject insertedRecord) {
        if (insertedRecord.Id == null) {
            throw new IllegalArgumentException('Id cannot be null');
        }
        SObjectType sot = SchemaService.getSObjectType(insertedRecord);
        Map<Id, SObject> recordsById = getAllBySot(sot);
        if (recordsById == null) {
            recordsById = new Map<Id, SObject>();
            mockRecords.put(sot, recordsById);
        }
        recordsById.put(insertedRecord.Id, insertedRecord);
    }

    /**
     * @description Put a list of records into the data store, or update them if they already exist
     * @param insertedRecords Records to be upserted
     */
    public static void put(List<SObject> insertedRecords) {
        for (SObject record : insertedRecords) {
            put(record);
        }
    }
}
