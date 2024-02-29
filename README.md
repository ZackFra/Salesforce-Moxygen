# Moxygen

Moxygen is a light-weight Salesforce mocking framework for Apex unit testing.

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
            (Account) mDML.selectRecordById(acct.Id)
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
        mockDatabase.reset();

        Test.startTest();
            service.updateAcctName(acct.Id);
        Test.stopTest();
        
        acct = (Account) mDML.selectRecordById(acct.Id);
        
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

## Methods

Coming soon...
