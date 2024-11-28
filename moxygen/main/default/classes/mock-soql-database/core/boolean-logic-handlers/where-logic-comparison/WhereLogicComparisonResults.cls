public virtual class WhereLogicComparisonResults {
    
    Object recordFieldValue;
    String finalField;
    Boolean isPolymorphicTypeField = false;
    SObject parentRecord;

    /**
     * @description protected constructor
     */
    protected WhereLogicComparisonResults() {}

    public Object getRecordFieldValue() {
        return recordFieldValue;
    }

    public String getFinalField() {
        return finalField;
    }

    public Boolean getIsPolymorphicTypeField() {
        return isPolymorphicTypeField;
    }

    public SObject getParentRecord() {
        return parentRecord;
    }

    public class Builder implements IBuilder {
        WhereLogicComparisonResults results = new WhereLogicComparisonResults();
        public Builder setFinalField(String finalField) {
            results.finalField = finalField;
            return this;
        }

        public Builder setRecordFieldValue(Object recordFieldValue) {
            results.recordFieldValue = recordFieldValue;
            return this;
        }

        public Builder setIsPolymorphicTypeField(Boolean isPolymorphicTypeField) {
            results.isPolymorphicTypeField = isPolymorphicTypeField;
            return this;
        }

        public Builder setParentRecord(SObject parentRecord) {
            results.parentRecord = parentRecord;
            return this;
        }

        public WhereLogicComparisonResults build() {
            return results;
        }
    }
}