/**
 * @description Handles the limit for the aggregate query 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class AggregateLimitHandler implements ILimitHandler {
    LimitOptions options;

    /**
     * @description Constructor for the AggregateLimitHandler
     * @param options `LimitOptions`
     */
    public AggregateLimitHandler(LimitOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the limit for the aggregate query
     * @return  `Object` - The object with the limit applied
     */
    public Object handleLimit() {
        Object obj = options.getObj();
        Integer limitSize = options.getLimitSize();

        List<ProtoAggregate> resultsList = new List<ProtoAggregate>((List<ProtoAggregate>) obj);
        while(resultsList.size() > limitSize) {
            resultsList.remove(resultsList.size()-1);
        }
        return resultsList;
    }
}