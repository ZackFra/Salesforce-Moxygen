/**
 * @description This class is used to compare two generic objects of the same type.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
@SuppressWarnings('PMD.CognitiveComplexity, PMD.StdCyclomaticComplexity, PMD.CyclomaticComplexity')
public with sharing class ObjectComparator implements Comparator<Object> {

    /**
     * @description This method compares two generic objects of the same type.
     * @param obj1 The first object to compare.
     * @param obj2 The second object to compare.
     * @return An integer value indicating the result of the comparison.
     * @throws UnsupportedTypeException: If the type of the objects is not supported.
     */
    @SuppressWarnings('PMD.CognitiveComplexity')
    public Integer compare(Object obj1, Object obj2) {
        if(!isTypeSupported(obj1, obj2)) {
            throw new UnsupportedTypeException('These objects must be of the same type');
        }

        // if no meaningful data can be returned, returns null
        Integer result = compareNull(obj1, obj2);
        if(result != null) {
            return result;
        }

        // if no meaningful data can be returned, returns null
        result = compareSupportedObjects(obj1, obj2);
        if(result != null) {
            return result;
        }
        throw new UnsupportedTypeException('The type of the objects is not supported.');
    }

    private class UnsupportedTypeException extends Exception {}

    @SuppressWarnings('PMD.CognitiveComplexity')
    private Boolean isTypeSupported(Object obj1, Object obj2) {
        if(obj1 == null || obj2 == null) {
            return true;
        } else if(obj1 instanceof Id && obj2 instanceof Id) {
            return true; 
        } else if(obj1 instanceof String && obj2 instanceof String) {
            return true;
        } else if(obj1 instanceof Integer && obj2 instanceof Integer) {
            return true;
        } else if(obj1 instanceof Decimal && obj2 instanceof Decimal) {
            return true;
        } else if(obj1 instanceof Date && obj2 instanceof Date) {
            return true;
        } else if(obj1 instanceof DateTime && obj2 instanceof DateTime) {
            return true;
        } else if(obj1 instanceof Time && obj2 instanceof Time) {
            return true;
        } else if(obj1 instanceof Boolean && obj2 instanceof Boolean) {
            return true;
        }

        return false;
    }

    /**
     * @description This method compares two generic objects of the same type.
     * @param obj1 The first object to compare.
     * @param obj2 The second object to compare.
     * @return An integer value indicating the result of the comparison.
     */
    @SuppressWarnings('PMD.CognitiveComplexity, PMD.NcssMethodCount')
    private Integer compareSupportedObjects(Object obj1, Object obj2) {

        if (obj1 instanceof Id) {
            return ((String)obj1).compareTo((String)obj2);
        } else if (obj1 instanceof String) {
            return ((String)obj1).compareTo((String)obj2);
        } else if (obj1 instanceof Integer) {
            return (Integer)obj1 - (Integer) obj2;
        } else if (obj1 instanceof Decimal) {
            Decimal result = (Decimal) obj1 - (Decimal) obj2;
            if(result == 0) {
                return 0;
            } else if(result > 0) {
                return 1;
            } else {
                return -1;
            }
        } else if (obj1 instanceof Date) {
            Boolean result = ((Date) obj1).isSameDay((Date) obj2);
            if(result) {
                return 0;
            } else if(((Date) obj1) > ((Date) obj2)) {
                return 1;
            } else {
                return -1;
            }
        } else if (obj1 instanceof DateTime) {
            Boolean result = ((DateTime) obj1).isSameDay((DateTime) obj2);
            if(result) {
                return 0;
            } else if(((DateTime) obj1) > ((DateTime) obj2)) {
                return 1;
            } else {
                return -1;
            }
        } else if (obj1 instanceof Time) {
            DateTime dt1 = DateTime.newInstanceGmt(2000, 1, 1, ((Time) obj1).hour(), ((Time) obj1).minute(), ((Time) obj1).second());
            DateTime dt2 = DateTime.newInstanceGmt(2000, 1, 1, ((Time) obj2).hour(), ((Time) obj2).minute(), ((Time) obj2).second());
            Long result = dt1.getTime() - dt2.getTime();
            if(result == 0) {
                return 0;
            } else if(result > 0) {
                return 1;
            } else {
                return -1;
            }
        } else if (obj1 instanceof Boolean) {
            if( ((Boolean)obj1) && ((Boolean)obj2)) {
                return 0;
            } else if((Boolean)obj1) {
                return 1;
            }
            return -1;
        }
        return null;
    }

    /**
     * @description This method compares two generic objects of the same type.
     * @param obj1 The first object to compare.
     * @param obj2 The second object to compare.
     * @return An integer value indicating the result of the comparison.
     */
    private Integer compareNull(Object obj1, Object obj2) {

        if (obj1 == null && obj2 == null) {
            return 0;
        } else if (obj1 == null) {
            return -1;
        } else if (obj2 == null) {
            return 1;
        }
        return null;
    }
}