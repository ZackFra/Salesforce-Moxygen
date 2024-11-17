@IsTest
public with sharing class DynamicCastTest {
    @IsTest
    static void testCastTo() {
        Assert.areEqual('1', DynamicCast.castTo(ApexTypes.XSTRING, 1), 'Incorrect cast to String');
        Assert.areEqual(1, DynamicCast.castTo(ApexTypes.XINTEGER, '1'), 'Incorrect cast to Integer');
        Assert.areEqual(1.0, DynamicCast.castTo(ApexTypes.XDOUBLE, '1'), 'Incorrect cast to Double');
        Assert.areEqual(1.0, DynamicCast.castTo(ApexTypes.XDECIMAL, '1'), 'Incorrect cast to Decimal');

        Assert.areEqual(true, DynamicCast.castTo(ApexTypes.XBOOLEAN, 'true'), 'Incorrect cast to Boolean');
        Assert.areEqual('1', DynamicCast.castTo(ApexTypes.XOBJECT, '1'), 'Incorrect cast to Object');
    }

    @IsTest
    static void testCastToWithDate() {
        Date d = GMT.today();
        Assert.areEqual(d, DynamicCast.castTo(ApexTypes.XDATE, Common.dateToSoqlString(d)), 'Incorrect cast to Date');
    }

    @IsTest
    static void testCastToWithDateTime() {
        DateTime dt = GMT.now();
        Assert.areEqual(dt, DynamicCast.castTo(ApexTypes.XDATETIME, Common.dateTimeToApexString(dt)), 'Incorrect cast to DateTime');
    }

    @IsTest
    static void testCastToNull() {
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            DynamicCast.castTo(ApexTypes.XNULL, '1');
            Assert.fail('Expected exception');
        } catch(IllegalArgumentException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception not thrown');
    }

    @IsTest
    static void testCastWhenNull() {
        Test.startTest();
        Object val = DynamicCast.castTo(ApexTypes.XSTRING, null);
        Test.stopTest();
        Assert.isNull(val, 'Incorrect cast when value is null');
    }
}