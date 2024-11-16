public with sharing class TypeOf {
    public static String forObject(Object obj) {
        if(obj instanceOf Id) {
            return 'Id';
        } else if(obj instanceOf String) {
            return 'String';
        } else if(obj instanceOf Integer) {
            return 'Integer';
        } else if(obj instanceOf Decimal) {
            return 'Decimal';
        } else if(obj instanceOf Date) {
            return 'Date';
        } else if(obj instanceof DateTime) {
            return 'DateTime';
        } else if(obj instanceOf Time) {
            return 'Time';
        } else if(obj instanceOf Boolean) {
            return 'Boolean';
        } else {
            return 'Unsupported';
        }
    }
}