/**
 * @description Calculates the minimum value of a field 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class MinCalculator implements IAggregateCalculator {

    AggregateCalculatorOptions options;
    /**
     * @description Constructor
     * @param options 
     */
    public MinCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the minimum value of a field 
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
        if(value == null) {
            // make sure it's explicitly set to null
            if(!aggregateResult.containsKey(alias)) {
                aggregateResult.put(alias, null);
            }
            return aggregateResult;
        }
        Decimal currValue = (Decimal) aggregateResult.get(alias);
        Decimal newValue = (Decimal) value;

        if(currValue == null) {
            currValue = newValue;
        } else {
            currValue = Math.min(currValue, newValue);
        }

        aggregateResult.put(alias, currValue);
        return aggregateResult;
    }
}