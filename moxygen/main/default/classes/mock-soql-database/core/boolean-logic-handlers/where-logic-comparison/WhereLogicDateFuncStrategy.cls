public with sharing class WhereLogicDateFuncStrategy implements IWhereLogicComparisonStrategy {
    public WhereLogicComparisonResults getFieldValue(SObject record, Node fieldNode) {
        // in this sceneario, fieldNode's actually an aggregate, so fieldNode.right is the actual field
        String fieldName = SchemaService.getFieldName(record, fieldNode.right.id);
        String finalField = fieldName;
        Object dateOrDateTimeValue = record.get(fieldName);
        Boolean isDateFunc = AggregateService.isDateFunc(fieldNode.nodeType, fieldNode.id);
        if(!isDateFunc) {
            throw new QueryException('Unsupported date function');
        }
        Object recordFieldValue = DateFuncs.execute(fieldNode.id, dateOrDateTimeValue);
        return new WhereLogicComparisonResults.Builder()
            .setRecordFieldValue(recordFieldValue)
            .setFinalField(finalField)
            .build();
    }
}