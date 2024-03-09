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

        Map<String, Object> binds = new Map<String, Object> {
            'acctId' => accountId
        };

        // one-to-one wrapper around Database.queryWithBinds
        List<Account> acctList = db.getSelector().queryWithBinds(
            'SELECT Name FROM Account WHERE Id = :acctId',
            binds,
            AccessLevel.USER_MODE
        );

        for(Account acct : acctList) {
            acct.Name = 'WOOOO!!!!';
        }

        // one-to-one wrapper around Database.update
        db.getDML().doUpdate(acctList, true);
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
        MockDML dml = (MockDML) mockDatabase.getDML();

        Account newAcct = new Account(
            Name = 'Lame'
        );

        // this will add a fake id, fake system mod stamp,
        // fake ownerId, etc. - returns a reference to what is literally in the database
        Account insertedAcct = (Account) dml.doMockInsert(newAcct);
        List<Account> acctList = new List<Account> { insertedAcct };

        // when this query is made, return the account list
        mockDatabase.registerQuery(
            'SELECT Name FROM Account WHERE Id = :acctId',
            acctList
        );

        AccountsService service = new AccountsService()
            .setORM(mockDatabase);

        // we used doMockInsert, so no DML is registered
        Assert.isFalse(
            mockDatabase.didAnyDML(),
            'Expected no DML statement to register'
        );

        Test.startTest();
            service.updateAcctName(insertedAcct.Id);
        Test.stopTest();

        // Did we actually update the record?
        Assert.areEqual(
            'WOOOO!!!!',
            insertedAcct.Name,
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

- List<Aggregate> queryAggregate(String queryString);
- List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel);
- List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);

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

Resets the tracking on queries and DML operations, does NOT reset the mock database records.

#### public void resetDML()

Resets the tracking on DML operations

#### public void resetSelector()

Resets the tracking on SOQL queries

#### public void registerQuery(String queryString, List<SObject> records)

Register a query so that when it is called, it returns a specific set of SObjects.
Because the SObjects are passed in a list, edits to these SObjects will be reflected
in the mock database (i.e. pointer logic)

#### public void registerFailedQuery(String queryString)

Register a query such that when it is called, an exception is thrown.
This throws a generic QueryException.

#### public void registerAggregateQuery(String queryString, List<Aggregate> records)

Register an aggregate query to return a list of Aggregate objects when its called.

#### public void registerFailedAggregateQuery(String queryString)

Register a failed aggregate query. Will throw a QueryException when called (via the queryAggregate methods).

#### public void registerCountQuery(String queryString, Integer count)

Register a count query (i.e. a call to queryCount).

#### public void registerFailedCountQuery(String queryString)

Register a failed count query. Throws a QueryException.

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

#### public List<SObject> query(String queryString)

- Returns a list of SObjects if this query was registered via "registerQuery",
- Throws an exception if this query was registered via "registerFailedQuery",
- Returns an empty List of SObjects if this query was not registered

#### public List<SObject> query(String queryString, System.AccessLevel accessLevel)

Same behavior as query, accessLevel is ignored.

#### public List<SObject> queryWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel)

Same behavior as query, bindMap and accessLevel are ignored.

#### public List<Aggregate> queryAggregate(String queryString)

- Returns a list of Aggregates if this query was registered via "registerAggregateQuery",
- Throws an exception if this query was registered via "registerFailedAggregateQuery",
- Returns an empty List of Aggregates if this query was not registered

#### public List<Aggregate> queryAggregate(String queryString, System.AccessLevel accessLevel)

Same behavior as queryAggregate, accessLevel is ignored

#### List<Aggregate> queryAggregateWithBinds(String queryString, Map<String, Object> bindMap, System.AccessLevel accessLevel);

Same behavior as queryAggregate, bindMap and accessLevel are ignored.

### MockDML

The MockDML methods update the system fields on the SOBject and persist them to a mock database
under the hood.

Unique methods for this class, that aren't covered by IDML or are hoisted to MockORM are,

#### List<SObject> doMockInsert(List\<SObject\> recordsToInsert)

Inserts a list of records into the mock database without it registering as a DML statement,
used for setting mock data. Populates system fields.

Returns a reference to the SObject in the database.

#### SObject doMockInsert(SObject recordToInsert)

Inserts a record into the mock database. Populates system fields.

Returns a reference to the SObject in the database.

### Aggregate

This object is a wrapper around AggregateResult. The reason for its existence is that
AggregateResult objects cannot be mocked. It takes the AggregateResult record, and perserves
it as a read-only Map<String, Object>.

#### public Object get(String field)

Returns the value on the aggregate keyed by "field"

### RelationshipBuilder

Utility for relating child and parent records for mock queries.

This class has two methods

#### public ChildRelationshipBuilder relateChildren()

Returns a ChildRelationshipBuilder to relate one record (the parent)
to many children.

This class has five methods, four of which are setters and then there is the
build method which returns the connected SObject.

- public ChildRelationshipBuilder setParent(SObject parent)
- public ChildRelationshipBuilder setChildren(List<SObject> children)
- public ChildRelationshipBuilder setRelationshipName(String relationshipName)
- public ChildRelationshipBuilder setRelationshipField(String relationshipField)
- public SObject build()

Note: calling `build()` will throw an illegal argument exception if any of the
fields are not set.

#### public ParentRelationshipBuilder relateParent()

Returns a ParentRelationshipBuilder to relate one record (the child)
to the parent.

This class has five methods, four of which are setters, and then there is the
build method which returns the connected SObject.

- public ParentRelationshipBuilder setChild(SObject child)
- public ParentRelationshipBuilder setParent(SObject parent)
- public ParentRelationshipBuilder setRelationshipName(String relationshipName)
- public ParentRelationshipBuilder setRelationshipField(String relationshipField)
- public SObject build()

Note: calling `build()` will throw an illegal argument exception if any of the
fields are not set.

ex.

```
// [SELECT Account.Name FROM Opportunity]
Opportunity oppWithAcct = (Opportunity) new RelationshipBuilder()
    .relateParent()
        .setChild(opp)
        .setParent(acct)
        .setRelationshipField('AccountId')
        .setRelationshipName('Account')
        .build();

// [SELECT (SELECT Name FROM Opportunties) FROM Account]
Account acctWithOpps = (Account) new RelationshipBuilder()
    .relateChildren()
        .setParent(acct)
        .setChildren(oppList)
        .setRelationshipField('AccountId')
        .setRelationshipName('Opportunities')
        .build();
```
