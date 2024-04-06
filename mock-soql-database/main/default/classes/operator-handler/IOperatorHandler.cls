/** 
 * @description comparison handlers for WHERE and HAVING clauses 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public interface IOperatorHandler {
    /**
     * @description Handles the comparison of the field value and the sObject field value
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    Boolean handle(Object sObjectFieldValue, Object fieldValue);
}