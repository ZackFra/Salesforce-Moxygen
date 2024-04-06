@isTest
private class ObjectComparatorTest {

    @IsTest
    private static void testLeftNull() {
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(null, 1);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest 
    private static void testRightNull() {
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(1, null);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testBothNull() {
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(null, null);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testIntLessThan() {
        Integer a = 1;
        Integer b = 2;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testIntEqual() {
        Integer a = 1;
        Integer b = 1;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testIntGreaterThan() {
        Integer a = 2;
        Integer b = 1;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testStringLessThan() {
        String a = 'a';
        String b = 'b';
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testStringGreaterThan() {
        String a = 'b';
        String b = 'a';
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testStringEqual() {
        String a = 'a';
        String b = 'a';
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testBoolGreaterThan() {
        Boolean a = true;
        Boolean b = false;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testBoolLessThan() {
        Boolean a = false;
        Boolean b = true;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testBoolEqual() {
        Boolean a = true;
        Boolean b = true;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testDecimalLessThan() {
        Decimal a = 1.0;
        Decimal b = 2.0;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testDecimalGreaterThan() {
        Decimal a = 2.0;
        Decimal b = 1.0;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testDecimalEqual() {
        Decimal a = 1.0;
        Decimal b = 1.0;
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testDateLessThan() {
        Date a = Date.today();
        Date b = Date.today().addDays(1);
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testDateGreaterThan() {
        Date a = Date.today().addDays(1);
        Date b = Date.today();
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testDateEqual() {
        Date a = Date.today();
        Date b = Date.today();
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testDateTimeLessThan() {
        DateTime a = DateTime.now();
        DateTime b = DateTime.now().addDays(1);
        Test.startTest();
        ObjectComparator comparator = new ObjectComparator();
        Test.stopTest();
        Integer results = (Integer) comparator.compare(a, b);
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testDateTimeGreaterThan() {
        DateTime a = DateTime.now().addDays(1);
        DateTime b = DateTime.now();
        Test.startTest();
        ObjectComparator comparator = new ObjectComparator();
        Test.stopTest();
        Integer results = (Integer) comparator.compare(a, b);
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testDateTimeEqual() {
        DateTime a = DateTime.now();
        DateTime b = DateTime.now();
        Test.startTest();
        ObjectComparator comparator = new ObjectComparator();
        Test.stopTest();
        Integer results = (Integer) comparator.compare(a, b);
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testTimeLessThan() {
        Time a = Time.newInstance(1, 1, 1, 1);
        Time b = Time.newInstance(2, 2, 2, 2);
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testTimeGreaterThan() {
        Time a = Time.newInstance(2, 2, 2, 2);
        Time b = Time.newInstance(1, 1, 1, 1);
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(1, results, 'The result should be 1');
    }

    @IsTest
    private static void testTimeEqual() {
        Time a = Time.newInstance(1, 1, 1, 1);
        Time b = Time.newInstance(1, 1, 1, 1);
        ObjectComparator comparator = new ObjectComparator();
        Test.startTest();
        Integer results = (Integer) comparator.compare(a, b);
        Test.stopTest();
        Assert.areEqual(0, results, 'The result should be 0');
    }

    @IsTest
    private static void testIdLessThan() {

        Integer sObjNum = 1;
        Schema.SObjectType sot = Account.sObjectType;
        String result = String.valueOf(sObjNum++);
        Id a = (Id) (result + sot.getDescribe().getKeyPrefix().rightPad(15 - result.length(), '0'));
        result = String.valueOf(sObjNum++);
        Id b = (Id) (result + sot.getDescribe().getKeyPrefix().rightPad(15 - result.length(), '0'));

        Test.startTest();
        ObjectComparator comparator = new ObjectComparator();
        Test.stopTest();
        Integer results = (Integer) comparator.compare(a, b);
        Assert.areEqual(-1, results, 'The result should be -1');
    }

    @IsTest
    private static void testIdGreaterThan() {
        Integer sObjNum = 1;
        Schema.SObjectType sot = Account.sObjectType;
        String result = String.valueOf(sObjNum++);
        Id a = (Id) (result + sot.getDescribe().getKeyPrefix().rightPad(15 - result.length(), '0'));
        result = String.valueOf(sObjNum++);
        Id b = (Id) (result + sot.getDescribe().getKeyPrefix().rightPad(15 - result.length(), '0'));

        Test.startTest();
        ObjectComparator comparator = new ObjectComparator();
        Test.stopTest();
        Integer results = (Integer) comparator.compare(b, a);
        Assert.areEqual(1, results, 'The result should be 1');        
    }

    @IsTest
    private static void testIdEqual() {
        Integer sObjNum = 1;
        Schema.SObjectType sot = Account.sObjectType;
        String result = String.valueOf(sObjNum++);
        Id a = (Id) (result + sot.getDescribe().getKeyPrefix().rightPad(15 - result.length(), '0'));

        Test.startTest();
        ObjectComparator comparator = new ObjectComparator();
        Test.stopTest();
        Integer results = (Integer) comparator.compare(a, a);
        Assert.areEqual(0, results, 'The result should be 0');       
    }

    @IsTest
    private static void testCompareDiffObjects() {
        Integer a = 1;
        String b = 'a';
        ObjectComparator comparator = new ObjectComparator();
        String exMessage;
        Test.startTest();
        try {
            comparator.compare(a, b);
        } catch (Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();
        Assert.isTrue(
            exMessage != null &&
            exMessage.contains('These objects must be of the same type'),
            'The result should be an exception'
        );
    }
}