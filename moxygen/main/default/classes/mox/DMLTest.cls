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
private class DMLTest {
    @IsTest
    static void testDoInsert1() {
        Account account = new Account(Name = 'Test Account');

        Test.startTest();
        DML.doInsert(account, true);
        Test.stopTest();

        Assert.areNotEqual(null, account.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoInsert2() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        Test.startTest();
        DML.doInsert(acctList, false);
        Test.stopTest();

        Assert.areNotEqual(null, account1.Id, 'Account Id should not be null');

        Assert.areNotEqual(null, account2.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoInsert3() {
        Account account = new Account(Name = 'Test Account');

        Test.startTest();
        DML.doInsert(account, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Assert.areNotEqual(null, account.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoInsert4() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        Test.startTest();
        DML.doInsert(acctList, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Assert.areNotEqual(null, account1.Id, 'Account Id should not be null');

        Assert.areNotEqual(null, account2.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoDelete1() {
        Account account = new Account(Name = 'Test Account');

        DML.doInsert(account, true);
        Test.startTest();
        DML.doDelete(account, true);
        Test.stopTest();

        Assert.isTrue(
            MockDatabase.isDeleted(account.Id),
            'Record should have been deleted'
        );
    }

    @IsTest
    static void testDoDelete2() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        DML.doInsert(acctList, false);
        Test.startTest();
        DML.doDelete(acctList, false);
        Test.stopTest();

        Assert.isTrue(
            MockDatabase.isDeleted(account1.Id) &&
            MockDatabase.isDeleted(account2.Id),
            'Records should have been deleted'
        );
    }

    @IsTest
    static void testDoDelete3() {
        Account account = new Account(Name = 'Test Account');

        DML.doInsert(account, false);
        Test.startTest();
        DML.doDelete(account.Id, false);
        Test.stopTest();

        Assert.isTrue(
            MockDatabase.isDeleted(account.Id),
            'Record should have been deleted'
        );
    }

    @IsTest
    static void testDoDelete4() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        DML.doInsert(acctList, false);
        List<Id> acctIds = new List<Id>{ account1.Id, account2.Id };
        Test.startTest();
        DML.doDelete(acctIds, false);
        Test.stopTest();
        Boolean isAllDeleted = (MockDatabase.isDeleted(account1.Id) &&
        MockDatabase.isDeleted(account2.Id));
        Assert.isTrue(isAllDeleted, 'Records should have been deleted');
    }

    @IsTest
    static void testIsDeleted() {
        Account account = new Account(Name = 'Test Account');
        DML.doInsert(account, true);
        Test.startTest();
        DML.doDelete(account, true);
        Test.stopTest();

        Boolean isDeleted = MockDatabase.isDeleted(account.Id);
        Assert.isTrue(isDeleted, 'Account should have been deleted');
    }

    @IsTest
    static void testSelectRecordById() {
        Account account = new Account(Name = 'Test Account');
        DML.doInsert(account, true);
        Test.startTest();
        Account selectedAccount = (Account) MockDatabase.selectRecordById(
            account.Id
        );
        Test.stopTest();

        Assert.areEqual(
            account.Id,
            selectedAccount.Id,
            'Account Id should be the same'
        );
    }

    @IsTest
    static void testDoMockInsert1() {
        Account account = new Account(Name = 'Test Account');
        Test.startTest();
        DML.doMockInsert(account);
        Test.stopTest();

        Assert.areNotEqual(null, account.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoMockInsert2() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        Test.startTest();
        DML.doMockInsert(acctList);
        Test.stopTest();

        Assert.areNotEqual(null, account1.Id, 'Account Id should not be null');

        Assert.areNotEqual(null, account2.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoUpdate1() {
        Account account = new Account(Name = 'Test Account');
        DML.doInsert(account, true);

        account.Name = 'Updated Account';
        Test.startTest();
        DML.doUpdate(account, true);
        Test.stopTest();

        Account updatedAccount = (Account) MockDatabase.selectRecordById(
            account.Id
        );
        Assert.areEqual(
            'Updated Account',
            updatedAccount.Name,
            'Account Name should be Updated Account'
        );
    }

    @IsTest
    static void testDoUpdate2() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        DML.doInsert(acctList, false);

        account1.Name = 'Updated Account';
        account2.Name = 'Updated Account';

        Test.startTest();
        DML.doUpdate(acctList, false);
        Test.stopTest();

        Account updatedAccount1 = (Account) MockDatabase.selectRecordById(
            account1.Id
        );
        Account updatedAccount2 = (Account) MockDatabase.selectRecordById(
            account2.Id
        );

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
        Account account = new Account(Name = 'Test Account');
        DML.doInsert(account, true);

        account.Name = 'Updated Account';
        Test.startTest();
        DML.doUpdate(account, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Account updatedAccount = (Account) MockDatabase.selectRecordById(
            account.Id
        );
        Assert.areEqual(
            'Updated Account',
            updatedAccount.Name,
            'Account Name should be Updated Account'
        );
    }

    @IsTest
    static void testDoUpdate4() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        DML.doInsert(acctList, false);

        account1.Name = 'Updated Account';
        account2.Name = 'Updated Account';

        Test.startTest();
        DML.doUpdate(acctList, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Account updatedAccount1 = (Account) MockDatabase.selectRecordById(
            account1.Id
        );
        Account updatedAccount2 = (Account) MockDatabase.selectRecordById(
            account2.Id
        );

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
        Account account = new Account(Name = 'Test Account');
        Test.startTest();
        DML.doUpsert(account, null, true);
        Test.stopTest();

        Assert.areNotEqual(null, account.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoUpsert2() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        Test.startTest();
        DML.doUpsert(acctList, null, false);
        Test.stopTest();

        Assert.areNotEqual(null, account1.Id, 'Account Id should not be null');

        Assert.areNotEqual(null, account2.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoUpsert3() {
        Account account = new Account(Name = 'Test Account');
        Test.startTest();
        DML.doUpsert(account, null, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Assert.areNotEqual(null, account.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoUpsert4() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        Test.startTest();
        DML.doUpsert(acctList, null, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Assert.areNotEqual(null, account1.Id, 'Account Id should not be null');

        Assert.areNotEqual(null, account2.Id, 'Account Id should not be null');
    }

    @IsTest
    static void testDoUndelete1() {
        Account account = new Account(Name = 'Test Account');
        DML.doInsert(account, true);
        DML.doDelete(account, true);
        Test.startTest();
        DML.doUndelete(account, true);
        Test.stopTest();

        Assert.isFalse(
            MockDatabase.isDeleted(account.Id),
            'Record should not be deleted'
        );
    }

    @IsTest
    static void testDoUndelete2() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        DML.doInsert(acctList, false);
        DML.doDelete(acctList, false);
        Test.startTest();
        DML.doUndelete(acctList, false);
        Test.stopTest();

        Assert.isFalse(
            MockDatabase.isDeleted(account1.Id) ||
            MockDatabase.isDeleted(account2.Id),
            'Records should not be deleted'
        );
    }

    @IsTest
    static void testDoUndelete3() {
        Account account = new Account(Name = 'Test Account');
        DML.doInsert(account, true);
        DML.doDelete(account, true);
        Test.startTest();
        DML.doUndelete(account.Id, true);
        Test.stopTest();

        Assert.isFalse(
            MockDatabase.isDeleted(account.Id),
            'Record should not be deleted'
        );
    }

    @IsTest
    static void testDoUndelete4() {
        Account account1 = new Account(Name = 'Test Account');

        Account account2 = new Account(Name = 'Test Account');

        List<Account> acctList = new List<Account>{ account1, account2 };

        DML.doInsert(acctList, false);
        DML.doDelete(acctList, false);
        List<Id> acctIds = new List<Id>{ account1.Id, account2.Id };
        Test.startTest();
        DML.doUndelete(acctIds, false);
        Test.stopTest();

        Boolean isEitherDeleted = (MockDatabase.isDeleted(account1.Id) ||
        MockDatabase.isDeleted(account2.Id));
        Assert.isFalse(isEitherDeleted, 'Records should not be deleted');
    }

    @IsTest
    static void testDoUndelete5() {
        Account account = new Account(Name = 'Test Account');

        DML.doInsert(account, false);
        DML.doDelete(account, false);
        Test.startTest();
        DML.doUndelete(account, false, AccessLevel.USER_MODE);
        Test.stopTest();

        Assert.isFalse(
            MockDatabase.isDeleted(account.Id),
            'Record should not be deleted'
        );
    }
}
