/**
 * @description Handles operations specific to SObject, but not comparisons against the Schema
 */
public with sharing class SObjectService {
    /**
     * @description Converts a Map to an SObject
     * @param sObjMap Map<String, Object> - Map to convert to SObject
     * @param sObjApiName String - API Name of the SObject to convert to
     * @return sObject - SObject created from the Map
     */
    public static SObject sObjectFromMap(Map<String, Object> sObjMap, String sObjApiName) {
        sObject sObj = (sObject) JSON.deserialize(JSON.serialize(sObjMap), Type.forName(sObjApiName));
        return sObj;
    }

    /**
     * @description Converts an SObject to a Map
     * @param sObj sObject - SObject to convert to Map
     * @return Map<String, Object> - Map created from the SObject
     */
    public static Map<String, Object> mapFromSObject(sObject sObj) {
        Map<String, Object> sObjMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(sObj));
        return sObjMap;
    }
}