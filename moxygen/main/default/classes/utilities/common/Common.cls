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
 * @group Utilities
 */
public with sharing class Common {
    static final String DATE_PATTERN = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})$';
    static final String DATE_TIME_PATTERN1 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\+([0-9]{2}):([0-9]{2})$';
    static final String DATE_TIME_PATTERN2 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\-([0-9]{2}):([0-9]{2})$';
    static final String DATE_TIME_PATTERN3 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z$';
    static final String TIME_PATTERN = '^([0-9]{2}):([0-9]{2}):([0-9]{2})\\.([0-9]{3})Z$';

    /**
     * @description Method to check if a field is null
     * @param args - Argument object containing the field and field name
     * @throws IllegalArgumentException if the field is null
     */
    public static void nullCheck(Map<String, Object> args) {
        Set<String> argNames = args.keySet();
        for (String argName : argNames) {
            Object argValue = args.get(argName);
            if (argValue == null) {
                throw new IllegalArgumentException(
                    'Argument ' + argName + ' cannot be null'
                );
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
    public static SObject putReadOnlyField(
        SObject record,
        String fieldName,
        Object value
    ) {
        Map<String, Object> args = new Map<String, Object>{
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
    public static SObject putReadOnlyFields(
        SObject record,
        Map<String, Object> fieldValuePairs
    ) {
        Map<String, Object> args = new Map<String, Object>{
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
        return (Map<String, Object>) JSON.deserializeUntyped(
            JSON.serialize(record)
        );
    }

    /**
     * @description Converts a Map<String, Object> to an SObject
     * @param recordMap `Map<String, Object>`
     * @param sObjectType `String`
     * @return `SObject`
     */
    public static SObject recordFromMap(
        Map<String, Object> recordMap,
        String sObjectType
    ) {
        return (SObject) JSON.deserialize(
            JSON.serialize(recordMap),
            Type.forName(sObjectType)
        );
    }

    /**
     * @description parse a date string into an SF date. Date.valueOf keeps the
     * written year; Date.newInstance would read it as a Buddhist year for a
     * user with the th_TH locale.
     * @param dateString - date string in the format YYYY-MM-DD
     * @return `Date` - SF date
     * @throws QueryException if the date string is not in the correct format
     */
    public static Date parseDate(String dateString) {
        Pattern datePattern = Pattern.compile(DATE_PATTERN);
        Matcher dateMatcher = datePattern.matcher(dateString);
        if (!dateMatcher.matches()) {
            throw new IllegalArgumentException(
                'Invalid date format: ' + dateString
            );
        }
        return Date.valueOf(dateString);
    }

    /**
     * @description parse a date time string into an SF date time.
     * DateTime.valueOfGmt keeps the written year; DateTime.newInstanceGmt
     * would read it as a Buddhist year for a user with the th_TH locale.
     * @param dateTimeString - date time string in one of the three formats
     * @return DateTime - SF date time
     * @throws QueryException if the date time string is not in the correct format
     */
    public static DateTime parseDateTime(String dateTimeString) {
        // YYYY-MM-DDThh:mm:ss+hh:mm
        Pattern datePattern1 = Pattern.compile(DATE_TIME_PATTERN1);
        Matcher dateMatcher1 = datePattern1.matcher(dateTimeString);
        if (dateMatcher1.matches()) {
            Integer offsetHour = Integer.valueOf(dateMatcher1.group(7));
            Integer offsetMin = Integer.valueOf(dateMatcher1.group(8));
            return gmtDateTimeOf(dateTimeString)
                .addHours(-offsetHour)
                .addMinutes(-offsetMin);
        }
        // YYYY-MM-DDThh:mm:ss-hh:mm
        Pattern datePattern2 = Pattern.compile(DATE_TIME_PATTERN2);
        Matcher dateMatcher2 = datePattern2.matcher(dateTimeString);
        if (dateMatcher2.matches()) {
            Integer offsetHour = Integer.valueOf(dateMatcher2.group(7));
            Integer offsetMin = Integer.valueOf(dateMatcher2.group(8));
            return gmtDateTimeOf(dateTimeString)
                .addHours(offsetHour)
                .addMinutes(offsetMin);
        }
        // YYYY-MM-DDThh:mm:ssZ
        Pattern datePattern3 = Pattern.compile(DATE_TIME_PATTERN3);
        Matcher dateMatcher3 = datePattern3.matcher(dateTimeString);
        if (dateMatcher3.matches()) {
            return gmtDateTimeOf(dateTimeString);
        }

        throw new IllegalArgumentException(
            'Invalid date time format: ' + dateTimeString
        );
    }

    /**
     * @description parse a time string into an SF time
     * @param timeString - time string in the format hh:mm:ss.SSSZ
     * @return Time - SF time
     * @throws IllegalArgumentException if the time string is not in the correct format
     */
    public static Time parseTime(String timeString) {
        Pattern timePattern = Pattern.compile(TIME_PATTERN);
        Matcher timeMatcher = timePattern.matcher(timeString);
        if (!timeMatcher.matches()) {
            throw new IllegalArgumentException(
                'Invalid time format: ' + timeString
            );
        }
        return Time.newInstance(
            Integer.valueOf(timeMatcher.group(1)),
            Integer.valueOf(timeMatcher.group(2)),
            Integer.valueOf(timeMatcher.group(3)),
            Integer.valueOf(timeMatcher.group(4))
        );
    }

    /**
     * @description Returns the GMT date time written in the first 19
     * characters of the string, YYYY-MM-DDThh:mm:ss
     * @param dateTimeString - date time string matching one of the date time
     * patterns
     * @return `DateTime`
     */
    private static DateTime gmtDateTimeOf(String dateTimeString) {
        return DateTime.valueOfGmt(
            dateTimeString.left(19).replace('T', ' ')
        );
    }

    /**
     * @description Converts a date to a SOQL string. The string is built from
     * the stored date rather than from year(), which reads a Buddhist year for
     * a user with the th_TH locale.
     * @param d - Date
     * @return String - SOQL date string
     */
    public static String dateToSoqlString(Date d) {
        return String.valueOf(d);
    }

    /**
     * @description Converts a date time to a SOQL string. The string is built
     * from the stored instant rather than from yearGmt(), which reads a
     * Buddhist year for a user with the th_TH locale.
     * @param dt - DateTime
     * @return String - SOQL date time string
     */
    public static String dateTimeToSoqlString(DateTime dt) {
        return String.valueOfGmt(dt).replace(' ', 'T') + 'Z';
    }

    /**
     * @description Converts a date time to an Apex string. The string is built
     * from the stored instant rather than from yearGmt(), which reads a
     * Buddhist year for a user with the th_TH locale.
     * @param dt - DateTime
     * @return String - Apex date time string
     */
    public static String dateTimeToApexString(DateTime dt) {
        return String.valueOfGmt(dt);
    }
}
