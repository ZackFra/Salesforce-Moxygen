public with sharing class DynamicCast {
    public static Object castTo(String castTo, Object value) {
        if (value == null) {
            return null;
        }
        if (castTo == 'String') {
            return String.valueOf(value);
        } else if (castTo == 'Integer') {
            return Integer.valueOf(value);
        } else if (castTo == 'Decimal' || castTo == 'Double') {
            return Double.valueOf(value);
        } else if (castTo == 'Date') {
            return Date.valueOf(value);
        } else if (castTo == 'DateTime') {
            return DateTime.valueOf(value);
        } else if (castTo == 'Boolean') {
            return Boolean.valueOf(value);
        } else {
            throw new IllegalArgumentException('Unsupported type for cast');
        }
    }
}