/**
 * @description Limit handler for record limit 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class RecordLimitHandler implements ILimitHandler {
    LimitOptions options;
    /**
     * @description Constructor for RecordLimitHandler
     * @param options `LimitOptions`
     */
    public RecordLimitHandler(LimitOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the limit for the object 
     * @return  `Object`
     */
    public Object handleLimit() {
        Object obj = options.getObj();
        Integer limitSize = options.getLimitSize();

        List<SObject> resultsList = new List<SObject>((List<SObject>) obj);
        while(resultsList.size() > limitSize) {
            resultsList.remove(resultsList.size()-1);
        }
        return resultsList;
    }
}