/**
 * @description Common utility class for basic operations, should not contain complex code
 */
public with sharing class Common {
    static final String DATE_PATTERN = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})$';
    static final String DATE_TIME_PATTERN1 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\+([0-9]{2}):([0-9]{2})$';
    static final String DATE_TIME_PATTERN2 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\\-([0-9]{2}):([0-9]{2})$';
    static final String DATE_TIME_PATTERN3 = '^([0-9]{4})\\-([0-9]{2})\\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z$';
    static final String TIME_PATTERN = '^([0-9]{2}):([0-9]{2}):([0-9]{2})\\.([0-9]{3})Z$';

    /**
     * @description Method to check if a field is null
     * @param arg - Argument object containing the field and field name
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
     * @description parse a date string into an SF date
     * @param dateString - date string in the format YYYY-MM-DD
     * @return Date - SF date
     * @throws QueryException if the date string is not in the correct format
     */
    public static Date parseDate(String dateString) {
        Pattern datePattern = Pattern.compile(DATE_PATTERN);
        Matcher dateMatcher = datePattern.matcher(dateString);
        if(!dateMatcher.matches()) {
            throw new IllegalArgumentException('Invalid date format');
        }
        return Date.newInstance(
            Integer.valueOf(dateMatcher.group(1)),
            Integer.valueOf(dateMatcher.group(2)),
            Integer.valueOf(dateMatcher.group(3))
        );
    }

    /**
     * @description parse a date time string into an SF date time
     * @param dateTimeString - date time string in one of the three formats
     * @return DateTime - SF date time
     * @throws QueryException if the date time string is not in the correct format
     */
    public static DateTime parseDateTime(String dateTimeString) {
        // YYYY-MM-DDThh:mm:ss+hh:mm
        Pattern datePattern1 = Pattern.compile(DATE_TIME_PATTERN1);
        Matcher dateMatcher1 = datePattern1.matcher(dateTimeString);
        if(dateMatcher1.matches()) {
            Integer year = Integer.valueOf(dateMatcher1.group(1));
            Integer month = Integer.valueOf(dateMatcher1.group(2));
            Integer day = Integer.valueOf(dateMatcher1.group(3));
            Integer hour = Integer.valueOf(dateMatcher1.group(4));
            Integer min = Integer.valueOf(dateMatcher1.group(5));
            Integer sec = Integer.valueOf(dateMatcher1.group(6));
            Integer offsetHour = Integer.valueOf(dateMatcher1.group(7));
            Integer offsetMin = Integer.valueOf(dateMatcher1.group(8));
            return DateTime.newInstanceGmt(year, month, day, hour, min, sec)
                .addHours(-offsetHour)
                .addMinutes(-offsetMin);
        }
        // YYYY-MM-DDThh:mm:ss-hh:mm
        Pattern datePattern2 = Pattern.compile(DATE_TIME_PATTERN2);
        Matcher dateMatcher2 = datePattern2.matcher(dateTimeString);
        if(dateMatcher2.matches()) {
            Integer year = Integer.valueOf(dateMatcher2.group(1));
            Integer month = Integer.valueOf(dateMatcher2.group(2));
            Integer day = Integer.valueOf(dateMatcher2.group(3));
            Integer hour = Integer.valueOf(dateMatcher2.group(4));
            Integer min = Integer.valueOf(dateMatcher2.group(5));
            Integer sec = Integer.valueOf(dateMatcher2.group(6));
            Integer offsetHour = Integer.valueOf(dateMatcher2.group(7));
            Integer offsetMin = Integer.valueOf(dateMatcher2.group(8));
            return DateTime.newInstanceGmt(year, month, day, hour, min, sec)
                .addHours(offsetHour)
                .addMinutes(offsetMin);
        }
        // YYYY-MM-DDThh:mm:ssZ
        Pattern datePattern3 = Pattern.compile(DATE_TIME_PATTERN3);
        Matcher dateMatcher3 = datePattern3.matcher(dateTimeString);
        if(dateMatcher3.matches()) {
            Integer year = Integer.valueOf(dateMatcher3.group(1));
            Integer month = Integer.valueOf(dateMatcher3.group(2));
            Integer day = Integer.valueOf(dateMatcher3.group(3));
            Integer hour = Integer.valueOf(dateMatcher3.group(4));
            Integer min = Integer.valueOf(dateMatcher3.group(5));
            Integer sec = Integer.valueOf(dateMatcher3.group(6));
            return DateTime.newInstanceGmt(year, month, day, hour, min, sec);
        }

        throw new IllegalArgumentException('Invalid date time format');
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
        if(!timeMatcher.matches()) {
            throw new IllegalArgumentException('Invalid time format');
        }
        return Time.newInstance( 
            Integer.valueOf(timeMatcher.group(1)),
            Integer.valueOf(timeMatcher.group(2)),
            Integer.valueOf(timeMatcher.group(3)),
            Integer.valueOf(timeMatcher.group(4))
        );
    }
}