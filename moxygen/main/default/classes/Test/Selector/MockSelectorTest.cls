/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
*/

@IsTest
@SuppressWarnings('PMD.CyclomaticComplexity')
private class MockSelectorTest {
    @IsTest
    private static void testSelectQueryWithMockDatabase() {

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Test.startTest();
        List<Account> selectedAccounts = Selector.query('SELECT Id, Name FROM Account');
        Test.stopTest();
        Assert.areEqual(
            10,
            selectedAccounts.size(),
            'The number of selected accounts should be 10'
        );
    }

    @IsTest
    static void testSelectQueryWithBindsWithMockDatabase() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Test.startTest();
        List<Account> selectedAccounts = Selector.queryWithBinds(
            'SELECT Id, Name FROM Account WHERE Name = :name', 
            new Map<String, Object>{'name' => 'Test Account 1'},
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            selectedAccounts.size(),
            'The number of selected accounts should be 1'
        );
    }

    @IsTest
    private static void testCountQueryWithMockDatabase() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Test.startTest();
        Integer accountSize = Selector.countQuery('SELECT COUNT() FROM Account');
        Test.stopTest();
        Assert.areEqual(
            10,
            accountSize,
            'The number of selected accounts should be 10'
        );        
    }

    @IsTest
    private static void testCountQueryWithBindsWithMockDatabase() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Test.startTest();
        Integer accountSize = Selector.countQueryWithBinds(
            'SELECT COUNT() FROM Account WHERE Name = :name',
            new Map<String, Object>{'name' => 'Test Account 1'},
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            accountSize,
            'The number of selected accounts should be 1'
        );
    }

    @IsTest
    static void testAggregateQueryWithMockDatabase() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = 1000;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQuery('SELECT SUM(AnnualRevenue) FROM Account');
        Test.stopTest();
        Decimal totalRevenue = (Decimal) arList[0].get('expr0');
        Assert.areEqual(
            10000,
            totalRevenue,
            'The total revenue should be 10000'
        );
    }

    @IsTest
    static void testAggregateQueryWithBindsWithMockDatabase() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = 1000;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQueryWithBinds(
            'SELECT SUM(AnnualRevenue) FROM Account WHERE Name = :name',
            new Map<String, Object>{'name' => 'Test Account 1'},
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        Decimal totalRevenue = (Decimal) arList[0].get('expr0');
        Assert.areEqual(
            1000,
            totalRevenue,
            'The total revenue should be 1000'
        );
    }

    @IsTest
    static void testWasCalled() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerQuery('SELECT Id, Name FROM Account', accounts);
        Test.startTest();
        Selector.query('SELECT Id, Name FROM Account');
        Test.stopTest();
        Assert.isTrue(
            Selector.calledAnyQuery(),
            'The query method should have been called'
        );
    }

    @IsTest
    static void testWasCalledWithQuery() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerQuery('SELECT Id, Name FROM Account', accounts);
        Test.startTest();
        Selector.query('SELECT Id, Name FROM Account');
        Test.stopTest();
        Assert.isTrue(
            Selector.calledQuery('SELECT Id, Name FROM Account'),
            'The query method should have been called with the query'
        );
    }

    @IsTest
    static void testResetCallState() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerQuery('SELECT Id, Name FROM Account', accounts);
        Test.startTest();
        Selector.query('SELECT Id, Name FROM Account');
        Test.stopTest();
        Assert.isTrue(
            Selector.calledAnyQuery(),
            'The query method should have been called'
        );
        Selector.resetCallState();
        Assert.isFalse(
            Selector.calledAnyQuery(),
            'The query method should not have been called'
        );
    }

    @IsTest
    static void testRegisterFailedQuery() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerFailedQuery('SELECT Id, Name FROM Account');
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            Selector.query('SELECT Id, Name FROM Account');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'Expected exception to be thrown'
        );
    }

    @IsTest
    static void testRegisterAggregateQuery() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = 1000;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerAggregateQuery('SELECT SUM(AnnualRevenue) FROM Account', new List<Aggregate> {
            new Aggregate(
                new Map<String, Object> {
                    'expr0' => 10000
                }
            )
        });
        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQuery('SELECT SUM(AnnualRevenue) FROM Account');
        Test.stopTest();
        Decimal totalRevenue = (Decimal) arList[0].get('expr0');
        Assert.areEqual(
            10000,
            totalRevenue,
            'The total revenue should be 10000'
        );
    }

    @IsTest
    static void testRegisterFailedAggregateQuery() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = 1000;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerFailedAggregateQuery('SELECT SUM(AnnualRevenue) FROM Account');
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            Selector.aggregateQuery('SELECT SUM(AnnualRevenue) FROM Account');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'Expected exception to be thrown'
        );
    }

    @IsTest
    static void testRegisterCountQuery() {


        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }

        DML.doInsert(accounts, true);
        Selector.registerCountQuery('SELECT COUNT() FROM Account', 10);
        Test.startTest();
        Integer accountSize = Selector.countQuery('SELECT COUNT() FROM Account');
        Test.stopTest();
        Assert.areEqual(
            10,
            accountSize,
            'The number of selected accounts should be 10'
        );
    }

    @IsTest
    static void testRegisterFailedCountQuery() {


        Selector.registerFailedCountQuery('SELECT COUNT() FROM Account');
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            Selector.countQuery('SELECT COUNT() FROM Account');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'Expected exception to be thrown'
        );
    }

    @IsTest
    static void testQueryWithAccessLevel() {

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }
        DML.doInsert(accounts, true);
        Selector.registerQuery('SELECT Id, Name FROM Account', accounts);
        Test.startTest();
        Selector.query('SELECT Id, Name FROM Account', AccessLevel.USER_MODE);
        Test.stopTest();
        Assert.isTrue(
            Selector.calledAnyQuery(),
            'The query method should have been called'
        );
    }

    @IsTest
    static void testQueryAggregateWithAccessLevel() {

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = 1000;
            accounts.add(a);
        }
        DML.doInsert(accounts, true);
        Selector.registerAggregateQuery('SELECT SUM(AnnualRevenue) FROM Account', new List<Aggregate> {
            new Aggregate(
                new Map<String, Object> {
                    'expr0' => 10000
                }
            )
        });
        Test.startTest();
        Selector.aggregateQuery('SELECT SUM(AnnualRevenue) FROM Account', AccessLevel.USER_MODE);
        Test.stopTest();
        Assert.isTrue(
            Selector.calledAnyQuery(),
            'The query method should have been called'
        );
    }

    @IsTest
    static void testCountQueryWithAccessLevel() {

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }
        DML.doInsert(accounts, true);
        Selector.registerCountQuery('SELECT COUNT() FROM Account', 10);
        Test.startTest();
        Selector.countQuery('SELECT COUNT() FROM Account', AccessLevel.USER_MODE);
        Test.stopTest();
        Assert.isTrue(
            Selector.calledAnyQuery(),
            'The query method should have been called'
        );
    }

    @IsTest
    static void testAggregateQueryWithBindsFail() {

        Boolean isExceptionThrown = false;
        Selector.registerFailedAggregateQuery('SELECT SUM(AnnualRevenue) FROM Account WHERE Name = :name');
        Test.startTest();
        try {
            Selector.aggregateQueryWithBinds(
                'SELECT SUM(AnnualRevenue) FROM Account WHERE Name = :name',
                new Map<String, Object>{'name' => 'Test Account 1'},
                AccessLevel.USER_MODE
            );
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'Expected exception to be thrown'
        );
    }

    @IsTest
    static void testAggregateQueryWithBindsWithRegisteredQuery() {

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = 1000;
            accounts.add(a);
        }
        DML.doInsert(accounts, true);
        Selector.registerAggregateQuery('SELECT SUM(AnnualRevenue) FROM Account WHERE Name = :name', new List<Aggregate> {
            new Aggregate(
                new Map<String, Object> {
                    'expr0' => 1000
                }
            )
        });
        Test.startTest();
        List<Aggregate> arList = Selector.aggregateQueryWithBinds(
            'SELECT SUM(AnnualRevenue) FROM Account WHERE Name = :name',
            new Map<String, Object>{'name' => 'Test Account 1'},
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        Decimal totalRevenue = (Decimal) arList[0].get('expr0');
        Assert.areEqual(
            1000,
            totalRevenue,
            'The total revenue should be 1000'
        );
    }

    @IsTest
    static void testQueryWithBindsWithRegisteredQuery() {

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            accounts.add(a);
        }
        DML.doInsert(accounts, true);
        Selector.registerQuery('SELECT Id, Name FROM Account WHERE Name = :name',
            new List<Account> {
                accounts[1]
            }
        );
        Test.startTest();
        List<Account> selectedAccounts = Selector.queryWithBinds(
            'SELECT Id, Name FROM Account WHERE Name = :name', 
            new Map<String, Object>{'name' => 'Test Account 1'},
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            selectedAccounts.size(),
            'The number of selected accounts should be 1'
        );
    }

    @IsTest
    static void testQueryWithBindsWithRegisterFailedQuery() {

        Selector.registerFailedQuery('SELECT Id, Name FROM Account WHERE Name = :name');
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            Selector.queryWithBinds(
                'SELECT Id, Name FROM Account WHERE Name = :name', 
                new Map<String, Object>{'name' => 'Test Account 1'},
                AccessLevel.USER_MODE
            );
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'Expected exception to be thrown'
        );
    }

    @IsTest
    static void testCountQueryWithBindsWithRegisteredQuery() {

        Selector.registerCountQuery('SELECT COUNT() FROM Account WHERE Name = :name', 1);
        Test.startTest();
        Integer accountSize = Selector.countQueryWithBinds(
            'SELECT COUNT() FROM Account WHERE Name = :name',
            new Map<String, Object>{'name' => 'Test Account 1'},
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            accountSize,
            'The number of selected accounts should be 1'
        );
    }

    @IsTest
    static void testCountQueryWithBindsWithRegisterFailedQuery() {

        Selector.registerFailedCountQuery('SELECT COUNT() FROM Account WHERE Name = :name');
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            Selector.countQueryWithBinds(
                'SELECT COUNT() FROM Account WHERE Name = :name',
                new Map<String, Object>{'name' => 'Test Account 1'},
                AccessLevel.USER_MODE
            );
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(
            isExceptionThrown,
            'Expected exception to be thrown'
        );
    }
}