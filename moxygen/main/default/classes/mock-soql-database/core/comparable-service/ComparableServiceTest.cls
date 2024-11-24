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
}