# 🚀 Jump Start Your Deployments!

Salesforce Moxygen is an intuitive Salesforce mocking library for Apex unit testing that can reduce deployment times from two hours to two minutes!

Moxygen is unique from other Apex mocking libraries in that it includes a functional in-memory mock database that can handle most SOQL queries, parse them, and return the correct results. This means, in most cases, it is not required to specify what's returned from queries or to stub a data access object.

## Example

Lets say you have an AccountService class like so:
 
```
public class AccountService {

    public void updateAcctName(Id accountId) {

        Map<String, Object> binds = new Map<String, Object> {
            'acctId' => accountId
        };

        // one-to-one wrapper around Database.queryWithBinds
        List<Account> acctList = Selector.queryWithBinds(
            'SELECT Name FROM Account WHERE Id = :acctId',
            binds,
            AccessLevel.USER_MODE
        );

        for(Account acct : acctList) {
            acct.Name = 'WOOOO!!!!';
        }

        // one-to-one wrapper around Database.update
        DML.doUpdate(acctList, true);
    }
}
```

To test this, you can create an account with an @TestSetup class... orr....

```
@IsTest
public class AccountServiceTest {

    @IsTest
    private static void testUpdateAcctNameUnitTest() {
	// Moxygen already knows its in a unit test, no setup required
	
        Account newAcct = new Account(
            Name = 'Lame'
        );
	
	// Does an insert without registering that DML was performed
        DML.doMockInsert(newAcct);

        AccountService service = new AccountService();

        Assert.isFalse(
            DML.didAnyDML(),
            'Expected no DML statement to register'
        );

        Test.startTest();
            service.updateAcctName(newAcct.Id);
        Test.stopTest();

        Account updatedAcct = (Account) Selector.selectRecordById(newAcct.Id);

        // Did we actually update the record?
        Assert.areEqual(
            'WOOOO!!!!',
            updatedAcct.Name,
            'Expected account name to be updated'
        );

        // check for any DML
        Assert.isTrue(
            DML.didAnyDML(),
            'Expected DML to fire'
        );

        // check for a specific DML operation
        Assert.isTrue(
            DML.didDML(Types.DML.UPDATED),
            'Expected data to be updated'
        );

        // did we call a query?
        Assert.isTrue(
            Selector.calledAnyQuery(),
            'Expected some query to be called'
        );

        // check that our specific query was called
        Assert.isTrue(
            Selector.calledQuery('SELECT Name FROM Account WHERE Id = :acctId'),
            'Expected query to be called'
        );
    }
    
    @IsTest
    private static void testUpdateAcctNameIntegrationTest() {
	// defaults to unit tests, need to specify when we want real DML and SOQL to fire off
	ORM.doIntegrationTest();
        
        Account newAcct = new Account(
            Name = 'Lame'
        );

        DML.doInsert(newAcct, true);

        AccountService service = new AccountService();

        Test.startTest();
            service.updateAcctName(newAcct.Id);
        Test.stopTest();
        
        Map<String, Object> acctBinds = new Map<String, Object> {
            'newAcctId' => newAcct.Id
        };
        List<Account> updatedAcctList = (List<Account>) Selector.queryWithBinds(
            'SELECT Name FROM Account WHERE Id = :newAcctId',
            acctBinds,
            AccessLevel.SYSTEM_MODE
        );
        Account updatedAcct = updatedAcctList[0];

        // Did we actually update the record?
        Assert.areEqual(
            'WOOOO!!!!',
            updatedAcct.Name,
            'Expected account name to be updated'
        );
    }
}
```

# 🧰 Documentation

[Reference Guide](./docs/apexdocs/index.md)

## UML Diagram
Still a rough-sketch for now, but this is the general organization of the codebase.

![UML Diagram](./docs/Moxygen UML.jpg)

# ❤️ Contribute
[Contributing](./CONTRIBUTING.md)

# 🥇 Mock SOQL Database

Under the hood, a mock SOQL parser is used to handle queries in the context of a unit test.

