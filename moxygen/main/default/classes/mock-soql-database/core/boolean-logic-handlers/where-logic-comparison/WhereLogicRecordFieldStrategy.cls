public with sharing class WhereLogicRecordFieldStrategy implements IWhereLogicComparisonStrategy {
    public WhereLogicComparisonResults getFieldValue(SObject record, Node fieldNode) {
        String fieldName = fieldNode.id;
        Object recordFieldValue = record.get(fieldName);
        return new WhereLogicComparisonResults.Builder()
            .setRecordFieldValue(recordFieldValue)
            .setFinalField(fieldName)
            .build();
    }
}