/**
 * @description This class is used to resolve the field in a query
 * @author Zackary Frazier
 * @since 11/24/2024
 * @group Soql Engine
 */
public with sharing virtual class QueriedFieldResolver {
    protected String fieldLookupChain;
    protected SObject comparableRecord;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected QueriedFieldResolver() {
    }

    /**
     * @description Resolves the comparable record data from a queried field lookup chain string
     * @return  `ComparableRecordData`
     */
    public ComparableRecordData resolve() {
        if (isLookup()) {
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
        Schema.SObjectField recordField = SchemaService.getField(
            sot,
            comparableField
        );
        comparableField = SchemaService.getFieldName(recordField);
        return new ComparableRecordData.Builder()
            .setComparableRecord(this.comparableRecord)
            .setComparableFieldName(comparableField)
            .build();
    }

    private ComparableRecordData resolveLookup() {
        ParentLookupChain lookupChain = new ParentLookupChain(
            this.fieldLookupChain
        );
        List<String> fieldParts = lookupChain.getFieldParts();

        List<String> relationshipMapping = new List<String>();

        String parentField = fieldParts[0];
        SObject parentRecord;
        SObject priorRecord = this.comparableRecord;

        ParentRecordData parentInfo;
        // Produces:
        // relationshipName
        // parentRecord
        // isPolymorphic
        while (!fieldParts.isEmpty()) {
            if (parentInfo != null) {
                priorRecord = parentInfo.getParentRecord();
            }
            parentInfo = findParentRecord(priorRecord, parentField);
            relationshipMapping.add(parentInfo.getFieldRelationshipName());
            parentRecord = getFullParentRecordWithAllFields(parentInfo);
            fieldParts.remove(0);
            if (!fieldParts.isEmpty()) {
                parentField = fieldParts[0];
            }
        }
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

    /**
     * @description Return a parent sObject from a field name and a child sObject
     * @param sObj The child SObject
     * @param fieldName the field name of the parent sObject from the child
     *                  ex. OpportunityLineItem, the field is Opportunity
     * @return The parent sObject
     */
    private ParentRecordData findParentRecord(SObject sObj, String fieldName) {
        String sObjApiName = sObj.getSObjectType().getDescribe().getName();
        SObjectType t = SchemaService.getSObjectType(sObjApiName);

        List<Schema.SObjectField> fields = SchemaService.getFields(t);
        for (SObjectField field : t.getDescribe().fields.getMap().values()) {
            Schema.DescribeFieldResult dfr = field.getDescribe();
            Schema.DisplayType dfrFieldType = dfr.getType();
            String dfrRelationshipName = dfr.getRelationshipName();
            String lowercaseDfrRelationshipName = null;
            if (dfrRelationshipName != null) {
                lowercaseDfrRelationshipName = dfrRelationshipName.toLowerCase();
            }

            if (
                dfrFieldType == Schema.DisplayType.REFERENCE &&
                lowerCaseDfrRelationshipName == fieldName
            ) {
                return buildParentRecordData(field, sObj);
            }
        }

        throw new QueryException('Invalid relationship name: ' + fieldName);
    }

    private ParentRecordData buildParentRecordData(
        SObjectField field,
        SObject childRecord
    ) {
        DescribeFieldResult dfr = field.getDescribe();
        String fieldName = dfr.getName();
        List<Schema.sObjectType> objTypeList = dfr.getReferenceTo();

        String parentObjApiName;
        Boolean isPolymorphic = false;
        if (objTypeList.size() == 1) {
            parentObjApiName = SchemaService.getSObjectName(objTypeList[0]);
        } else {
            String parentFieldApiName = SchemaService.getFieldName(field);
            Id parentRecordId = (Id) childRecord.get(parentFieldApiName);
            parentObjApiName = SchemaService.getSObjectName(parentRecordId);
            isPolymorphic = true;
        }

        if (parentObjApiName == null) {
            throw new QueryException('Invalid relationship name: ' + fieldName);
        }
        String fieldRelationshipName = dfr.getRelationshipName();

        sObject parentRecord = ((sObject) Type.forName(parentObjApiName)
                .newInstance())
            .getSObjectType()
            .newSObject();

        SObjectType sot = SchemaService.getSObjectType(childRecord);
        Map<Id, sObject> mockRecordsChild = DataStore.getAllBySot(sot);
        Id parentId = (Id) mockRecordsChild.get(childRecord.Id).get(fieldName);

        parentRecord.put('Id', parentId);
        return new ParentRecordData.Builder()
            .setFieldApiName(fieldName)
            .setFieldRelationshipName(fieldRelationshipName)
            .setParentObjApiName(parentObjApiName)
            .setObjApiName(SchemaService.getSObjectName(childRecord))
            .setParentRecord(parentRecord)
            .setIsPolymorphic(isPolymorphic)
            .build();
    }

    private SObject getFullParentRecordWithAllFields(
        ParentRecordData recordData
    ) {
        SObject fullParentRecord = DataStore.getById(
            recordData.getParentRecordId()
        );
        return fullParentRecord;
    }

    /**
     * @description This class is used to build a `QueriedFieldResolver`
     */
    public class Builder {
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
