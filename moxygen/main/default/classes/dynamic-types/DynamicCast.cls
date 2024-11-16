public with sharing class DynamicCast {
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
            return DateTime.parse((String)value);
        } else if (castTo == ApexTypes.XDATE) {
            if(!(value instanceof String)) {
                throw new IllegalArgumentException('For cast to Date, value must be a string');
            }
            return Date.parse((String)value);
        } else if (castTo == ApexTypes.XBOOLEAN) {
            return Boolean.valueOf(value);
        } else {
            return value;
        }
    }
}