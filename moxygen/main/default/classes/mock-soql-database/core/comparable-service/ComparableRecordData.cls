/**
 * @description Encapsulates the data needed to compare records 
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing virtual class ComparableRecordData {
    protected SObject comparableRecord;
    protected String comparableFieldName;
    protected String relationshipName;
    protected Boolean isPolymorphic;

    /**
     * @description Private constructor, this object is not intended to be created directly
     */
    protected ComparableRecordData() {}

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

    public class Builder implements IBuilder {
        private ComparableRecordData comparableData = new ComparableRecordData();

        public Builder setComparableRecord(SObject comparableRecord) {
            this.comparableData.comparableRecord = comparableRecord;
            return this;
        }

        public Builder setComparableFieldName(String comparableFieldName) {
            this.comparableData.comparableFieldName = comparableFieldName;
            return this;
        }

        public Builder setRelationshipName(String relationshipName) {
            this.comparableData.relationshipName = relationshipName;
            return this;
        }

        public Builder setIsPolymorphic(Boolean isPolymorphic) {
            this.comparableData.isPolymorphic = isPolymorphic;
            return this;
        }

        public ComparableRecordData build() {
            return this.comparableData;
        }

    }
}