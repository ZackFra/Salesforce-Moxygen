/**
 * @description CountDistinctCalculator is a class that implements the IAggregateCalculator interface. It calculates the distinct count of a field. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class CountDistinctCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    /**
     * @description Constructor for the CountDistinctCalculator class.
     * @param options 
     */
    public CountDistinctCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description This method calculates the distinct count of a field. 
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(
            options.aggregateResult,
            options.alias,
            options.value
        );
    }

    private ProtoAggregate calculate(ProtoAggregate aggregateResult, String alias, Object value) {

        Integer currValue = (Integer) aggregateResult.get(alias);
        if(currValue == null) {
            currValue = 0;
        }
        Set<Object> distinctValues = (Set<Object>) aggregateResult.get(alias + '__distinct');
        if(distinctValues == null) {
            distinctValues = new Set<Object>();
        }
        aggregateResult.put(alias + '__distinct', distinctValues);
        if(value != null) {
            distinctValues.add(value);
        }
        aggregateResult.put(alias, distinctValues.size());
        return aggregateResult;
    }
}