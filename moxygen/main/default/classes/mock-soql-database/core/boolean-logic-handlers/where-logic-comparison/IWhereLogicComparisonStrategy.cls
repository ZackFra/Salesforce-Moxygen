public interface IWhereLogicComparisonStrategy {
    WhereLogicComparisonResults getFieldValue(SObject record, Node fieldNode);
}