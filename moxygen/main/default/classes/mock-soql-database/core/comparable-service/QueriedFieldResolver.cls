public with sharing virtual class QueriedFieldResolver {
    protected String fieldLookupChain;
    protected SObject comparableRecord;


    protected QueriedFieldResolver() {}

    public ComparableRecordData resolve() {
        if(isLookup()) {
            return resolveLookup();
        }
        return resolveStandard();
    }

    private Boolean isLookup() {
        return this.fieldLookupChain.contains('.');
    }

    private ComparableRecordData resolveStandard() {
        Schema.SObjectType sot = SchemaService.getSObjectType(comparableRecord);
        String comparableField;
        if(!SchemaService.hasField(sot, comparableField)) {
            throw ExceptionFactory.createIllegalFieldNameException(comparableField);
        }
        Schema.SObjectField recordField = SchemaService.getField(sot, comparableField);
        comparableField = SchemaService.getFieldName(recordField);
        return new ComparableRecordData.Builder()
            .setComparableRecord(this.comparableRecord)
            .setComparableFieldName(comparableField)
            .build();
    }

    private ComparableRecordData resolveLookup() {
        ParentLookupChain lookupChain = splitParentLookupChain();
        List<String> fieldParts = lookupChain.getFieldParts();
        String finalField = lookupChain.getFinalField();

        String parentField = fieldParts[0];
        sObject parentRecord;
        String relationshipName = '';
        String parentObjApiName;
        String fieldRelationshipName;
        Boolean isPolymorphic = false;
        SObject priorRecord = this.comparableRecord;

        // Produces:
        // relationshipName
        // parentRecord
        while(!fieldParts.isEmpty()) {
            if(parentRecord != null) {
                priorRecord = parentRecord;
            }

            ParentRecordData parentInfo = MockDatabase.findParentRecord(this.comparableRecord, parentField);
            relationshipName += parentInfo.getFieldRelationshipName() + '.';
            isPolymorphic = parentInfo.getIsPolymorphic();

            parentRecord = MockDatabase.get(parentInfo.getParentObjApiName())
                .get(parentInfo.getParentRecord().Id);
            

            fieldParts.remove(0);
            if(!fieldParts.isEmpty()) {
                parentField = fieldParts[0];
            }
        }
        comparableRecord = parentRecord;
        String comparableField = ComparableService.getComparableField(comparableRecord, finalField, isPolymorphic);

        relationshipName += comparableField;
        return new ComparableRecordData.Builder()
            .setComparableRecord(comparableRecord)
            .setComparableFieldName(comparableField)
            .setRelationshipName(relationshipName)
            .setIsPolymorphic(isPolymorphic)
            .build();
    }

    private ParentLookupChain splitParentLookupChain() {
        List<String> fieldParts = this.fieldLookupChain.split('\\.');
        String finalField = fieldParts[fieldParts.size()-1];
        fieldParts.remove(fieldParts.size()-1);
        return new ParentLookupChain(finalField, fieldParts);
    }

    public class Builder implements IBuilder {
        QueriedFieldResolver resolver = new QueriedFieldResolver();

        public Builder setFieldLookupChain(String fieldLookupChain) {
            this.resolver.fieldLookupChain = fieldLookupChain;
            return this;
        }

        public Builder setComparableRecord(SObject comparableRecord) {
            this.resolver.comparableRecord = comparableRecord;
            return this;
        }

        public QueriedFieldResolver build() {
            return resolver;
        }
    }
}