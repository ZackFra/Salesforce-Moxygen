/**
 * @description OffsetHandler for Count 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class CountOffsetHandler implements IOffsetHandler {
    private final OffsetOptions options;

    /**
     * @description Constructor for CountOffsetHandler
     * @param options `OffsetOptions`
     */
    public CountOffsetHandler(OffsetOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the offset for the Count 
     * @return  `Object`
     */
    public Object handleOffset() {
        Integer offset = options.offset;
        Object obj = options.obj;

        Integer value = (Integer) obj - offset;
        if(value < 0) {
            value = 0;
        }
        return value;
    }
}