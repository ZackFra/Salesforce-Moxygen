/**
 * @description TypeOf is a class that provides a method to determine the type of an object. 
 * @author Zackary Frazier
 * @since 11/16/2024
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public inherited sharing class TypeOf {
    /**
     * @description Given an object, determine the type of the object. 
     * @param obj `Object`
     * @return  `String`
     */
    @SuppressWarnings('PMD.CyclomaticComplexity')
    public static String forObject(Object obj) {
        if(obj == null) {
            return ApexTypes.XNULL;
        } else if(obj instanceOf Id) {
            return ApexTypes.XID;
        } else if(obj instanceOf String) {
            return ApexTypes.XSTRING;
        } else if(obj instanceOf Integer) {
            return ApexTypes.XINTEGER;
        } else if(obj instanceOf Decimal) {
            return ApexTypes.XDECIMAL;
        } else if(obj instanceOf Date) {
            return ApexTypes.XDATE;
        } else if(obj instanceof DateTime) {
            return ApexTypes.XDATETIME;
        } else if(obj instanceOf Time) {
            return ApexTypes.XTIME;
        } else if(obj instanceOf Boolean) {
            return ApexTypes.XBOOLEAN;
        } else {
            String typeName = 'Name';
            try {
                Name a = (Name) obj;
            } catch(Exception e) {
                typeName = e.getMessage().substringAfter('Invalid conversion from runtime type ').substringBefore(' to Name');
            }
            return typeName;
        }
    }
}