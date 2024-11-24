public with sharing class ComparableRecordData {
    private SObject comparableRecord;
    private String comparableFieldName;
    private String relationshipName;
    private Boolean isPolymorphic;

    public ComparableRecordData(SObject comparableRecord, String comparableField, String relationshipName) {
        this.comparableRecord = comparableRecord;
        this.comparableFieldName = comparableField;
        this.relationshipName = relationshipName;
        this.isPolymorphic = SchemaService.isRelationshipPolymorphic(
            SchemaService.getSObjectType(comparableRecord), 
            relationshipName
        );
    }

    public SObject getComparableRecord() {
        return this.comparableRecord;
    }

    public String getComparableFieldName() {
        return this.comparableFieldName;
    }

    public String getRelationshipName() {
        return this.relationshipName;
    }

    public Boolean getIsPolymorphic() {
        return this.isPolymorphic;
    }
}