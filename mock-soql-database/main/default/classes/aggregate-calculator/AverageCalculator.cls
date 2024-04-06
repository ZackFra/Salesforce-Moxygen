/**
 * @description Calculates the average of a set of values. 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AverageCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    /**
     * @description Constructor for the AverageCalculator class
     * @param options 
     */
    public AverageCalculator(AggregateCalculatorOptions options) {
        this.options = options;
    }

    /**
     * @description Calculates the average of a set of values. 
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(
            options.aggregateResult,
            options.alias,
            options.value
        );
    }

    /**
     * @description Calculates the average of a set of values with an alias.
     * @param aggregateResult 
     * @param alias 
     * @param value 
     * @return  `ProtoAggregate`
     */
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
        Decimal n = (Decimal) aggregateResult.get(alias + '__n');
        if(n == null) {
            n = 1;
        }

        if(currValue == null) {
            currValue = newValue;
        } else {
            currValue = currValue + (newValue - currValue) / n;
        }

        aggregateResult.put(alias, currValue);
        aggregateResult.put(alias + '__n', n + 1);

        return aggregateResult;
    }
}