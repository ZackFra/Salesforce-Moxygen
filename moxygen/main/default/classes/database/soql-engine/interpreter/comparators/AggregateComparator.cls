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
 * @description A class to compare two pre-Aggregate based on a set of fields
 *              (a pre-Aggregate is a ProtoAggregate where the keys are the field names and the values are the field values)
 * @group Soql Engine
 */
public with sharing class AggregateComparator implements Comparator<ProtoAggregate> {
    private Map<String, Map<String, String>> fields;

    /**
     * @description Constructor
     * @param fields A map of field names and whether they're ASC or DESC
     */
    public AggregateComparator(Map<String, Map<String, String>> fields) {
        this.fields = fields;
    }

    private Object getFieldValue(
        ProtoAggregate sObj,
        Map<String, String> fieldData
    ) {
        String relationshipName = fieldData.get('relationshipName');
        String fieldApiName = fieldData.get('fieldApiName');

        Object fieldValue;
        if (relationshipName != null) {
            List<String> fieldParts = fieldApiName.split('\\.');
            for (String part : fieldParts) {
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
        if (!isNullDirFirst) {
            nullFirstAdjustment = -1;
        }

        if (isANull && isBNull) {
            return 0;
        } else if (isANull && !isBNull) {
            return -1 * nullFirstAdjustment;
        } else if (!isANull && isBNull) {
            return 1 * nullFirstAdjustment;
        }

        return null;
    }

    private Integer adjustForOrder(Integer result, String order) {
        if (order == 'desc') {
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

                Integer result = checkForNull(
                    aFieldValue,
                    bFieldValue,
                    nullDir
                );
                if (result != null && result != 0) {
                    return result;
                } else if (result == 0) {
                    // If both are null,
                    continue;
                }

                result = comparator.compare(aFieldValue, bFieldValue);
                if (result == 0) {
                    continue;
                }
                result = adjustForOrder(result, order);
                return result;
            }
        }
        return 0;
    }
}