```
SELECT fieldList [subquery][...]
[TYPEOF typeOfField whenExpression[...] elseExpression END][...]
FROM objectType[,...] 
    [USING SCOPE filterScope]
[WHERE conditionExpression]
[WITH [DATA CATEGORY] filteringExpression]
[GROUP BY {fieldGroupByList|ROLLUP (fieldSubtotalGroupByList)|CUBE (fieldSubtotalGroupByList)} 
    [HAVING havingConditionExpression] ] 
[ORDER BY fieldOrderByList {ASC|DESC} [NULLS {FIRST|LAST}] ]
[LIMIT numberOfRowsToReturn]
[OFFSET numberOfRowsToSkip]
[{FOR VIEW  | FOR REFERENCE} ]
[UPDATE {TRACKING|VIEWSTAT} ]
[FOR UPDATE]
[WITH SECURITY_ENFORCED]
```

## Levels of Support
There are four categories of support for a SOQL query done via the mock SOQL database.
* Fully Supported
* Partially Supported
* Ignored
  * It won't throw an exception when parsed, but won't be applied by the mock database
* Not Supported
  * Throws a QueryException when read by the parser

### Supported Clauses
| Clause      | Level of Support    | Notes |
|-------------|---------------------|-------|
| SELECT      | Partially Supported | FORMAT(), convertCurrency(), convertTimezone(), GROUPING(), date functions, and toLabel() are not supported. |
| TYPEOF      | Fully Supported     ||
| FROM        | Fully Supported     ||
| USING SCOPE | Ignored             ||
| WHERE       | Partially Supported | Date functions and date literals are being gradually rolled out. |
| WITH        | Not Supported       ||
| GROUP BY    | Partially Supported | GROUP BY ROLLUP and GROUP BY CUBE are not supported |
| HAVING | Partially Supported | Date functions and date literals are being gradually rolled out. |
| ORDER BY | Fully Supported ||
| LIMIT | Fully Supported ||
| OFFSET | Fully Supported ||
| FOR VIEW\|REFERENCE | Ignored ||
| UPDATE TRACKING\|VIEWSTAT | Not Supported ||
| FOR UPDATE | Ignored ||
| WITH SECURITY_ENFORCED | Ignored | Syntax is enforced, will not allow this clause in sub-queries |

# ⚓ Core Apex Classes

## ORM

The ORM class acts as a simple state manager for the Selector and DML classes. It determines whether to make calls to the Database class or the MockDatabase class based on
the isUnitTest variable. This variable's value defaults to Test.isRunningTest(), but can be set to false via a call to ORM.doIntegrationTest().

### @TestVisible private static void doIntegrationTest()
Sets isUnitTest to false, causes DML and Selector class methods to use the Database class when doing DML statements or SOQL queries.

## Selector

The selector manages SOQL queries. It determines whether to use a call to the Database class or MockDatabase class
based on the context set in the ORM class. In normal usage, it calls Database methods, in a test class it defaults to
MockDatabase but this can be changed by calling ORM.doIntegrationTest();

- List\<SObject\> query(String queryString)
- List\<SObject\> query(String queryString, System.AccessLevel accessLevel)
- List\<SObject\> queryWithBinds(String queryString, Map\<String, Object\> bindMap, System.AccessLevel accessLevel)

- List\<Aggregate\> aggregateQuery(String queryString);
- List\<Aggregate\> aggregateQuery(String queryString, System.AccessLevel accessLevel);
- List\<Aggregate\> aggregateQueryWithBinds(String queryString, Map\<String, Object\> bindMap, System.AccessLevel accessLevel);

- Integer countQuery(String queryString)
- Integer countQuery(String queryString, System.AccessLevel accessLevel)
- Integer countQueryWithBinds(String queryString, Map\<String, Object\> bindMap, System.AccessLevel accessLevel)

There is also a suite of @TestVisible methods that are only available in the context of a unit test.

### @TestVisible private static SObject selectRecordById(Id recordId)

Retrieve a record from the mock database, by Id.

NOTE: This will grab deleted records.

### @TestVisible private static Boolean calledAnyQuery()

Returns whether any query was called.

### @TestVisible private static Boolean calledQuery(String queryString)

Returns whether a specific query was called.

### @TestVisible private static void registerQuery(String queryString, List\<SObject\> records)

Register a query so that when it is called, it returns a specific set of SObjects.
Because the SObjects are passed in a list, edits to these SObjects will be reflected
in the mock database (i.e. pointer logic).

If a query is registered, the mock soql database will not be used.

### @TestVisible private static void registerFailedQuery(String queryString)

