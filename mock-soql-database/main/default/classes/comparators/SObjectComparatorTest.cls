@isTest
private class SObjectComparatorTest {

    @isTest
    private static void testCompareEqual() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Name',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };

        Account a1 = new Account(Name = 'Test Account');
        Account a2 = new Account(Name = 'Test Account');
        SObjectComparator comparator = new SObjectComparator(fieldData);
        
        Test.startTest();
        Integer result = comparator.compare(a1, a2);
        Test.stopTest();

        Assert.areEqual(0, result, 'The two accounts should be equal');
    }

    @isTest
    private static void testCompareLessThan() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Name',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };
        Account a1 = new Account(Name = 'Test Account');
        Account a2 = new Account(Name = 'Test Account 2');
        SObjectComparator comparator = new SObjectComparator(fieldData);
        Test.startTest();
        Integer result = comparator.compare(a1, a2);
        Test.stopTest();

        Assert.isTrue(
            result < 0, 
            'The first account should be less than the second'
        );
    }

    @isTest
    private static void testComparGreaterThan() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Name',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };
        Account a1 = new Account(Name = 'Test Account 2');
        Account a2 = new Account(Name = 'Test Account');
        SObjectComparator comparator = new SObjectComparator(fieldData);
        Test.startTest();
        Integer result = comparator.compare(a1, a2);
        Test.stopTest();

        Assert.isTrue(
            result > 0, 
            'The first account should be greater than the second'
        );
    }

    @IsTest
    private static void testCompareNull() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Name',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };
        Account a1 = new Account(Name = 'Test Account');
        Account a2 = new Account(Name = null);
        SObjectComparator comparator = new SObjectComparator(fieldData);
        Test.startTest();
        Integer result = comparator.compare(a1, a2);
        Test.stopTest();

        Assert.isTrue(
            result < 0, 
            'The first account should be less than the second'
        );
    }

    @IsTest
    private static void testCompareNullFirst() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Name',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };
        Account a1 = new Account(Name = null);
        Account a2 = new Account(Name = 'Test Account');
        SObjectComparator comparator = new SObjectComparator(fieldData);
        Test.startTest();
        Integer result = comparator.compare(a1, a2);
        Test.stopTest();

        Assert.isTrue(
            result < 0, 
            'The first account should be less than the second'
        );
    }

    @IsTest
    private static void testCompareNullEqual() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Name',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };
        Account a1 = new Account(Name = null);
        Account a2 = new Account(Name = null);
        SObjectComparator comparator = new SObjectComparator(fieldData);
        Test.startTest();
        Integer result = comparator.compare(a1, a2);
        Test.stopTest();

        Assert.areEqual(0, result, 'The two accounts should be equal');
    }

    @IsTest
    private static void testParentField() {
        Map<String, Map<String, String>> fieldData;
        Map<String, String> fieldDatum1 = new Map<String, String>{
            'fieldApiName' => 'Account.Name',
            'relationshipName' => 'Account.Name',
            'order' => 'asc',
            'nullDir' => 'first'
        };
        fieldData = new Map<String, Map<String, String>>{
            'Name' => fieldDatum1
        };
        Account a1 = new Account(Name = 'Test Account');
        Account a2 = new Account(Name = 'Test Account');

        MockDatabase db = new MockDatabase();
        db.doInsert(new List<Account>{a1, a2});

        Contact con1 = new Contact(LastName = 'Test Contact', AccountId = a1.Id);
        Contact con2 = new Contact(LastName = 'Test Contact', AccountId = a2.Id);
        db.doInsert(new List<Contact>{con1, con2});

        List<Contact> queriedCons = (List<Contact>) db.query('SELECT Account.Name FROM Contact');

        SObjectComparator comparator = new SObjectComparator(fieldData);
        Test.startTest();
        Integer result = comparator.compare(queriedCons[0], queriedCons[1]);
        Test.stopTest();

        Assert.areEqual(0, result, 'The two contacts should be equal');
    }

}