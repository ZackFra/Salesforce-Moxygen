/**
 * @description A class to store data about a parent record
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public with sharing virtual class ParentRecordData {
    private String fieldApiName;
    private String fieldRelationshipName;
    private String parentObjApiName;
    private String objApiName;
    private SObject parentRecord;
    private Boolean isPolymorphic;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected ParentRecordData() {
    }

    /**
     * @description Get the field API name
     * @return  `String`
     */
    public String getFieldApiName() {
        return this.fieldApiName;
    }

    /**
     * @description Get the field relationship name
     * @return  `String`
     */
    public String getFieldRelationshipName() {
        return this.fieldRelationshipName;
    }

    /**
     * @description Get the parent object API name
     * @return  `String`
     */
    public String getParentObjApiName() {
        return this.parentObjApiName;
    }

    /**
     * @description Get the object API name
     * @return  `String`
     */
    public String getObjApiName() {
        return this.objApiName;
    }

    /**
     * @description Get the parent record
     * @return  `SObject`
     */
    public SObject getParentRecord() {
        return this.parentRecord;
    }

    /**
     * @description Get if the relationship is polymorphic
     * @return  `Boolean`
     */
    public Boolean getIsPolymorphic() {
        return this.isPolymorphic;
    }

    /**
     * @description Get the parent record Id
     * @return  `Id`
     */
    public Id getParentRecordId() {
        return this.parentRecord.Id;
    }

    /**
     * @description Builder for ParentRecordData
     */
    public class Builder {
        private ParentRecordData parentRecordData = new ParentRecordData();

        /**
         * @description Set the field API name
         * @param fieldApiName
         * @return  `Builder`
         */
        public Builder setFieldApiName(String fieldApiName) {
            this.parentRecordData.fieldApiName = fieldApiName;
            return this;
        }

        /**
         * @description Set the field relationship name
         * @param fieldRelationshipName
         * @return  `Builder`
         */
        public Builder setFieldRelationshipName(String fieldRelationshipName) {
            this.parentRecordData.fieldRelationshipName = fieldRelationshipName;
            return this;
        }

        /**
         * @description Set the parent object API name
         * @param parentObjApiName
         * @return  `Builder`
         */
        public Builder setParentObjApiName(String parentObjApiName) {
            this.parentRecordData.parentObjApiName = parentObjApiName;
            return this;
        }

        /**
         * @description Set the object API name
         * @param objApiName
         * @return  `Builder`
         */
        public Builder setObjApiName(String objApiName) {
            this.parentRecordData.objApiName = objApiName;
            return this;
        }

        /**
         * @description Set the parent record
         * @param parentRecord
         * @return  `Builder`
         */
        public Builder setParentRecord(SObject parentRecord) {
            this.parentRecordData.parentRecord = parentRecord;
            return this;
        }

        /**
         * @description Set if the relationship is polymorphic
         * @param isPolymorphic
         * @return  `Builder`
         */
        public Builder setIsPolymorphic(Boolean isPolymorphic) {
            this.parentRecordData.isPolymorphic = isPolymorphic;
            return this;
        }

        /**
         * @description Build the ParentRecordData
         * @return  `ParentRecordData`
         */
        public ParentRecordData build() {
            return this.parentRecordData;
        }
    }
}
