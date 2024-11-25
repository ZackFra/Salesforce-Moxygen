/**
 * @description This class is used to resolve the field in a query 
 * @author Zackary Frazier
 * @since 11/24/2024
 */
public inherited sharing virtual class QueriedFieldResolver {
    protected String fieldLookupChain;
    protected SObject comparableRecord;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected QueriedFieldResolver() {}

    /**
     * @description Resolves the comparable record data from a queried field lookup chain string 
     * @return  `ComparableRecordData`
     */
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
        String comparableField = this.fieldLookupChain;
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
        ParentLookupChain lookupChain = new ParentLookupChain(this.fieldLookupChain);
        List<String> fieldParts = lookupChain.getFieldParts();

        List<String> relationshipMapping = new List<String>();

        String parentField = fieldParts[0];
        SObject parentRecord;
        SObject priorRecord = this.comparableRecord;

        ParentRecordDataWithRelationshipMapping parentInfoWithRelationship = findTopLevelParentRecordData(this.comparableRecord, lookupChain);
        ParentRecordData parentInfo = parentInfoWithRelationship.getParentRecordData();
        relationshipMapping = parentInfoWithRelationship.getRelationshipMapping();
        Boolean isPolymorphic = parentInfo.getIsPolymorphic();

        String comparableField = ComparableService.getComparableField(
            parentRecord, 
            lookupChain.getFinalField(), 
            isPolymorphic
        );
        relationshipMapping.add(comparableField);
        String relationshipName = String.join(relationshipMapping, '.');

        return new ComparableRecordData.Builder()
            .setComparableRecord(parentRecord)
            .setComparableFieldName(comparableField)
            .setRelationshipName(relationshipName)
            .setIsPolymorphic(isPolymorphic)
            .build();
    }

    private ParentRecordDataWithRelationshipMapping findTopLevelParentRecordData(SObject childRecord, ParentLookupChain lookupChain) {
        List<String> fieldParts = lookupChain.getFieldParts();
        String parentField = fieldParts[0];
        SObject parentRecord;
        SObject priorRecord = childRecord;
        List<String> relationshipMapping = new List<String>();

        ParentRecordData parentInfo;
        // Produces:
        // relationshipName
        // parentRecord
        // isPolymorphic
        while(!fieldParts.isEmpty()) {
            if(parentInfo != null) {
                priorRecord = parentInfo.getParentRecord();
            }
            parentInfo = MockDatabase.findParentRecord(priorRecord, parentField);
            relationshipMapping.add(parentInfo.getFieldRelationshipName());
            parentRecord = getFullParentRecordWithAllFields(parentInfo);
            fieldParts.remove(0);
            if(!fieldParts.isEmpty()) {
                parentField = fieldParts[0];
            }
        }
        return new ParentRecordDataWithRelationshipMapping(parentInfo, relationshipMapping);
    }

    private SObject getFullParentRecordWithAllFields(ParentRecordData recordData) {
        SObject fullParentRecord = MockDatabase.get(recordData.getParentObjApiName()).get(recordData.getParentRecordId());
        return fullParentRecord;
    }

    class ParentRecordDataWithRelationshipMapping {
        private ParentRecordData parentRecordData;
        private List<String> relationshipMapping;

        public ParentRecordDataWithRelationshipMapping(ParentRecordData parentRecordData, List<String> relationshipMapping) {
            this.parentRecordData = parentRecordData;
            this.relationshipMapping = relationshipMapping;
        }

        public ParentRecordData getParentRecordData() {
            return this.parentRecordData;
        }

        public List<String> getRelationshipMapping() {
            return this.relationshipMapping;
        }
    }

    /**
     * @description This class is used to build a `QueriedFieldResolver`
     */
    public class Builder implements IBuilder {
        QueriedFieldResolver resolver = new QueriedFieldResolver();

        /**
         * @description Sets the field lookup chain
         * @param fieldLookupChain `String`
         * @return  `Builder`
         */
        public Builder setFieldLookupChain(String fieldLookupChain) {
            this.resolver.fieldLookupChain = fieldLookupChain;
            return this;
        }

        /**
         * @description Sets the comparable record
         * @param comparableRecord `SObject`
         * @return  `Builder`
         */
        public Builder setComparableRecord(SObject comparableRecord) {
            this.resolver.comparableRecord = comparableRecord;
            return this;
        }

        /**
         * @description Builds the `QueriedFieldResolver` 
         * @return  `QueriedFieldResolver`
         */
        public QueriedFieldResolver build() {
            return resolver;
        }
    }
}