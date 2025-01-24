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
        Assert.areEqual(
            comparableRecord.getSObjectType(),
            Account.getSObjectType(),
            'Parent record should be returned'
        );
        Assert.areEqual(
            acct.Name,
            comparableRecord.get('Name'),
            'Parent field should be returned'
        );
    }

    @isTest
    static void ensureQueriedFieldResolverReturnsParentFieldMultipleLevelsUp() {
        Account acct0 = new Account(Name = 'Test0');
        MockDatabase.doInsert(acct0, true);
        Account acct1 = new Account(Name = 'Test1', ParentId = acct0.Id);
        MockDatabase.doInsert(acct1, true);
        Account acct2 = new Account(Name = 'Test2', ParentId = acct1.Id);
        MockDatabase.doInsert(acct2, true);
        Account acct3 = new Account(Name = 'Test3', ParentId = acct2.Id);
        MockDatabase.doInsert(acct3, true);

        String fieldLookupChain = 'Parent.Parent.Parent.Name';

        Test.startTest();
        ComparableRecordData comparableInfo = new QueriedFieldResolver.Builder()
            .setComparableRecord(acct3)
            .setFieldLookupChain(fieldLookupChain)
            .build()
            .resolve();
        Test.stopTest();
        SObject comparableRecord = comparableInfo.getComparableRecord();
        Assert.areEqual(
            comparableRecord.getSObjectType(),
            Account.getSObjectType(),
            'Parent record should be returned'
        );
        Assert.areEqual(
            acct0.Name,
            comparableRecord.get('Name'),
            'Parent field should be returned'
        );
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
        Assert.areEqual(
            comparableRecord.getSObjectType(),
            Contact.getSObjectType(),
            'Record should be returned'
        );
        Assert.areEqual(
            con.FirstName,
            comparableRecord.get('FirstName'),
            'Field should be returned'
        );
    }
}
