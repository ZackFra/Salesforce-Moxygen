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
    static void ensureBuildStandardComparableRecordData() {
        Account acct = new Account(
            Name = 'Test'
        );

        String comparableField = 'Name';

        Test.startTest();
        ComparableRecordData comparableData = ComparableService.buildStandardComparableRecordData(acct, comparableField);
        Test.stopTest();

        Assert.areEqual(
            acct,
            comparableData.getComparableRecord(),
            'Comparable record should be the account'
        );

        Assert.areEqual(
            comparableField,
            comparableData.getComparableFieldName(),
            'Comparable field name should be the field'
        );

        Assert.isNull(
            comparableData.getRelationshipName(),
            'Relationship name should be null'
        );

        Assert.isFalse(
            comparableData.getIsPolymorphic(),
            'Is polymorphic should be false'
        );
    }
}