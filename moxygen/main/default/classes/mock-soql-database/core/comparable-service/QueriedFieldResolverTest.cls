@isTest
private class QueriedFieldResolverTest {

    @isTest
    static void ensureQueriedFieldResolverReturnsParentField() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Contact con = new Contact(AccountId = acct.Id);
        MockDatabase.doInsert(con, true);

        String fieldLookupChain = 'Account.Name';

        Test.startTest();
        ComparableRecordData comparableInfo = new QueriedFieldResolver.Builder()
            .setComparableRecord(con)
            .setFieldLookupChain(fieldLookupChain)
            .build()
            .resolve();
        Test.stopTest();
        SObject comparableRecord = comparableInfo.getComparableRecord();
        Assert.areEqual(comparableRecord.getSObjectType(), Account.getSObjectType(), 'Parent record should be returned');
        Assert.areEqual(acct.Name, comparableRecord.get('Name'), 'Parent field should be returned');
    }

    @isTest
    static void ensureQueriedFieldResolverReturnsField() {
        Contact con = new Contact(FirstName = 'Tess', LastName = 'Thurman');
        MockDatabase.doInsert(con, true);

        String fieldLookupChain = 'FirstName';

        Test.startTest();
        ComparableRecordData comparableInfo = new QueriedFieldResolver.Builder()
            .setComparableRecord(con)
            .setFieldLookupChain(fieldLookupChain)
            .build()
            .resolve();
        Test.stopTest();

        SObject comparableRecord = comparableInfo.getComparableRecord();
        Assert.areEqual(comparableRecord.getSObjectType(), Contact.getSObjectType(), 'Record should be returned');
        Assert.areEqual(con.FirstName, comparableRecord.get('FirstName'), 'Field should be returned');
    }
}