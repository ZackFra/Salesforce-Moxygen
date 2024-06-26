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