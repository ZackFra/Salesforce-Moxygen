/**
 * @description Handles the limit for the count of records 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class CountLimitHandler implements ILimitHandler {
    LimitOptions options;

    /**
     * @description Constructor for the CountLimitHandler
     * @param options `LimitOptions`
     */
    public CountLimitHandler(LimitOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the limit for the count of records
     * @return  `Object`
     */
    public Object handleLimit() {
        Object obj = options.getObj();
        Integer limitSize = options.getLimitSize();

        Integer count = (Integer) obj;
        if(count > limitSize) {
            return limitSize;
        }
        return count;
    }
}