/**
 * @description Common utility class for basic operations, should not contain complex code
 */
public with sharing class Common {

    /**
     * @description Method to check if a field is null
     * @param args - Argument object containing the field and field name
     * @throws IllegalArgumentException if the field is null
     */
    public static void nullCheck(Map<String, Object> args) {
        Set<String> argNames = args.keySet();
        for(String argName : argNames) {
            Object argValue = args.get(argName);
            if(argValue == null) {
                throw new IllegalArgumentException('Argument ' + argName + ' cannot be null');
            }
        }
    }
}