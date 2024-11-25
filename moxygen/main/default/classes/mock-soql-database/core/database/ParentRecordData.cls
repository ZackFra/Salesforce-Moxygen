public with sharing virtual class ParentRecordData {
    private String fieldApiName;
    private String fieldRelationshipName;
    private String parentObjApiName;
    private String objApiName;
    private SObject parentRecord;
    private Boolean isPolymorphic;
    
    protected ParentRecordData() {}

    public String getFieldApiName() {
        return this.fieldApiName;
    }

    public String getFieldRelationshipName() {
        return this.fieldRelationshipName;
    }

    public String getParentObjApiName() {
        return this.parentObjApiName;
    }

    public String getObjApiName() {
        return this.objApiName;
    }

    public SObject getParentRecord() {
        return this.parentRecord;
    }

    public Boolean getIsPolymorphic() {
        return this.isPolymorphic;
    }

    public Id getParentRecordId() {
        return this.parentRecord.Id;
    }

    public class Builder implements IBuilder {
        private ParentRecordData parentRecordData = new ParentRecordData();

        public Builder setFieldApiName(String fieldApiName) {
            this.parentRecordData.fieldApiName = fieldApiName;
            return this;
        }

        public Builder setFieldRelationshipName(String fieldRelationshipName) {
            this.parentRecordData.fieldRelationshipName = fieldRelationshipName;
            return this;
        }

        public Builder setParentObjApiName(String parentObjApiName) {
            this.parentRecordData.parentObjApiName = parentObjApiName;
            return this;
        }

        public Builder setObjApiName(String objApiName) {
            this.parentRecordData.objApiName = objApiName;
            return this;
        }

        public Builder setParentRecord(SObject parentRecord) {
            this.parentRecordData.parentRecord = parentRecord;
            return this;
        }

        public Builder setIsPolymorphic(Boolean isPolymorphic) {
            this.parentRecordData.isPolymorphic = isPolymorphic;
            return this;
        }

        public ParentRecordData build() {
            return this.parentRecordData;
        }
    }
}