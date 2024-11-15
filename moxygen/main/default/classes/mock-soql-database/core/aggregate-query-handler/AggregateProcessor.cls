/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

/**
 * @description Processor for aggregate functions 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public abstract class AggregateProcessor {
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