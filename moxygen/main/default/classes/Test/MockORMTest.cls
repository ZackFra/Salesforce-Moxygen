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
private class MockORMTest {

    @IsTest
    static void testConstructor() {
        Test.startTest();
        MockORM mockORM = new MockORM();
        Test.stopTest();

        Assert.isNotNull(mockORM, 'MockORM instance should not be null');
    }

    @IsTest
    static void testGetSelector() {
        MockORM mockORM = new MockORM();
        Test.startTest();
        ISelector selector = mockORM.getSelector();
        Test.stopTest();

        Assert.isInstanceOfType(
            selector,
            MockSelector.class,  
            'Selector should be of type MockSelector'
        );
    }

    @IsTest
    static void testGetDML() {
        MockORM mockORM = new MockORM();
        Test.startTest();
        IDML dml = mockORM.getDML();
        Test.stopTest();

        Assert.isInstanceOfType(
            dml,
            MockDML.class,  
            'DML should be of type MockDML'
        );
    }

    @IsTest
    static void testGetMockDML() {
        MockORM mockORM = new MockORM();
        Test.startTest();
        MockDML mockDML = mockORM.getMockDML();
        Test.stopTest();

        Assert.isInstanceOfType(
            mockDML,
            MockDML.class,  
            'MockDML should be of type MockDML'
        );
    }

    @IsTest
    static void testGetMockSelector() {
        MockORM mockORM = new MockORM();
        Test.startTest();
        MockSelector mockSelector = mockORM.getMockSelector();
        Test.stopTest();

        Assert.isInstanceOfType(
            mockSelector,
            MockSelector.class,  
            'MockSelector should be of type MockSelector'
        );
    }

    @IsTest
    static void testReset() {
        MockORM mockORM = new MockORM();
        Test.startTest();
        mockORM.reset();
        Test.stopTest();

        Assert.isNotNull(mockORM, 'MockORM instance should not be null');
    }

    @IsTest
    static void testIsDeleted() {
        MockORM mockORM = new MockORM();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(
            acct,
            true
        );

        Test.startTest();
        Boolean isDeleted = mockORM.isDeleted(acct.Id);
        Test.stopTest();

        Assert.isFalse(isDeleted, 'isDeleted should be false');
    }

    @IsTest
    static void testSelectRecordById() {
        MockORM mockORM = new MockORM();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        Account result = (Account) mockORM.selectRecordById(acct.Id);
        Test.stopTest();

        Assert.isNotNull(result, 'Result should not be null');
        Assert.areEqual(
            acct.Id,
            result.Id,
            'Result Id should match Account Id'
        );
    }

    @IsTest
    static void testSelectDeletedRecordById() {
        MockORM mockORM = new MockORM();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);
        dml.doDelete(acct, true);

        Test.startTest();
        Account result = (Account) mockORM.selectDeletedRecordById(acct.Id);
        Test.stopTest();

        Assert.isNotNull(result, 'Result should not be null');
    }

    @IsTest
    static void testSize() {
        MockORM mockORM = new MockORM();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        Integer result = mockORM.size();
        Test.stopTest();

        Assert.areEqual(
            1,
            result,
            'Result should be 1'
        );
    }

    @IsTest
    static void testRegisterQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        mockORM.registerQuery('SELECT Id FROM Account', new List<Account>{acct});
        List<Account> queriedAccounts = (List<Account>) selector.query('SELECT Id FROM Account');
        Test.stopTest();

        // we set the result list to be an account,
        // Name wasn't queried, but since we hard-coded the results, it should still be there
        Assert.isTrue(
            queriedAccounts[0].Name != null,
            'Account Name should not be null'
        );
    }

    @IsTest
    static void testRegisterFailedQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        mockORM.registerFailedQuery('SELECT Id FROM Account');
        Boolean isExceptionThrown = false;
        try {
            selector.query('SELECT Id FROM Account');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(
            isExceptionThrown,
            'Exception should be thrown'
        );
    }

    @IsTest
    static void testRegisterAggregateQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        mockORM.registerAggregateQuery(
            'SELECT COUNT(Id) FROM Account',
            new List<Aggregate> {
                new Aggregate(
                    new Map<String, Object> {
                        'expr0' => 0
                    }
                )
            }
        );
        List<Aggregate> aggr = selector.queryAggregate('SELECT COUNT(Id) FROM Account');
        Test.stopTest();

        Assert.areEqual(
            0,
            (Integer) aggr[0].get('expr0'),
            'Aggregate should be 1'
        );
    }

    @IsTest
    static void testRegisterFailedAggregateQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        mockORM.registerFailedAggregateQuery(
            'SELECT COUNT(Id) FROM Account'
        );
        Boolean isExceptionThrown = false;
        try {
            selector.queryAggregate('SELECT COUNT(Id) FROM Account');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(
            isExceptionThrown,
            'Exception should be thrown'
        );
    }

    @IsTest
    static void testRegisterCountQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct1 = new Account(
            Name = 'Test Account'
        );
        Account acct2 = new Account(
            Name = 'Test Account 2'
        );
        List<Account> acctList = new List<Account>{
            acct1,
            acct2
        };
        dml.doInsert(acctList, true);

        Test.startTest();
        // intentionally register the wrong value, to check that its returning what's registered
        mockORM.registerCountQuery('SELECT COUNT() FROM Account', 1);
        Integer count = selector.countQuery('SELECT COUNT() FROM Account');
        Test.stopTest();

        Assert.areEqual(
            1,
            count,
            'Count should be 1'
        );
    }

    @IsTest
    static void testRegisterFailedCountQuery() {
        MockORM mockORM = new MockORM();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            mockORM.registerFailedCountQuery('SELECT COUNT() FROM Contact');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Exception should not be thrown');
    }

    @IsTest
    static void testDeletedSize() {
        MockORM mockORM = new MockORM();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);
        dml.doDelete(acct, true);

        Test.startTest();
        Integer result = mockORM.deletedSize();
        Test.stopTest();

        Assert.areEqual(
            1,
            result,
            'Result should be 1'
        );
    }

    @IsTest
    static void testDidDML() {
        MockORM mockORM = new MockORM();

        Test.startTest();
        Boolean result = mockORM.didDML(Types.DML.INSERTED);
        Test.stopTest();

        Assert.isFalse(result, 'Result should be false');
    }

    @IsTest
    static void testDidAnyDML() {
        MockORM mockORM = new MockORM();

        Test.startTest();
        Boolean result = mockORM.didAnyDML();
        Test.stopTest();

        Assert.isFalse(result, 'Result should be false');
    }

    @IsTest
    static void testCalledQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);
        selector.query('SELECT Id FROM Account LIMIT 1');

        Test.startTest();
        Boolean result = mockORM.calledQuery('SELECT Id FROM Account LIMIT 1');
        Test.stopTest();

        Assert.isTrue(result, 'Result should be true');
    }

    @IsTest
    static void testCalledAnyQuery() {
        MockORM mockORM = new MockORM();
        MockSelector selector = mockORM.getMockSelector();
        MockDML dml = mockORM.getMockDML();
        Account acct = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(acct, true);

        Test.startTest();
        selector.query('SELECT Id FROM Account LIMIT 1');
        Boolean result = mockORM.calledAnyQuery();
        Test.stopTest();

        Assert.isTrue(result, 'Result should be true');
    }

}