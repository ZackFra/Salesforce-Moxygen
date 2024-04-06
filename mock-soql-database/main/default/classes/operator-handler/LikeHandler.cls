/**
 * @description Handles the LIKE operator 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public class LikeHandler implements IOperatorHandler {
    /**
     * @description Handles the LIKE operator
     * @param sObjectFieldValue `Object`
     * @param fieldValue `Object`
     * @return  `Boolean`
     */
    public Boolean handle(Object sObjectFieldValue, Object fieldValue) {
        if(sObjectFieldValue == null) {
            return false;
        }

        String regexPattern = String.valueOf(fieldValue)
            .toLowerCase()
            .replaceAll('%', '.*')
            .replaceAll('_', '.');
        Pattern regex = Pattern.compile(regexPattern);
        Matcher regexMatcher = regex.matcher(String.valueOf(sObjectFieldValue).toLowerCase());
        return regexMatcher.matches();
    }
}