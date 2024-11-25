@isTest
private class ComparableServiceTest {

    @isTest
    static void ensureIsParentFieldIdentifiesParentLookups() {
        String fieldLookupChain = 'Account.Parent.Name';
        Test.startTest();
        Boolean isParentField = ComparableService.isParentRecordLookup(fieldLookupChain);
        Test.stopTest();

        Assert.isTrue(isParentField, 'Field lookup chain should be a parent field');
    }

    @isTest
    static void ensureIsParentRecordLookupIdentifiesLocalFields() {
        String fieldLookupChain = 'Name';
        Test.startTest();
        Boolean isParentField = ComparableService.isParentRecordLookup(fieldLookupChain);
        Test.stopTest();

        Assert.isFalse(isParentField, 'Field lookup chain should not be a parent field');
    }

    @isTest
    static void ensureGetComparablesReturnsParentField() {
        String fieldLookupChain = 'Account.Name';
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Contact con = new Contact(AccountId = acct.Id);
        MockDatabase.doInsert(con, true);

        Test.startTest();
        ComparableRecordData comparableInfo = ComparableService.getComparables(con, fieldLookupChain);
        Test.stopTest();

        SObject record = comparableInfo.getComparableRecord();
        Assert.areEqual(acct.Name, record.get('Name'), 'Parent field should be returned');
    }
}