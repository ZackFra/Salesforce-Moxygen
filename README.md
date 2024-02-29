# Salesforce Moxygen

Salesforce Moxygen is a light-weight Salesforce mocking framework for Apex unit testing.

The ORM object encapsulates both DML and query logic by creating non-static wrappers around
their respective static Database metods.

Using this, we can mock the Selector and DML classes using interface trickery.

## Example

Lets say you have an AccountsService class like so:
```
public with sharing class AccountsService {
    
    private IORM db = new ORM();
    @TestVisible
    public AccountsService setORM(IORM db) {
        this.db = db;
        return this;
    }

    public void updateAcctName(Id accountId) {
        ISelector selector = ORM.getSelector();
        IDML dml = ORM.getDML();

        Map<String, Object> binds = new Map<String, Object> {
            'acctId' => accountId
        };

        // one-to-one wrapper around Database.queryWithBinds
        List<Account> acctList = selector.queryWithBinds(
            'SELECT Name FROM Account WHERE Id = :acctId', 
            binds, 
            AccessLevel.USER_MODE
        );
        
        for(Account acct : acctList) {
            acct.Name = 'WOOOO!!!!';
        }
        
        // one-to-one wrapper around Database.update
        dml.doUpdate(acctList, true);
    }
}
```

To test this, you can create an account with an @TestSetup class... orr....

```
@IsTest
public class AccountsServiceTest {
	
    @IsTest
    private static void testUpdateAcctName() {
        MockORM mockDatabase = new MockORM();
        MockSelector mSelector = (MockSelector) mockDatabase.getSelector();
        MockDML mDML = (MockDML) mockDatabase.getDML();
        
        Account acct = new Account(Name = 'Lame');
        // this will add a fake id, fake system mod stamp,
        // fake ownerId, etc.
        mDML.doInsert(
            acct,
            true
        );
        
        // pull the full record from the mocked database
        List<Account> acctList = new List<Account> {
            (Account) mockDatabase.selectRecordById(acct.Id)
        };
        
        // when this query is made, return the account list
        mSelector.registerQuery(
            'SELECT Name FROM Account WHERE Id = :acctId',
            acctList
        );
        
        AccountsService service = new AccountsService()
            .setORM(mockDatabase);
        
        // doesn't reset the records, resets whether
        // the DML/Selector methods have been called
        // i.e. we just did an insert, if we ask
        // "did this do an insert?" it's gonna say yes
        mockDatabase.reset();

        Test.startTest();
            service.updateAcctName(acct.Id);
        Test.stopTest();
        
        acct = (Account) mockDatabase.selectRecordById(acct.Id);
        
        // Did we actually update the record? 
        Assert.areEqual(
            'WOOOO!!!!', 
            acct.Name,
            'Expected account name to be updated'
        );

        // check for any DML
        Assert.isTrue(
            mockDatabase.didAnyDML(),
            'Expected DML to fire'
        );


        // check for a specific DML operation
        Assert.isTrue(
            mockDatabase.didDML(Types.DML.UPDATED),
            'Expected data to be updated'
        );

        // did we call a query?
        Assert.isTrue(
            mockDatabase.calledAnyQuery(),
            'Expected some query to be called'
        );

        // check that our query was called
        Assert.isTrue(
            mockDatabase.calledQuery('SELECT Name FROM Account WHERE Id = :acctId'),
            'Expected query to be called'
        );
    }
}
```

## Classes

### IORM

The IORM interface defines two methods that can be expected to exist on both the MockORM and ORM classes,

- ISelector getSelector()
- IDML getDML() 

### ISelector

The ISelector interface defines three methods,

- List<SObject> query(String queryString)
- List<SObject> query(String queryString, System.AccessLevel accessLevel)
- List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel)

### IDML

The IDML interface defines the following methods, reflecting their equivalent static Database methods.


- Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
- List<Database.DeleteResult> doDelete(List<SObject> recordsToDelete, Boolean allOrNone)
- Database.DeleteResult doDelete(Id recordID, Boolean allOrNone)
- List<Database.DeleteResult> doDelete(List<Id> recordIDs, Boolean allOrNone)

- Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone)
- List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone)
- Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
- List<Database.SaveResult> doInsert(List<SObject> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel)

- Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone)
- List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone)
- Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
- List<Database.SaveResult> doUpdate(List<SObject> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)

- Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone)
- List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone)
- Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
- List<Database.UpsertResult> doUpsert(List<SObject> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)

- Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone)
- List<Database.UndeleteResult> doUndelete(List<SObject> recordsToUndelete, Boolean allOrNone)
- Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone)
- List<Database.UndeleteResult> doUndelete(List<Id> recordIDs, Boolean allOrNone)
- Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel)

### ORM

The ORM class is the implementation of the IORM that that is meant for regular use.

#### ISelector getSelector()

Returns a Selector object

#### getDML() 

Returns a DML object

### Selector

The Selector class implements the ISelector methods as wrappers around their Database methods.
ex.

```
public List<SObject> query(String queryString) {
    return Database.query(queryString);
}
```

### DML

The DML class class is a wrapper around the DML-related Database methods. They behave the same as
the Selector methods. The only thing to note is that DML operations are reserved words in Apex, so
all methods are prefixed with "do",

i.e.
- doUpdate
- doInsert
- doUpsert
- etc.

### MockORM

The MockORM object is used for mocking database interactions. It keeps a mock database tracked
internally for records that have been fake-inserted.

#### ISelector getSelector()
Returns a MockSelector object

#### IDML getDML()
Returns a MockDML object

These need to be cast to MockDML and MockSelector get the full use out of them.
For testing, the following methods are also defined,

#### public Boolean didAnyDML()

Returns where any DML operation was performed by the mock database.

#### public Boolean didDML(Types.DML type)

Returns whether a specific DML operation was performed.
The options for type are:

Types.DML.INSERTED
Types.DML.UPSERTED
Types.DML.UPDATED
Types.DML.DELETED
Types.DML.UNDELETED

#### public Boolean calledAnyQuery()

Returns whether any query was called.

#### public Boolean calledQuery(String queryString)

Returns whether a specific query was called.

#### public void reset()

Resets the tracking on queries and DML operations, does NOT reset the mock database records. This is
used to reset the query and DML operation checks after building out any required test data.

If you do a bunch of "doInsert" calls to populate the database, then mockDatabase.didAnyDML() will
return true, which is not what we want to happen before any testing has begun.

#### public void resetDML()

Resets the tracking on DML operations

#### public void resetSelector()

Resets the tracking on SOQL queries

#### public Boolean isDeleted(Id recordId)

Returns whether a record has been deleted, given the fake ID
that was created for it when it was inserted

#### public SObject selectRecordById(Id recordId)

Retrieve a non-deleted record from the mock database, by Id.

#### public SObject selectDeletedRecordById(Id recordId)

If a record is deleted, it is still tracked. This allows us to 
retrieve the deleted record.

NOTE: The IsDeleted field will not be set on the record

#### public Integer size()

Returns the number of non-deleted records in the mock database.

#### public Integer deletedSize()

Returns the number of deleted records in the mock database.

### MockSelector

This is a mock version of the selector. 

#### public MockSelector registerQuery(String queryString, List<SObject> records)

Register a query so that when it is called, it returns a specific set of SObjects.
Because the SObjects are passed in a list, edits to these SObjects will be reflected
in the mock database (i.e. pointer logic)

#### public MockSelector registerFailedQuery(String queryString)

Register a query such that when it is called, an exception is thrown.
This throws a generic QueryException.

#### public List<SObject> query(String queryString)

- Returns a list of SObjects if this query was registered via "registerQuery",
- Throws an exception if this query was registered via "registerFailedQuery",
- Returns an empty List of SObjects if this query was not registered

#### public List<SObject> query(String queryString, System.AccessLevel accessLevel)

Same behavior as query, accessLevel is ignored.

#### public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel)

Same behavior as query, bindMap and accessLevel are ignored.

### MockDML

MockDML has no special methods that aren't already propagated up to the MockORM class.