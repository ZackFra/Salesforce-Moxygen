/**
 * @description Processor for aggregate functions 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public abstract class AggregateProcessor {
    protected MockDatabase db;
    protected TopLevelNodes topLevelNodes;

    /**
     * @description Process a record from the database
     * @param databaseRecord 
     */
    public abstract void processRecord(SObject databaseRecord);

    /**
     * @description Finish processing the records and return the aggregates 
     * @return  `List<ProtoAggregate>`
     */
    public abstract List<ProtoAggregate> finish();

    /**
     * @description Set the database to use for processing 
     * @param db 
     * @return  `AggregateProcessor`
     */
    public AggregateProcessor setDatabase(MockDatabase db) {
        this.db = db;
        return this;
    }

    /**
     * @description Set the top level nodes to use for processing
     * @param topLevelNodes 
     * @return  `AggregateProcessor`
     */
    public AggregateProcessor setTopLevelNodes(TopLevelNodes topLevelNodes) {
        this.topLevelNodes = topLevelNodes;
        return this;
    }

    /**
     * @description Calculate the aggregate for a given value
     * @param currSelect 
     * @param alias 
     * @param aggregateResult 
     * @param value 
     * @return  `ProtoAggregate`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    protected ProtoAggregate calculateAggregate(
        Node currSelect,
        String alias, 
        ProtoAggregate aggregateResult,
        Object value
    ) {
        AggregateCalculatorOptions options = new AggregateCalculatorOptions()
            .setAlias(alias)
            .setAggregateResult(aggregateResult)
            .setValue(value);


        IAggregateCalculator calculator = AggregateCalculatorFactory.getCalculator(currSelect.id, options);
        return calculator.calculate();
    }
}