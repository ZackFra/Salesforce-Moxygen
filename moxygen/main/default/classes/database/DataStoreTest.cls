@isTest
private class DataStoreTest {
    @isTest
    static void ensurePutThrowsExceptionIfIdIsNull() {
        Account acct = new Account(Name = 'Test Account');

        Boolean isIllegalArgumentExceptionThrown = false;
        try {
            DataStore.put(acct);
            Assert.fail('Expected exception not thrown');
        } catch (IllegalArgumentException e) {
            isIllegalArgumentExceptionThrown = true;
        }
        Assert.isTrue(
            isIllegalArgumentExceptionThrown,
            'Expected exception to be thrown'
        );
    }

    @isTest
    static void ensurePutPlacesTheRecordInTheDataStore() {
        Account acct = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account'
        );

        DataStore.put(acct);

        Account acctFromStore = (Account) DataStore.getById(acct.Id);
        Assert.isNotNull(acctFromStore, 'Account should be in the data store');
        Assert.areEqual(acct.Id, acctFromStore.Id, 'Account Id should match');
    }

    @isTest
    static void ensurePutWorksWithMultipleRecords() {
        Account acct1 = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account 1'
        );
        Account acct2 = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account 2'
        );

        List<Account> accts = new List<Account>{ acct1, acct2 };
        DataStore.put(accts);

        Account acctFromStore1 = (Account) DataStore.getById(acct1.Id);
        Assert.isNotNull(acctFromStore1, 'Account should be in the data store');
        Account acctFromStore2 = (Account) DataStore.getById(acct2.Id);
        Assert.isNotNull(acctFromStore2, 'Account should be in the data store');
        Assert.areEqual(acct1.Id, acctFromStore1.Id, 'Account Id should match');
        Assert.areEqual(acct2.Id, acctFromStore2.Id, 'Account Id should match');
    }

    @isTest
    static void ensureSoftDeletionWorks() {
        Account acct = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account'
        );

        DataStore.put(acct);
        DataStore.softDelete(acct.Id);

        Assert.isTrue(
            DataStore.isSoftDeleted(acct.Id),
            'Account should be marked as deleted'
        );
    }

    @isTest
    static void ensureIsRecordInDataStoreWorks() {
        Account acct1 = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account 1'
        );

        Account acct2 = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account 2'
        );

        DataStore.put(acct1);
        Assert.isTrue(
            DataStore.isRecordInDataStore(acct1.Id),
            'Account should be in the data store'
        );
        Assert.isFalse(
            DataStore.isRecordInDataStore(acct2.Id),
            'Account should not be in the data store'
        );
    }

    @isTest
    static void ensureCountWorksCorrectly() {
        Account acct1 = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account 1'
        );

        Account acct2 = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account 2'
        );

        DataStore.put(acct1);
        DataStore.put(acct2);

        Assert.areEqual(2, DataStore.count(), 'Count should be 2');
    }

    @isTest
    static void ensureRestoreWorks() {
        Account acct = new Account(
            Id = fflib_IdGenerator.generate(Schema.Account.SObjectType),
            Name = 'Test Account'
        );

        DataStore.put(acct);
        DataStore.softDelete(acct.Id);
        Assert.isTrue(
            DataStore.isSoftDeleted(acct.Id),
            'Account should be marked as deleted'
        );

        DataStore.restore(acct.Id);
        Assert.isFalse(
            DataStore.isSoftDeleted(acct.Id),
            'Account should not be marked as deleted'
        );
    }
}
