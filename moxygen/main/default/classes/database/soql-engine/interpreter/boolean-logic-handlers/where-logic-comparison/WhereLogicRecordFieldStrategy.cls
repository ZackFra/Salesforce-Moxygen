/**
 * @description This class is responsible for handling record fields in the WHERE clause
 * @author Zackary Frazier
 * @since 11/28/2024
 * @group Soql Engine
 */
public with sharing class WhereLogicRecordFieldStrategy implements IWhereLogicComparisonStrategy {
    /**
     * @description Get the field value from the record when the field node is for a record field
     * @param record `SObject`
     * @param fieldNode `Node`
     * @return  `WhereLogicComparisonResults`
     */
    public WhereLogicComparisonResults getFieldValue(
        SObject record,
        Node fieldNode
    ) {
        String fieldName = fieldNode.id;
        Object recordFieldValue = record.get(fieldName);
        return new WhereLogicComparisonResults.Builder()
            .setRecordFieldValue(recordFieldValue)
            .setFinalField(fieldName)
            .setParentRecord(record)
            .build();
    }
}
