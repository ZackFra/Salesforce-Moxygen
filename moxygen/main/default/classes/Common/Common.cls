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
 * @description Common utility class for basic operations, should not contain complex code
 * @author Zackary Frazier
 * @since 3/22/2024
 */
public inherited sharing class Common {

    /**
     * @description Method to check if a field is null
     * @param args - Argument object containing the field and field name
     * @throws IllegalArgumentException if the field is null
     */
    public static void nullCheck(Map<String, Object> args) {
        Set<String> argNames = args.keySet();
        for(String argName : argNames) {
            Object argValue = args.get(argName);
            if(argValue == null) {
                throw new IllegalArgumentException('Argument ' + argName + ' cannot be null');
            }
        }
    }

    /**
     * @description Puts a value into a read-only field of an SObject
     * @param record `SObject`
     * @param fieldName `String`
     * @param value `Object`
     * @return  `SObject`
     */
    public static SObject putReadOnlyField(SObject record, String fieldName, Object value) {
        Map<String, Object> args = new Map<String, Object> {
            'record' => record,
            'fieldName' => fieldName
        };
        nullCheck(args);
        Map<String, Object> recordMap = mapFromRecord(record);
        recordMap.put(fieldName, value);
        return recordFromMap(recordMap, SchemaService.getSObjectName(record));
    }

    /**
     * @description Puts a map of values into read-only fields of an SObject
     * @param record `SObject`
     * @param fieldValuePairs `Map<String, Object>`
     * @return  `SObject`
     */
    public static SObject putReadOnlyFields(SObject record, Map<String, Object> fieldValuePairs) {
        Map<String, Object> args = new Map<String, Object> {
            'record' => record,
            'fieldValuePairs' => fieldValuePairs
        };
        nullCheck(args);
        Map<String, Object> recordMap = mapFromRecord(record);
        recordMap.putAll(fieldValuePairs);
        return recordFromMap(recordMap, SchemaService.getSObjectName(record));
    }

    /**
     * @description Converts an SObject to a map
     * @param record `SObject`
     * @return  `Map<String, Object>`
     */
    public static Map<String, Object> mapFromRecord(SObject record) {
        return (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(record));
    }

    /**
     * @description Converts a Map<String, Object> to an SObject
     * @param recordMap `Map<String, Object>`
     * @param sObjectType `String`
     * @return `SObject`
     */
    public static SObject recordFromMap(Map<String, Object> recordMap, String sObjectType) {
        return (SObject) JSON.deserialize(JSON.serialize(recordMap), Type.forName(sObjectType));
    }
}