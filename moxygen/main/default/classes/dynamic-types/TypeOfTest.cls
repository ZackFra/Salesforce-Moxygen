@IsTest
public with sharing class TypeOfTest {
    @IsTest
    static void testForObject() {
        Object obj = 'Hello';
        Assert.areEqual(ApexTypes.XSTRING, TypeOf.forObject(obj), 'Incorrect type for String');
        obj = 1;
        Assert.areEqual(ApexTypes.XINTEGER, TypeOf.forObject(obj), 'Incorrect type for Integer');
        obj = 1.0;
        Assert.areEqual(ApexTypes.XDECIMAL, TypeOf.forObject(obj), 'Incorrect type for Decimal');
        obj = Date.today();
        Assert.areEqual(ApexTypes.XDATE, TypeOf.forObject(obj), 'Incorrect type for Date');
        obj = DateTime.now();
        Assert.areEqual(ApexTypes.XDATETIME, TypeOf.forObject(obj), 'Incorrect type for DateTime');
        obj = true;
        Assert.areEqual(ApexTypes.XBOOLEAN, TypeOf.forObject(obj), 'Incorrect type for Boolean');
        obj = null;
        Assert.areEqual(ApexTypes.XOBJECT, TypeOf.forObject(obj), 'Incorrect type for Object');
    }
}