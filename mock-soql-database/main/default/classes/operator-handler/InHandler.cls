/**
 * @description Handler for IN operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class InHandler implements IOperatorHandler {
    /**
     * @description Handles the IN operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        if(sObjectFieldValue == null) {
            return false;
        }

        List<Object> values = (List<Object>) fieldValue;
        for(Integer i = 0; i < values.size(); i++) {
            if(values[i] instanceof String) {
                values[i] = (Object) ((String) values[i]).toLowerCase();
            }
        }
        String nodeValue = String.valueOf(sObjectFieldValue).toLowerCase();
        return values.contains(nodeValue);
    }
}