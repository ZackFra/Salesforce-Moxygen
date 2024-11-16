public with sharing class DynamicCast {
    public static Object castTo(String castTo, Object value) {
        if (value == null) {
            return null;
        }
        if (castTo == ApexTypes.XSTRING) {
            return String.valueOf(value);
        } else if (castTo == ApexTypes.XINTEGER) {
            return Integer.valueOf(value);
        } else if (castTo == ApexTypes.XDOUBLE || castTo == ApexTypes.XDECIMAL) {
            return Double.valueOf(value);
        } else if (castTo == ApexTypes.XDATE) {
            return Date.valueOf(value);
        } else if (castTo == ApexTypes.XDATETIME) {
            return DateTime.valueOf(value);
        } else if (castTo == ApexTypes.XBOOLEAN) {
            return Boolean.valueOf(value);
        } else {
            return value;
        }
    }
}