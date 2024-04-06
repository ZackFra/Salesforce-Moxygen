/**
 * @description Interface for aggregate calculator
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public interface IAggregateCalculator {
    /**
     * @description Calculate the aggregate of the data 
     * @return  `ProtoAggregate`
     */
    ProtoAggregate calculate();
}