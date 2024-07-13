@IsTest
public class AccountServiceTest {

    @IsTest
    private static void testUpdateAcctName() {

        Account newAcct = new Account(
            Name = 'Lame'
        );

        DML.doMockInsert(newAcct);

        AccountService service = new AccountService();

        // we used doMockInsert, so no DML is registered
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

        // check that our query was called
        Assert.isTrue(
            Selector.calledQuery('SELECT Name FROM Account WHERE Id = :acctId'),
            'Expected query to be called'
        );
    }
    
    @IsTest
    private static void testUpdateAcctNameIntegrationTest() {
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