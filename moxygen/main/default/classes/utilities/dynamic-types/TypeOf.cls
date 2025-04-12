/**
 * @description TypeOf is a class that provides a method to determine the type of an object.
 * @author Zackary Frazier
 * @since 11/16/2024
 * @group Utilities
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public with sharing class TypeOf {
    /**
     * @description Given an object, determine the type of the object.
     * @param obj `Object`
     * @return  `String`
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public static String forObject(Object obj) {
        String typeName = ApexTypes.XNULL;
        if (obj != null) {
            typeName = dynamicallyGetTypeByInvokingAnException(obj);
        }
        return typeName;
    }

    @SuppressWarnings('PMD.UnusedLocalVariable')
    private static String dynamicallyGetTypeByInvokingAnException(Object obj) {
        String nameObject = Name.getSObjectType().getDescribe().getName();
        String typeName = nameObject;
        try {
            Name a = (Name) obj;
        } catch (Exception e) {
            typeName = e.getMessage()
                .substringAfter('Invalid conversion from runtime type ')
                .substringBefore(' to ' + nameObject);
        }
        return typeName;
    }
}
