/**
 * @description Handles the inequality operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class InequalityHandler implements IOperatorHandler {
    /**
     * @description Handles the inequality operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        Boolean isSObjNull = (sObjectFieldValue == null);
        Boolean isFieldNull = (fieldValue == null);

        if(isSObjNull && isFieldNull) {
            return false;
        } else if(isSObjNull || isFieldNull) {
            return true;
        }

        if(sObjectFieldValue instanceof Date) {
            fieldValue = (Object) Common.parseDate((String) fieldValue).toString();
        } else if(SObjectFieldValue instanceof DateTime) {
            fieldValue = (Object) Common.parseDateTime((String) fieldValue).toString();
        } else if(SObjectFieldValue instanceof Time) {
            fieldValue = (Object) Common.parseTime((String) fieldValue).toString();
        }

        return (String.valueOf(sObjectFieldValue).toLowerCase() != ((String)fieldValue).toLowerCase());
    }
}