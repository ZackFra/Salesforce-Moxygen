/**
 * @description Offset handler for records
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public with sharing class RecordOffsetHandler implements IOffsetHandler {

    private OffsetOptions options;
    /**
     * @description Constructor
     * @param options `OffsetOptions`
     */
    public RecordOffsetHandler(OffsetOptions options) {
        this.options = options;
    }

    /**
     * @description Handles the offset for the records 
     * @return  `Object`
     */
    public Object handleOffset() {
        Integer offset = options.offset;
        Object obj = options.obj;

        List<SObject> sObjResults = new List<SObject>((List<SObject>) obj);
        while(offset > 0) {
            sObjResults.remove(0);
            offset--;
        }
        return sObjResults;
    }
}