/**
 * @description Encapsulates the data needed to compare records
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing virtual class ComparableRecordData {
    protected SObject comparableRecord;
    protected String comparableFieldName;
    protected String relationshipName;
    protected Boolean isPolymorphic = false;

    /**
     * @description Protected constructor, this object is not intended to be created directly
     */
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected ComparableRecordData() {
    }

    /**
     * @description Get the comparable record
     * @return  `SObject`
     */
    public SObject getComparableRecord() {
        return this.comparableRecord;
    }

    /**
     * @description Get the comparable field name
     * @return  `String`
     */
    public String getComparableFieldName() {
        return this.comparableFieldName;
    }

    /**
     * @description Get the relationship name
     * @return  `String`
     */
    public String getRelationshipName() {
        return this.relationshipName;
    }

    /**
     * @description Get whether the relationship is polymorphic
     * @return  `Boolean`
     */
    public Boolean getIsPolymorphic() {
        return this.isPolymorphic;
    }

    /**
     * @description Builder class for ComparableRecordData
     */
    public class Builder {
        private ComparableRecordData comparableData = new ComparableRecordData();

        /**
         * @description Set the comparable record
         * @param comparableRecord `SObject`
         * @return  `Builder`
         */
        public Builder setComparableRecord(SObject comparableRecord) {
            this.comparableData.comparableRecord = comparableRecord;
            return this;
        }

        /**
         * @description Set the comparable field name
         * @param comparableFieldName `String`
         * @return  `Builder`
         */
        public Builder setComparableFieldName(String comparableFieldName) {
            this.comparableData.comparableFieldName = comparableFieldName;
            return this;
        }

        /**
         * @description Set the relationship name
         * @param relationshipName `String`
         * @return  `Builder`
         */
        public Builder setRelationshipName(String relationshipName) {
            this.comparableData.relationshipName = relationshipName;
            return this;
        }

        /**
         * @description Set whether the relationship is polymorphic
         * @param isPolymorphic `Boolean`
         * @return  `Builder`
         */
        public Builder setIsPolymorphic(Boolean isPolymorphic) {
            this.comparableData.isPolymorphic = isPolymorphic;
            return this;
        }

        /**
         * @description Returns the built object
         * @return  `ComparableRecordData`
         */
        public ComparableRecordData build() {
            return this.comparableData;
        }
    }
}
