/**
 * @description Generates an instance of an aggregate calculator based on the type provided 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AggregateCalculatorFactory {
    private class AggregateCalculatorException extends Exception {}
    
    /**
     * @description Generates an instance of an aggregate calculator based on the type provided 
     * @param type 
     * @param options 
     * @return  `IAggregateCalculator`
     * @exception AggregateCalculatorException
     */
    public static IAggregateCalculator getCalculator(String type, AggregateCalculatorOptions options) {
        Map<String, IAggregateCalculator> calculators = new Map<String, IAggregateCalculator> {
            'sum' => new SumCalculator(options),
            'avg' => new AverageCalculator(options),
            'max' => new MaxCalculator(options),
            'min' => new MinCalculator(options),
            'count_distinct' => new CountDistinctCalculator(options),
            'count' => new CountCalculator(options)
        };
        IAggregateCalculator calculator = calculators.get(type);
        if(calculator == null) {
            throw new AggregateCalculatorException('Invalid type');
        }
        return calculator;
    }
}