/**
 * @description Options for the AggregateCalculator class 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AggregateCalculatorOptions {
    public ProtoAggregate aggregateResult;
    public String alias;
    public Object value;

    /**
     * @description Setter for the `aggregateResult` property
     * @param aggregateResult 
     * @return  `AggregateCalculatorOptions`
     */
    public AggregateCalculatorOptions setAggregateResult(ProtoAggregate aggregateResult) {
        this.aggregateResult = aggregateResult;
        return this;
    }

    /**
     * @description Setter for the `alias` property
     * @param alias 
     * @return  `AggregateCalculatorOptions`
     */
    public AggregateCalculatorOptions setAlias(String alias) {
        this.alias = alias;
        return this;
    }

    /**
     * @description Setter for the `value` property
     * @param value 
     * @return  `AggregateCalculatorOptions`
     */
    public AggregateCalculatorOptions setValue(Object value) {
        this.value = value;
        return this;
    }
}