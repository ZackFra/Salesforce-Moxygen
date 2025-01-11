/**
 * @description Strategy inreferace for WHERE logic comparison
 * @author Zackary Frazier
 * @since 11/28/2024
 */
public interface IWhereLogicComparisonStrategy {
    /**
     * @description Retrieve the field value from the record based on the field node
     * @param record `SObject`
     * @param fieldNode `Node`
     * @return  `WhereLogicComparisonResults`
     */
    WhereLogicComparisonResults getFieldValue(SObject record, Node fieldNode);
}
