/**
 * @description CountCalculator is a concrete implementation of IAggregateCalculator that calculates the count of records. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class CountCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;

    /**
     * @description Constructor for CountCalculator
     * @param options 
     */
    public CountCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the count of records 
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(
            options.aggregateResult, 
            options.alias
        );
    }

    /**
     * @description Calculates the count of records
     * @param aggregateResult 
     * @param alias 
     * @return  `ProtoAggregate`
     */
    private ProtoAggregate calculate(ProtoAggregate aggregateResult, String alias) {
        Integer currValue = (Integer) aggregateResult.get(alias);
        if(currValue == null) {
            currValue = 0;
        }
        aggregateResult.put(alias, currValue + 1);
        return aggregateResult;
    }
}