/**
 * @description DynamicCast is a class that provides a method to cast a value to a specified type. 
 * @author Zackary Frazier
 * @since 11/16/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public with sharing class DynamicCast {
    /**
     * @description Given a type and a value, cast the value to the specified type.
     * @param castTo `String` - ApexTypes
     * @param value `Object`
     * @return  `Object`
     * @exception IllegalArgumentException
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public static Object castTo(String castTo, Object value) {
        if(castTo == ApexTypes.XNULL) {
            throw new IllegalArgumentException('Cannot cast to null');
        }

        if (value == null) {
            return null;
        }

        if (castTo == ApexTypes.XSTRING) {
            return String.valueOf(value);
        } else if (castTo == ApexTypes.XINTEGER) {
            return Integer.valueOf(value);
        } else if (castTo == ApexTypes.XDOUBLE || castTo == ApexTypes.XDECIMAL) {
            return Double.valueOf(value);
        } else if (castTo == ApexTypes.XDATETIME) {
            if(!(value instanceof String)) {
                throw new IllegalArgumentException('For cast to DateTime, value must be a string');
            }
            return DateTime.valueOfGmt((String)value);
        } else if (castTo == ApexTypes.XDATE) {
            if(!(value instanceof String)) {
                throw new IllegalArgumentException('For cast to Date, value must be a string');
            }
            return DateTime.valueOfGmt( ((String) value) + ' 00:00:00').dateGmt();
        } else if (castTo == ApexTypes.XBOOLEAN) {
            return Boolean.valueOf(value);
        } else {
            return value;
        }
    }
}