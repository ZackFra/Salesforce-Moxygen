/**
 * @description Calculates the sum of a field 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class SumCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    /**
     * @description Constructor
     * @param options 
     */
    public SumCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the sum of a field 
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
        Decimal sum;
        if(currValue == null) {
            sum = newValue;
        } else {
            sum = currValue + newValue;
        }

        aggregateResult.put(alias, sum);
        return aggregateResult;
    }
}