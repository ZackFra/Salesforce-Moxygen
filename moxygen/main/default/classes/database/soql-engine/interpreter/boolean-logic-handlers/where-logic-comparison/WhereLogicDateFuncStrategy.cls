/**
 * @description This class is responsible for handling date functions in the WHERE clause
 * @author Zackary Frazier
 * @since 11/28/2024
 * @group Soql Engine
 */
public with sharing class WhereLogicDateFuncStrategy implements IWhereLogicComparisonStrategy {
    /**
     * @description Get the field value from the record when the field node is for a date function
     * @param record `SObject`
     * @param fieldNode `Node`
     * @return  `WhereLogicComparisonResults`
     * @exception ValidationException
     */
    public WhereLogicComparisonResults getFieldValue(
        SObject record,
        Node fieldNode
    ) {
        // in this sceneario, fieldNode's actually an aggregate, so fieldNode.right is the actual field
        String fieldName = SchemaService.getFieldName(
            record,
            fieldNode.right.id
        );
        String finalField = fieldName;
        Object dateOrDateTimeValue = record.get(fieldName);
        Boolean isDateFunc = AggregateService.isDateFunc(
            fieldNode.nodeType,
            fieldNode.id
        );
        if (!isDateFunc) {
            throw new ValidationException('Unsupported date function');
        }
        Object recordFieldValue = DateFuncs.execute(
            fieldNode.id,
            dateOrDateTimeValue
        );
        return new WhereLogicComparisonResults.Builder()
            .setRecordFieldValue(recordFieldValue)
            .setFinalField(finalField)
            .setParentRecord(record)
            .build();
    }
}
