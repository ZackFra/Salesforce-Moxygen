/**
 * @description Handler for offsetting aggregate results 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AggregateOffsetHandler implements IOffsetHandler {
    OffsetOptions options;

    /**
     * @description Constructor for AggregateOffsetHandler
     * @param options `OffsetOptions`
     */
    public AggregateOffsetHandler(OffsetOptions options) {
        this.options = options;
    }

    /**
     * @description Handles offsetting aggregate results
     * @return  `Object`
     */
    public Object handleOffset() {
        Integer offset = options.offset;
        Object obj = options.obj;

        List<ProtoAggregate> aggrResults = new List<ProtoAggregate>((List<ProtoAggregate>) obj);
        while(offset > 0) {
            aggrResults.remove(0);
            offset--;
        }
        return aggrResults;
    }
}