public with sharing class TypeOf {
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
            return ApexTypes.XOBJECT;
        }
    }
}