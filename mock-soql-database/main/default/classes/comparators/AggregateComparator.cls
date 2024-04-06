/**
 * @description A class to compare two pre-Aggregate based on a set of fields
 *              (a pre-Aggregate is a ProtoAggregate where the keys are the field names and the values are the field values)
 */
public with sharing class AggregateComparator implements Comparator<ProtoAggregate>{
    private Map<String, Map<String, String>> fields;

    /**
     * @description Constructor
     * @param fields A map of field names and whether they're ASC or DESC
     */
    public AggregateComparator(Map<String, Map<String, String>> fields) {
        this.fields = fields;
    }

    private Object getFieldValue(ProtoAggregate sObj, Map<String, String> fieldData) {
        String relationshipName = fieldData.get('relationshipName');
        String fieldApiName = fieldData.get('fieldApiName');

        Object fieldValue;
        if(relationshipName != null) {
            List<String> fieldParts = fieldApiName.split('\\.');
            for(String part : fieldParts) {
                fieldValue = sObj.get(part);
            }
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
     * @description Compare two ProtoAggregates based on the fields provided in the constructor
     * @param a The first proto-Aggregate
     * @param b The second proto-Aggregate
     * @return Integer
     */
    @SuppressWarnings('PMD.CognitiveComplexity')
    public Integer compare(ProtoAggregate a, ProtoAggregate b) {
        for (String field : this.fields.keySet()) {

            Map<String, String> fieldData = this.fields.get(field);
            
            String order = (String) fieldData.get('order');
            String nullDir = (String) fieldData.get('nullDir');

            Object aFieldValue = getFieldValue(a, fieldData);
            Object bFieldValue = getFieldValue(b, fieldData);

            if (aFieldValue != bFieldValue) {
                ObjectComparator comparator = new ObjectComparator();
                
                Integer result = checkForNull(aFieldValue, bFieldValue, nullDir);
                if(result != null && result != 0) {
                    return result;
                } else if(result == 0) { // If both are null,
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