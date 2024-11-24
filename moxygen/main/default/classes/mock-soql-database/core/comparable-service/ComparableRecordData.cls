/**
 * @description Encapsulates the data needed to compare records 
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing class ComparableRecordData {
    private SObject comparableRecord;
    private String comparableFieldName;
    private String relationshipName;
    private Boolean isPolymorphic;

    /**
     * @description Given a record, field, and relationship name, this class will encapsulate the data needed to compare records
     * @param comparableRecord `SObject`
     * @param comparableField `String`
     * @param relationshipName `String`
     */
    public ComparableRecordData(SObject comparableRecord, String comparableField, String relationshipName) {
        this.comparableRecord = comparableRecord;
        this.comparableFieldName = comparableField;
        this.relationshipName = relationshipName;
        this.isPolymorphic = SchemaService.isRelationshipPolymorphic(
            SchemaService.getSObjectType(comparableRecord), 
            relationshipName
        );
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
}