Register a query such that when it is called, an exception is thrown.
This throws a generic QueryException.

### @TestVisible private static void registerAggregateQuery(String queryString, List\<Aggregate\> records)

Register an aggregate query to return a list of Aggregate objects when its called.

If a query is registered, the mock soql database will not be used.

### @TestVisible private static void registerFailedAggregateQuery(String queryString)

Register a failed aggregate query. Will throw a QueryException when called (via the queryAggregate methods).

### @TestVisible private static void registerCountQuery(String queryString, Integer count)

Register a count query (i.e. a call to queryCount).

If a query is registered, the mock soql database will not be used.

### @TestVisible private static void registerFailedCountQuery(String queryString)

Register a failed count query. Throws a QueryException.

## DML

The DML class handles DML statements. Just like the Selector class, it determines whether to make calls to the Database or MockDatabase class
based on the context set in the ORM class. In normal usage, it calls Database methods, in a test class it defaults to
MockDatabase but this can be changed by calling ORM.doIntegrationTest();

- Database.DeleteResult doDelete(SObject recordToDelete, Boolean allOrNone)
- List\<Database.DeleteResult\> doDelete(List\<SObject\> recordsToDelete, Boolean allOrNone)
- Database.DeleteResult doDelete(Id recordID, Boolean allOrNone)
- List\<Database.DeleteResult\> doDelete(List\<Id\> recordIDs, Boolean allOrNone)

- Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone)
- List\<Database.SaveResult\> doInsert(List\<SObject\> recordsToInsert, Boolean allOrNone)
- Database.SaveResult doInsert(SObject recordToInsert, Boolean allOrNone, System.AccessLevel accessLevel)
- List\<Database.SaveResult\> doInsert(List\<SObject\> recordsToInsert, Boolean allOrNone, System.AccessLevel accessLevel)

- Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone)
- List\<Database.SaveResult\> doUpdate(List\<SObject\> recordsToUpdate, Boolean allOrNone)
- Database.SaveResult doUpdate(SObject recordToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)
- List\<Database.SaveResult\> doUpdate(List\<SObject\> recordsToUpdate, Boolean allOrNone, System.AccessLevel accessLevel)

- Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone)
- List\<Database.UpsertResult\> doUpsert(List\<SObject\> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone)
- Database.UpsertResult doUpsert(SObject recordToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)
- List\<Database.UpsertResult\> doUpsert(List\<SObject\> recordsToUpsert, SObjectField externalIdField, Boolean allOrNone, System.AccessLevel accessLevel)

- Database.UndeleteResult doUndelete(sObject recordToUndelete, Boolean allOrNone)
- List\<Database.UndeleteResult\> doUndelete(List\<SObject\> recordsToUndelete, Boolean allOrNone)
- Database.UndeleteResult doUndelete(Id recordID, Boolean allOrNone)
- List\<Database.UndeleteResult\> doUndelete(List\<Id\> recordIDs, Boolean allOrNone)
- Database.UndeleteResult doUndelete(SObject recordToUndelete, Boolean allOrNone, System.AccessLevel accessLevel)

This class also contains a suite of @TestVisible methods that can only be used in the context of a unit test.

### @TestVisible private static doMockInsert(SObject recordToInsert)

Inserts a record into the mock database without registering an insert.

### @TestVisible private static doMockInsert(List\<SObject\> recordsToInsert)

Inserts a list of records into the mock database without registering an insert.

### @TestVisible private static Boolean didAnyDML()

Returns whether any DML, aside from calls to doMockInsert, were made.

### @TestVisible private static Boolean didDML(Types.DML type)

Returns whether a specific DML operation was performed, excluding calls to doMockInsert.
The options for type are:

Types.DML.INSERTED
Types.DML.UPSERTED
Types.DML.UPDATED
Types.DML.DELETED
Types.DML.UNDELETED

### @TestVisible private Boolean isDeleted(Id recordId)

Returns whether a record has been deleted, given the fake ID
that was created for it when it was inserted

## Aggregate

This object is a wrapper around AggregateResult. The reason for its existence is that
AggregateResult objects cannot be mocked. It takes the AggregateResult record, and perserves
it as a read-only Map\<String, Object\>.

### public Object get(String field)

Returns the value on the aggregate keyed by "field"
