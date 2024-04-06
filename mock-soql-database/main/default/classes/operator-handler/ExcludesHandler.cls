/**
 * @description Handles the excludes operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class ExcludesHandler implements IOperatorHandler {
    /**
     * @description Handles the excludes operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        IncludesHandler includesHandler = new IncludesHandler();
        return !includesHandler.handle(sObjectFieldValue, fieldValue);
    }
}