/**
 * @description Contains the results of a where logic comparison 
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public virtual class WhereLogicComparisonResults {
    
    Object recordFieldValue;
    String finalField;
    Boolean isPolymorphicTypeField = false;
    SObject parentRecord;

    /**
     * @description protected constructor
     */
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected WhereLogicComparisonResults() {}

    /**
     * @description Get the record field value 
     * @return  `Object`
     */
    public Object getRecordFieldValue() {
        return recordFieldValue;
    }

    /**
     * @description Get the final field 
     * @return  `String`
     */
    public String getFinalField() {
        return finalField;
    }

    /**
     * @description Get if the field is "THE" polymorphic type field 
     * @return  `Boolean`
     */
    public Boolean getIsPolymorphicTypeField() {
        return isPolymorphicTypeField;
    }

    /**
     * @description Get the parent record 
     * @return  `SObject`
     */
    public SObject getParentRecord() {
        return parentRecord;
    }

    /**
     * @description Builder class for WhereLogicComparisonResults
     */
    public class Builder implements IBuilder {
        WhereLogicComparisonResults results = new WhereLogicComparisonResults();
        /**
         * @description Set the final field
         * @param finalField 
         * @return  `Builder`
         */
        public Builder setFinalField(String finalField) {
            results.finalField = finalField;
            return this;
        }

        /**
         * @description Set the record field value
         * @param recordFieldValue 
         * @return  `Builder`
         */
        public Builder setRecordFieldValue(Object recordFieldValue) {
            results.recordFieldValue = recordFieldValue;
            return this;
        }

        /**
         * @description Set if the field is "THE" polymorphic type field
         * @param isPolymorphicTypeField 
         * @return  `Builder`
         */
        public Builder setIsPolymorphicTypeField(Boolean isPolymorphicTypeField) {
            results.isPolymorphicTypeField = isPolymorphicTypeField;
            return this;
        }

        /**
         * @description Set the parent record
         * @param parentRecord 
         * @return  `Builder`
         */
        public Builder setParentRecord(SObject parentRecord) {
            results.parentRecord = parentRecord;
            return this;
        }

        /**
         * @description Build the `WhereLogicComparisonResults` 
         * @return  `WhereLogicComparisonResults`
         */
        public WhereLogicComparisonResults build() {
            return results;
        }
    }
}