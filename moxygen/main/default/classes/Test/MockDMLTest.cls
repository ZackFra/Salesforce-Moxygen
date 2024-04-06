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
private class MockDMLTest {
    @IsTest
    static void testConstructor() {
        Test.startTest();
        MockDML mockDML = new MockDML();
        Test.stopTest();
        Assert.areNotEqual(
            null, 
            mockDML,
            'MockDML should not be null'
        );
    }

    @IsTest
    static void testConstructorWithMockDatabase() {
        Test.startTest();
        MockDML mockDML = new MockDML(new MockDatabase());
        Test.stopTest();
        Assert.areNotEqual(
            null, 
            mockDML,
            'MockDML should not be null'
        );
    }

    @IsTest
    static void testDoInsert1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );

        Test.startTest();
        dml.doInsert(account, true);
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoInsert2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        Test.startTest();
        dml.doInsert(acctList, false);
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account1.Id,
            'Account Id should not be null'
        );

        Assert.areNotEqual(
            null, 
            account2.Id,
            'Account Id should not be null'
        );
    }
    
    @IsTest
    static void testDoInsert3() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );

        Test.startTest();
        dml.doInsert(
            account, 
            false,
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoInsert4() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        Test.startTest();
        dml.doInsert(
            acctList, 
            false,
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account1.Id,
            'Account Id should not be null'
        );

        Assert.areNotEqual(
            null, 
            account2.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testCount() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        Test.startTest();
        dml.doInsert(acctList, false);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            2, 
            count,
            'Count should be 2'
        );
    }

    @IsTest
    static void testDoDelete1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );

        dml.doInsert(account, true);
        Test.startTest();
        dml.doDelete(account, true);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            0, 
            count,
            'Count should be 0'
        );
    }

    @IsTest
    static void testDoDelete2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);
        Test.startTest();
        dml.doDelete(acctList, false);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            0, 
            count,
            'Count should be 0'
        );
    }

    @IsTest
    static void testDoDelete3() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );

        dml.doInsert(account, false);
        Test.startTest();
        dml.doDelete(account.Id, false);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            0, 
            count,
            'Count should be 0'
        );
    }

    @IsTest
    static void testDoDelete4() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);
        List<Id> acctIds = new List<Id> {
            account1.Id,
            account2.Id
        };
        Test.startTest();
        dml.doDelete(acctIds, false);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            0, 
            count,
            'Count should be 0'
        );
    }

    @IsTest
    static void testDeletedCount() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);
        Test.startTest();
        dml.doDelete(acctList, false);
        Test.stopTest();

        Integer count = dml.deletedCount();
        Assert.areEqual(
            2, 
            count,
            'Count should be 2'
        );
    }

    @IsTest
    static void testWasCalled1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        Test.startTest();
        dml.doInsert(account, true);
        Test.stopTest();

        Boolean wasCalled = dml.wasCalled();
        Assert.isTrue(
            wasCalled,
            'DML should have been called'
        );
    }

    @IsTest
    static void testWasCalled2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Boolean wasCalled = dml.wasCalled();
        Assert.isFalse(
            wasCalled,
            'DML should not have been called'
        );
    }

    @IsTest
    static void testWasCalled3() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        Test.startTest();
        dml.doInsert(account, true);
        Test.stopTest();

        Boolean wasCalled = dml.wasCalled(Types.DML.INSERTED);
        Assert.isTrue(
            wasCalled,
            'DML should have been called'
        );
    }

    @IsTest
    static void testWasCalled4() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            dml.wasCalled(null);
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        
        Assert.isTrue(
            isExceptionThrown,
            'Exception should have been thrown'
        );
    }

    @IsTest
    static void testIsDeleted() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        Test.startTest();
        dml.doDelete(account, true);
        Test.stopTest();

        Boolean isDeleted = dml.isDeleted(account.Id);
        Assert.isTrue(
            isDeleted,
            'Account should have been deleted'
        );
    }

    @IsTest
    static void testSelectDeletedRecordById1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        dml.doDelete(account, true);
        Test.startTest();
        Account deletedAccount = (Account) dml.selectDeletedRecordById(account.Id);        
        Test.stopTest();

        Assert.areEqual(
            account.Id, 
            deletedAccount.Id,
            'Account Id should be the same'
        );
    }

    @IsTest
    static void testSelectDeletedRecordById2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        Test.startTest();
        Account deletedAccount = (Account) dml.selectDeletedRecordById(account.Id);
        Test.stopTest();

        
        Assert.isNull(
            deletedAccount,
            'Account should be null'
        );
    }

    @IsTest
    static void testSelectRecordById() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        Test.startTest();
        Account selectedAccount = (Account) dml.selectRecordById(account.Id);
        Test.stopTest();

        Assert.areEqual(
            account.Id, 
            selectedAccount.Id,
            'Account Id should be the same'
        );
    }

    @IsTest
    static void testSelectRecordById2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        dml.doDelete(account, true);
        Test.startTest();
        Account selectedAccount = (Account) dml.selectRecordById(
            account.Id
        );
        Test.stopTest();

        Assert.isNull(
            selectedAccount,
            'Account should be null'
        );
    }

    @IsTest
    static void testDoMockInsert1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        Test.startTest();
        dml.doMockInsert(account);
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoMockInsert2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        Test.startTest();
        dml.doMockInsert(acctList);
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account1.Id,
            'Account Id should not be null'
        );

        Assert.areNotEqual(
            null, 
            account2.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoUpdate1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);

        account.Name = 'Updated Account';
        Test.startTest();
        dml.doUpdate(account, true);
        Test.stopTest();

        Account updatedAccount = (Account) dml.selectRecordById(account.Id);
        Assert.areEqual(
            'Updated Account', 
            updatedAccount.Name,
            'Account Name should be Updated Account'
        );
    }

    @IsTest
    static void testDoUpdate2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);

        account1.Name = 'Updated Account';
        account2.Name = 'Updated Account';

        Test.startTest();
        dml.doUpdate(acctList, false);
        Test.stopTest();

        Account updatedAccount1 = (Account) dml.selectRecordById(account1.Id);
        Account updatedAccount2 = (Account) dml.selectRecordById(account2.Id);

        Assert.areEqual(
            'Updated Account', 
            updatedAccount1.Name,
            'Account Name should be Updated Account'
        );

        Assert.areEqual(
            'Updated Account', 
            updatedAccount2.Name,
            'Account Name should be Updated Account'
        );
    }

    @IsTest
    static void testDoUpdate3() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);

        account.Name = 'Updated Account';
        Test.startTest();
        dml.doUpdate(account, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Account updatedAccount = (Account) dml.selectRecordById(account.Id);
        Assert.areEqual(
            'Updated Account', 
            updatedAccount.Name,
            'Account Name should be Updated Account'
        );
    }

    @IsTest
    static void testDoUpdate4() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);

        account1.Name = 'Updated Account';
        account2.Name = 'Updated Account';

        Test.startTest();
        dml.doUpdate(acctList, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Account updatedAccount1 = (Account) dml.selectRecordById(account1.Id);
        Account updatedAccount2 = (Account) dml.selectRecordById(account2.Id);

        Assert.areEqual(
            'Updated Account', 
            updatedAccount1.Name,
            'Account Name should be Updated Account'
        );

        Assert.areEqual(
            'Updated Account', 
            updatedAccount2.Name,
            'Account Name should be Updated Account'
        );
    }

    @IsTest
    static void testDoUpsert1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        Test.startTest();
        dml.doUpsert(
            account, 
            null, 
            true
        );
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoUpsert2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        Test.startTest();
        dml.doUpsert(
            acctList, 
            null, 
            false
        );
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account1.Id,
            'Account Id should not be null'
        );

        Assert.areNotEqual(
            null, 
            account2.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoUpsert3() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        Test.startTest();
        dml.doUpsert(
            account, 
            null,
            false,
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoUpsert4() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        Test.startTest();
        dml.doUpsert(
            acctList,
            null,
            false, 
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        Assert.areNotEqual(
            null, 
            account1.Id,
            'Account Id should not be null'
        );

        Assert.areNotEqual(
            null, 
            account2.Id,
            'Account Id should not be null'
        );
    }

    @IsTest
    static void testDoUndelete1() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        dml.doDelete(account, true);
        Test.startTest();
        dml.doUndelete(account, true);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            1, 
            count,
            'Count should be 1'
        );
    }

    @IsTest
    static void testDoUndelete2() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);
        dml.doDelete(acctList, false);
        Test.startTest();
        dml.doUndelete(acctList, false);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            2, 
            count,
            'Count should be 2'
        );
    }

    @IsTest
    static void testDoUndelete3() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );
        dml.doInsert(account, true);
        dml.doDelete(account, true);
        Test.startTest();
        dml.doUndelete(account.Id, true);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            1, 
            count,
            'Count should be 1'
        );
    }

    @IsTest
    static void testDoUndelete4() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account1 = new Account(
            Name = 'Test Account'
        );

        Account account2 = new Account(
            Name = 'Test Account'
        );

        List<Account> acctList = new List<Account> {
            account1,
            account2
        };

        dml.doInsert(acctList, false);
        dml.doDelete(acctList, false);
        List<Id> acctIds = new List<Id> {
            account1.Id,
            account2.Id
        };
        Test.startTest();
        dml.doUndelete(acctIds, false);
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            2, 
            count,
            'Count should be 2'
        );
    }

    @IsTest
    static void testDoUndelete5() {
        MockORM db = new MockORM();
        MockDML dml = new MockDML();

        Account account = new Account(
            Name = 'Test Account'
        );

        dml.doInsert(account, false);
        dml.doDelete(account, false);
        Test.startTest();
        dml.doUndelete(
            account, 
            false,
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        Integer count = dml.count();
        Assert.areEqual(
            1, 
            count,
            'Count should be 1'
        );
    }
}