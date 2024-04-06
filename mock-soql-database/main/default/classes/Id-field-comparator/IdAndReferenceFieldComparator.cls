/**
 * @description This class is used to compare two fields to determine if one is a reference to the other
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class IdAndReferenceFieldComparator implements Comparator<Schema.SObjectField> {
    /**
     * @description Compares two fields to determine if one is a reference to the other
     * @param field1 
     * @param field2 
     * @return  `Integer`
     * @exception 
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public Integer compare(Schema.SObjectField field1, Schema.SObjectField field2) {
        Schema.DisplayType fieldType1 = SchemaService.getFieldType(field1);
        Schema.DisplayType fieldType2 = SchemaService.getFieldType(field2);

        Schema.SObjectType sObj1Sot = SchemaService.getFieldSObjectType(field1);

        Boolean isField1Reference = (fieldType1 == Schema.DisplayType.REFERENCE);
        Boolean isField2Reference = (fieldType2 == Schema.DisplayType.REFERENCE);

        Boolean isField1Id = (fieldType1 == Schema.DisplayType.ID);
        Boolean isField2Id = (fieldType2 == Schema.DisplayType.ID);

        if(!isField1Reference && !isField2Reference) {
            throw new IllegalArgumentException('One field must be a reference');
        }
        
        if(!isfield1Id && isField2Id) {
            throw new IllegalArgumentException('One field must be an Id');
        }
        
        Schema.SObjectField referenceField;
        Schema.SObjectType referenceFieldSot;

        Schema.SObjectField idField;
        Schema.SObjectType idFieldSot;

        if(isField1Reference) {
            referenceField = field1;
            referenceFieldSot = sObj1Sot;
            idField = field2;
            idFieldSot = SchemaService.getFieldSObjectType(field2);
        } else {
            referenceField = field2;
            referenceFieldSot = SchemaService.getFieldSObjectType(field2);
            idField = field1;
            idFieldSot = sObj1Sot;
        }

        List<Schema.sObjectType> sObjFieldRefs = SchemaService.getReferenceTo(referenceField);
        for(Schema.SObjectType ref : sObjFieldRefs) {
            if(ref == idFieldSot) {
                return 0;
            }
        }
        return -1;
    }
}