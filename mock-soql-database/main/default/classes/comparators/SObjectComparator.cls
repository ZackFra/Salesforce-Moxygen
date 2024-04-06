/**
 * @description This class is used to compare two SObjects based on the fields provided in the constructor.
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class SObjectComparator implements Comparator<SObject> {
    private Map<String, Map<String, String>> fields;

    /**
     * @description Constructor
     * @param fields A map of field names and whether they're ASC or DESC
     */
    public SObjectComparator(Map<String, Map<String, String>> fields) {
        this.fields = fields;
    }

    private Object getFieldValue(SObject sObj, Map<String, String> fieldData) {
        String relationshipName = fieldData.get('relationshipName');
        String fieldApiName = fieldData.get('fieldApiName');

        Object fieldValue;
        if(relationshipName != null) {
            List<String> fieldParts = relationshipName.split('\\.');
            String field = fieldParts[fieldParts.size()-1];
            SObject parentRecord = sObj;
            for(Integer i = 0; i < fieldParts.size()-1; i++) {
                String part = fieldParts[i];
                parentRecord = parentRecord.getSObject(part);
            }
            fieldValue = parentRecord.get(field);
        } else {
            fieldValue = sObj.get(fieldApiName);
        }

        return fieldValue;
    }

    /**
     * @description Check for null values and return the appropriate result, 
     *              returns null if both are not null
     * @param a The first value
     * @param b The second value
     * @param nullDir The direction to sort null values
     * @return Integer
     */
    private Integer checkForNull(Object a, Object b, String nullDir) {
        Boolean isANull = (a == null);
        Boolean isBNull = (b == null);
        Boolean isNullDirFirst = (nullDir == 'first');
        
        Integer nullFirstAdjustment = 1;
        if(!isNullDirFirst) {
            nullFirstAdjustment = -1;
        }

        if(isANull && isBNull) {
            return 0;
        } else if(isANull && !isBNull) {
            return -1 * nullFirstAdjustment;
        } else if(!isANull && isBNull) {
            return 1 * nullFirstAdjustment;
        }

        return null;
    }

    private Integer adjustForOrder(Integer result, String order) {
        if(order == 'desc') {
            return result * -1;
        } else {
            return result;
        }
    }

    /**
     * @description Compare two SObjects based on the fields provided in the constructor
     * @param a The first SObject
     * @param b The second SObject
     * @return Integer
     */
    @SuppressWarnings('PMD.CognitiveComplexity')
    public Integer compare(SObject a, SObject b) {
        for (String field : fields.keySet()) {
            Map<String, String> fieldData = fields.get(field);

            String order = fieldData.get('order');
            String nullDir = fieldData.get('nullDir');

            Object aFieldValue = getFieldValue(a, fieldData);
            Object bFieldValue = getFieldValue(b, fieldData);


            if (aFieldValue != bFieldValue) {
                ObjectComparator comparator = new ObjectComparator();
                Integer result;

                Integer nullResult = checkForNull(aFieldValue, bFieldValue, nullDir);
                if(nullResult != null && nullResult != 0) {
                    return nullResult;
                } else if(nullResult == 0) {
                    continue;
                }

                result = comparator.compare(aFieldValue, bFieldValue);
                if(result == 0) {
                    continue;
                }
                result = adjustForOrder(result, order);
                return result;
            }
        }

        return 0;
    }
}