/**
 * @description Calculates a SOQL date function for an aggregate query
 * @author Zackary Frazier
 * @since 11/21/2026
 * @group Soql Engine
 */
public with sharing class DateFuncAggregateCalculator implements IAggregateCalculator {
    AggregateCalculatorOptions options;
    String dateFunc;

    /**
     * @description Constructor
     * @param options Aggregate calculator options
     * @param dateFunc Date function name, such as day_in_month
     */
    public DateFuncAggregateCalculator(
        AggregateCalculatorOptions options,
        String dateFunc
    ) {
        this.options = options;
        this.dateFunc = dateFunc;
    }

    /**
     * @description Calculate the date function for the value in options
     * @return  `ProtoAggregate`
     */
    public ProtoAggregate calculate() {
        return calculate(options.aggregateResult, options.alias, options.value);
    }

    /**
     * @description Calculate the date function for the first grouped record
     * @return  `Object`
     */
    public Object calculateForField() {
        String fieldName = options.alias;
        ProtoAggregate aggregateResult = options.aggregateResult;
        SObject firstRecord = aggregateResult.getRecords()[0];
        Object value = firstRecord.get(fieldName);
        return DateFuncs.execute(dateFunc, value);
    }

    private ProtoAggregate calculate(
        ProtoAggregate aggregateResult,
        String alias,
        Object value
    ) {
        if (value == null) {
            if (!aggregateResult.containsKey(alias)) {
                aggregateResult.put(alias, null);
            }
            return aggregateResult;
        }

        aggregateResult.put(alias, DateFuncs.execute(dateFunc, value));
        return aggregateResult;
    }
}
