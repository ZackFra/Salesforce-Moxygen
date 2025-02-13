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
@SuppressWarnings(
    'PMD.CognitiveComplexity, PMD.CyclomaticComplexity, PMD.NcssTypeCount, PMD.ApexUnitTestClassShouldHaveAsserts'
)
private class MockDatabaseTest {
    // REFACTOR THESE OUT LATER
    final static Integer YEAR = 2024;
    final static Integer DAY = 1;

    static final Map<Integer, Integer> RECORDS_BY_QUARTER = new Map<Integer, Integer>{
        1 => 5,
        2 => 3,
        3 => 7,
        4 => 2
    };

    @IsTest
    static void testDelete() {
        Account a = new Account(Name = 'Test 1');
        Account b = new Account(Name = 'Test 2');
        Account c = new Account(Name = 'Test 3');
        Account d = new Account(Name = 'Test 4');
        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        MockDatabase.doDelete(acctList, true);
        Test.stopTest();

        List<sObject> queriedAccts = MockDatabase.query(
            'SELECT Id FROM Account'
        );
        Assert.areEqual(
            0,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testUpdateList() {
        Account a = new Account(Name = 'Test 1');
        Account b = new Account(Name = 'Test 2');
        Account c = new Account(Name = 'Test 3');
        Account d = new Account(Name = 'Test 4');
        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        for (Account acct : acctList) {
            acct.Name = 'Updated';
        }
        Test.startTest();
        MockDatabase.doUpdate(acctList, true);
        Test.stopTest();

        List<sObject> queriedAccts = MockDatabase.query(
            'SELECT Id, Name FROM Account'
        );
        for (sObject acct : queriedAccts) {
            Assert.areEqual(
                'Updated',
                acct.get('Name'),
                'Account was not updated'
            );
        }
    }

    @IsTest
    static void testInsert() {
        Account a = new Account(Name = 'Test');

        Test.startTest();
        MockDatabase.doInsert(a, true);
        Test.stopTest();

        Assert.isNotNull(DataStore.getById(a.Id), 'Account was not inserted');
    }

    @IsTest
    static void testInsertList() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        Test.startTest();
        MockDatabase.doInsert(new List<SObject>{ a, b }, true);
        Test.stopTest();

        Account insertedAcctA = (Account) DataStore.getById(a.Id);
        Account insertedAcctB = (Account) DataStore.getById(b.Id);

        Assert.isNotNull(insertedAcctA, 'Account A was not inserted');
        Assert.isNotNull(insertedAcctB, 'Account B was not inserted');
    }

    @IsTest
    static void testUpdate() {
        Account a = new Account(Name = 'Test');

        MockDatabase.doInsert(a, true);

        Test.startTest();
        a.Name = 'Test2';
        MockDatabase.doUpdate(a, true);
        Test.stopTest();

        Account updatedAcct = (Account) DataStore.getById(a.Id);

        Assert.areEqual('Test2', updatedAcct.Name, 'Account was not updated');
    }

    /* SOQL Tests */

    @IsTest
    static void testQuerySingle() {
        Account a = new Account(Name = 'Test');

        MockDatabase.doInsert(a, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account'
        );
        Test.stopTest();
        Account queriedAcct = queriedAccts[0];
        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.isNotNull(queriedAcct, 'Account was not queried');
    }

    @IsTest
    static void testQueryMultiple() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account'
        );
        Test.stopTest();

        Assert.isNotNull(queriedAccts, 'Accounts were not queried');
        Assert.areEqual(
            2,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testInsertMultiple() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        Test.startTest();
        MockDatabase.doInsert(new List<SObject>{ a, b }, true);
        Test.stopTest();

        Account insertedAcctA = (Account) DataStore.getById(a.Id);
        Account insertedAcctB = (Account) DataStore.getById(b.Id);

        Assert.isNotNull(insertedAcctA, 'Account A was not inserted');
        Assert.isNotNull(insertedAcctB, 'Account B was not inserted');
    }

    @IsTest
    static void testParentSubQuery() {
        Account a = new Account(Name = 'Test');

        MockDatabase.doInsert(a, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );

        MockDatabase.doInsert(con, true);

        Test.startTest();
        List<Contact> queriedCons = (List<Contact>) MockDatabase.query(
            'SELECT Id, FirstName, LastName, Account.Name FROM Contact'
        );
        Test.stopTest();

        Contact queriedCon = queriedCons[0];
        Assert.areEqual(
            1,
            queriedCons.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test',
            queriedCon.Account.Name,
            'Expected account name to be \'Test\''
        );
        Assert.areEqual(
            'Steve',
            queriedCon.FirstName,
            'Expected first name to be \'Steve\''
        );
        Assert.areEqual(
            'Banner',
            queriedCon.LastName,
            'Expected last name to be \'Banner\''
        );
        Assert.areEqual(
            con.Id,
            queriedCon.Id,
            'Expected queried contact to be the same as inserted contact'
        );
    }

    @IsTest
    static void testChildSubQuery() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = acct.Id
        );

        MockDatabase.doInsert(con, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account'
        );
        Test.stopTest();

        Account queriedAcct = queriedAccts[0];
        Contact queriedCon = queriedAcct.Contacts[0];

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            1,
            queriedAcct.Contacts.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test',
            queriedAcct.Name,
            'Expected account name to be \'Test\''
        );
        Assert.areEqual(
            'Steve',
            queriedCon.FirstName,
            'Expected first name to be \'Steve\''
        );
        Assert.areEqual(
            'Banner',
            queriedCon.LastName,
            'Expected last name to be \'Banner\''
        );
        Assert.areEqual(
            con.Id,
            queriedCon.Id,
            'Expected queried contact to be the same as inserted contact'
        );
    }

    @IsTest
    static void testChildSubQueryMultiple() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            conList.add(con);
        }
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account'
        );
        Test.stopTest();

        Account queriedAcct = queriedAccts[0];

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            5,
            queriedAcct.Contacts.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test',
            queriedAcct.Name,
            'Expected account name to be \'Test\''
        );

        Map<String, Boolean> queriedConNames = new Map<String, Boolean>();
        for (Integer i = 0; i < 5; i++) {
            queriedConNames.put(
                queriedAcct.Contacts[i].FirstName +
                queriedAcct.Contacts[i].LastName,
                true
            );
        }
        for (Integer i = 0; i < 5; i++) {
            Assert.areEqual(
                'Steve',
                queriedAcct.Contacts[i].FirstName,
                'Expected first name to be \'Steve\''
            );
            queriedConNames.put(
                queriedAcct.Contacts[i].FirstName +
                queriedAcct.Contacts[i].LastName,
                true
            );
        }

        for (Boolean foundName : queriedConNames.values()) {
            Assert.isTrue(
                foundName,
                'Expected queried contact to be the same as inserted contact'
            );
        }
    }

    @IsTest
    static void testMutipleChildSubQueries() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<sObject> childRecords = new List<sObject>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            childRecords.add(con);
        }

        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity(
                Name = 'Test' + i,
                AccountId = acct.Id,
                CloseDate = GMT.today(),
                StageName = 'Prospecting'
            );
            childRecords.add(opp);
        }
        MockDatabase.doInsert(childRecords, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts), (SELECT Id, Name FROM Opportunities) FROM Account'
        );
        Test.stopTest();

        Account queriedAcct = queriedAccts[0];

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            5,
            queriedAcct.Contacts.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            5,
            queriedAcct.Opportunities.size(),
            'Incorrect number of opportunities queried'
        );
        Assert.areEqual(
            'Test',
            queriedAcct.Name,
            'Expected account name to be \'Test\''
        );

        Map<String, Boolean> queriedConNames = new Map<String, Boolean>();
        for (Integer i = 0; i < 5; i++) {
            queriedConNames.put(
                queriedAcct.Contacts[i].FirstName +
                queriedAcct.Contacts[i].LastName,
                true
            );
        }
        for (Integer i = 0; i < 5; i++) {
            Assert.areEqual(
                'Steve',
                queriedAcct.Contacts[i].FirstName,
                'Expected first name to be \'Steve\''
            );
            queriedConNames.put(
                queriedAcct.Contacts[i].FirstName +
                queriedAcct.Contacts[i].LastName,
                true
            );
        }

        for (Boolean foundName : queriedConNames.values()) {
            Assert.isTrue(
                foundName,
                'Expected queried contact to be the same as inserted contact'
            );
        }

        Map<String, Boolean> queriedOppNames = new Map<String, Boolean>();
        for (Integer i = 0; i < 5; i++) {
            queriedOppNames.put(queriedAcct.Opportunities[i].Name, true);
        }
        for (Integer i = 0; i < 5; i++) {
            Assert.areEqual(
                'Test' + i,
                queriedAcct.Opportunities[i].Name,
                'Expected opportunity name to be \'Test' + i + '\''
            );
            queriedOppNames.put(queriedAcct.Opportunities[i].Name, true);
        }

        for (Boolean foundName : queriedOppNames.values()) {
            Assert.isTrue(
                foundName,
                'Expected queried opportunity to be the same as inserted opportunity'
            );
        }
    }

    @IsTest
    static void testDisallowDuplicateSubQueries() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<sObject> childRecords = new List<sObject>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            childRecords.add(con);
        }

        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity(
                Name = 'Test' + i,
                AccountId = acct.Id,
                CloseDate = GMT.today(),
                StageName = 'Prospecting'
            );
            childRecords.add(opp);
        }
        MockDatabase.doInsert(childRecords, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.query(
                'SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts), (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Opportunities WHERE Name = \'Test1\') FROM Account'
            );
        } catch (QueryException e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'Cannot follow the same aggregate relationship twice',
            exMessage,
            'Expected exception message to be \'Cannot follow the same aggregate relationship twice\''
        );
    }

    @IsTest
    static void testQueryWithWhereClause() {
        Account a = new Account(Name = 'Test');

        MockDatabase.doInsert(a, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test\''
        );
        Test.stopTest();

        Account queriedAcct = queriedAccts[0];
        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.isNotNull(queriedAcct, 'Account was not queried');
    }

    @IsTest
    static void testQueryWithWhereClauseMultiple() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test\''
        );
        Test.stopTest();

        Account queriedAcct = queriedAccts[0];
        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.isNotNull(queriedAcct, 'Account was not queried');
    }

    @IsTest
    static void testQueryWithWhereClauseNone() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test3\''
        );
        Test.stopTest();

        Assert.areEqual(
            0,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithWhereClauseMultipleFields() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test\' OR Name = \'Test2\''
        );
        Test.stopTest();
        Assert.areEqual(
            2,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithWhereClauseMultipleFieldsNone() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test3\' OR Name = \'Test4\''
        );
        Test.stopTest();

        Assert.areEqual(
            0,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithWhereClauseMultipleFieldsOne() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test\' OR Name = \'Test4\''
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithSubQueryInWhereClause() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = acct.Id
        );

        MockDatabase.doInsert(con, true);

        Test.startTest();
        List<Contact> queriedCons = (List<Contact>) MockDatabase.query(
            'SELECT Id, FirstName, LastName, Account.Name FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE Name = \'Test\')'
        );
        Test.stopTest();

        Contact queriedCon = queriedCons[0];
        Assert.areEqual(
            1,
            queriedCons.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test',
            queriedCon.Account.Name,
            'Expected account name to be \'Test\''
        );
        Assert.areEqual(
            'Steve',
            queriedCon.FirstName,
            'Expected first name to be \'Steve\''
        );
        Assert.areEqual(
            'Banner',
            queriedCon.LastName,
            'Expected last name to be \'Banner\''
        );
        Assert.areEqual(
            con.Id,
            queriedCon.Id,
            'Expected queried contact to be the same as inserted contact'
        );
    }

    @IsTest
    static void testDuplicateFieldsQueried() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);
        String exMessage;
        Test.startTest();
        try {
            MockDatabase.query('SELECT Id, Name, Name FROM Account');
        } catch (QueryException e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();
        Assert.areEqual(
            'Duplicate field selected',
            exMessage,
            'Expected exception message to be \'Duplicate field selected: Name\''
        );
    }

    @IsTest
    static void testQueryWithSubQueryInWhereClauseMultiple() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            conList.add(con);
        }
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Contact> queriedCons = (List<Contact>) MockDatabase.query(
            'SELECT Id, FirstName, LastName, Account.Name FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE Name = \'Test\')'
        );
        Test.stopTest();

        Contact queriedCon = queriedCons[0];

        Assert.areEqual(
            5,
            queriedCons.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test',
            queriedCon.Account.Name,
            'Expected account name to be \'Test\''
        );

        Map<String, Boolean> queriedConNames = new Map<String, Boolean>();
        for (Integer i = 0; i < 5; i++) {
            queriedConNames.put(
                queriedCons[i].FirstName + queriedCons[i].LastName,
                true
            );
        }
        for (Integer i = 0; i < 5; i++) {
            Assert.areEqual(
                'Steve',
                queriedCons[i].FirstName,
                'Expected first name to be \'Steve\''
            );
            queriedConNames.put(
                queriedCons[i].FirstName + queriedCons[i].LastName,
                true
            );
        }

        for (Boolean foundName : queriedConNames.values()) {
            Assert.isTrue(
                foundName,
                'Expected queried contact to be the same as inserted contact'
            );
        }
    }

    @IsTest
    static void testQueryWithSubQueryInWhereClauseMultipleNone() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            conList.add(con);
        }
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Contact> queriedCons = (List<Contact>) MockDatabase.query(
            'SELECT Id, FirstName, LastName, Account.Name FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE Name = \'Test2\')'
        );
        Test.stopTest();

        Assert.areEqual(
            0,
            queriedCons.size(),
            'Incorrect number of contacts queried'
        );
    }

    @IsTest
    static void testCount() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');

        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        Integer count = MockDatabase.countQuery('SELECT COUNT() FROM Account');
        Test.stopTest();

        Assert.areEqual(2, count, 'Incorrect number of accounts queried');
    }

    @IsTest
    static void testCountWithWhereClause() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        MockDatabase.doInsert(a, true);
        MockDatabase.doInsert(b, true);

        Test.startTest();
        Integer count = (Integer) MockDatabase.countQuery(
            'SELECT COUNT() FROM Account WHERE Name = \'Test\''
        );
        Test.stopTest();

        Assert.areEqual(1, count, 'Incorrect number of accounts queried');
    }

    @IsTest
    static void testLikeOperator() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name LIKE \'Test%\''
        );
        Test.stopTest();
        Assert.areEqual(
            3,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testWhereConditionWithAnd() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name LIKE \'%Test%\' AND Name != \'Test\''
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testWhereConditionWithOr() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name LIKE \'%Test%\' OR Name != \'Test\''
        );
        Test.stopTest();
        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithBinds() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Map<String, Object> binds = new Map<String, Object>{ 'name' => 'Test' };

        Test.startTest();
        List<Account> queriedAccts = MockDatabase.queryWithBinds(
            'SELECT Id, Name FROM Account WHERE Name = :name',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithBindsList() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        List<String> names = new List<String>{ 'Test', 'Test2' };

        Map<String, Object> binds = new Map<String, Object>{ 'names' => names };

        Test.startTest();
        List<Account> queriedAccts = MockDatabase.queryWithBinds(
            'SELECT Id, Name FROM Account WHERE Name IN :names',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        Assert.areEqual(
            2,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testQueryWithValueList() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name IN (\'Test\', \'Test2\')'
        );
        Test.stopTest();

        Assert.areEqual(
            2,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testWhereClauseParentSubQuery() {
        Account acct = new Account(Name = 'Test');
        Account acct2 = new Account(Name = 'Test2');
        List<Account> accts = new List<Account>{ acct, acct2 };

        MockDatabase.doInsert(accts, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = acct.Id
        );

        MockDatabase.doInsert(con, true);

        Test.startTest();
        List<Contact> queriedCons = (List<Contact>) MockDatabase.query(
            'SELECT Id, FirstName, LastName, Account.Name FROM Contact WHERE Account.Name = \'Test\''
        );
        Test.stopTest();

        Contact queriedCon = queriedCons[0];
        Assert.areEqual(
            1,
            queriedCons.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test',
            queriedCon.Account.Name,
            'Expected account name to be \'Test\''
        );
        Assert.areEqual(
            'Steve',
            queriedCon.FirstName,
            'Expected first name to be \'Steve\''
        );
        Assert.areEqual(
            'Banner',
            queriedCon.LastName,
            'Expected last name to be \'Banner\''
        );
        Assert.areEqual(
            con.Id,
            queriedCon.Id,
            'Expected queried contact to be the same as inserted contact'
        );
    }

    @IsTest
    static void testAllOperators() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account WHERE NumberOfEmployees > 5 AND NumberOfEmployees < 20 AND NumberOfEmployees >= 10 AND NumberOfEmployees <= 15 AND NumberOfEmployees != 20 AND NumberOfEmployees IN (5, 10, 15)'
        );
        Test.stopTest();

        Assert.areEqual(
            2,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testWhereClauseComparisonNonString() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account WHERE NumberOfEmployees = 5'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testWhereClauseNotIn() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account WHERE NumberOfEmployees NOT IN (5, 10, 15)'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testWhereClauseSubQuery() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );
        MockDatabase.doInsert(con, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Account.Name = \'Test\')'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testSumFunc() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT SUM(NumberOfEmployees) FROM Account'
        );
        Test.stopTest();

        Decimal sum = (Decimal) queriedAccts[0].get('expr0');
        Assert.areEqual(50, sum, 'Incorrect sum');
    }

    @IsTest
    static void testSingulerCount() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Integer count = MockDatabase.countQuery('SELECT COUNT() FROM Account');
        Test.stopTest();

        Assert.areEqual(4, count, 'Incorrect count');
    }

    @IsTest
    static void testCountWithGroupBy() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT COUNT(Id) FROM Account GROUP BY Name'
        );
        Test.stopTest();

        Assert.areEqual(4, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testCountDistinct() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT COUNT_DISTINCT(Name) FROM Account'
        );
        Test.stopTest();

        Integer count = (Integer) queriedAccts[0].get('expr0');
        Assert.areEqual(4, count, 'Incorrect count');
    }

    @IsTest
    static void testMinFunc() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT MIN(NumberOfEmployees) FROM Account'
        );
        Test.stopTest();

        Decimal min = (Decimal) queriedAccts[0].get('expr0');
        Assert.areEqual(5, min, 'Incorrect min');
    }

    @IsTest
    static void testMaxFunc() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT MAX(NumberOfEmployees) FROM Account'
        );
        Test.stopTest();

        Decimal max = (Decimal) queriedAccts[0].get('expr0');
        Assert.areEqual(20, max, 'Incorrect max');
    }

    @IsTest
    static void testSumWithAlias() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT SUM(NumberOfEmployees) sum FROM Account'
        );
        Test.stopTest();
        Decimal sum = (Decimal) queriedAccts[0].get('sum');
        Assert.areEqual(50, sum, 'Incorrect sum');
    }

    @IsTest
    static void testAvgFunc() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT AVG(NumberOfEmployees) FROM Account'
        );
        Test.stopTest();

        Decimal avg = (Decimal) queriedAccts[0].get('expr0');
        Assert.areEqual(12.5, avg, 'Incorrect avg');
    }

    @IsTest
    static void testSumWithGroupBy() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 5);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT SUM(NumberOfEmployees) FROM Account GROUP BY Name'
        );
        Test.stopTest();

        Assert.areEqual(3, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testGroupBySelectBadField() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 5);
        Account d = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);
        String exMessage;
        Test.startTest();
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY NumberOfEmployees'
            );
        } catch (QueryException e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage.contains('Field must be grouped or aggregated'),
            'Expected exception message to contain \'Field must be grouped or aggregated\''
        );
    }

    @IsTest
    static void testMultipleAggregateFuncs() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account c = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account d = new Account(Name = 'Test', NumberOfEmployees = 5);

        Account e = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account f = new Account(Name = 'Test3', NumberOfEmployees = 5);
        Account g = new Account(Name = 'Not Test', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d, e, f, g };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees), AVG(NumberOfEmployees) FROM Account GROUP BY Name'
        );
        Test.stopTest();

        Assert.areEqual(4, queriedAccts.size(), 'Incorrect count');
        for (Aggregate agg : queriedAccts) {
            Decimal sum = (Decimal) agg.get('expr0');
            Decimal avg = (Decimal) agg.get('expr1');
            if (agg.get('Name') == 'Test') {
                Assert.areEqual(20, sum, 'Incorrect sum');
                Assert.areEqual(5, avg, 'Incorrect avg');
            } else if (agg.get('Name') == 'Test2') {
                Assert.areEqual(10, sum, 'Incorrect sum');
                Assert.areEqual(10, avg, 'Incorrect avg');
            } else if (agg.get('Name') == 'Test3') {
                Assert.areEqual(5, sum, 'Incorrect sum');
                Assert.areEqual(5, avg, 'Incorrect avg');
            } else if (agg.get('Name') == 'Not Test') {
                Assert.areEqual(20, sum, 'Incorrect sum');
                Assert.areEqual(20, avg, 'Incorrect avg');
            }
        }
    }

    @IsTest
    static void testAggrGroupByFail() {
        Account a = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account c = new Account(Name = 'Test', NumberOfEmployees = 5);
        Account d = new Account(Name = 'Test', NumberOfEmployees = 5);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, COUNT_DISTINCT(Name) FROM Account GROUP BY Name'
            );
        } catch (QueryException e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage.contains('Grouped field should not be aggregated'),
            'Expected exception message to contain \'Field must be grouped or aggregated\''
        );
    }

    @IsTest
    static void testEmptyQuery() {
        Test.startTest();
        List<SObject> queriedAccts = MockDatabase.query(
            'SELECT Id FROM Account'
        );
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testGroupByParentAccountName() {
        Account a = new Account(Name = 'Test 1');
        Account b = new Account(Name = 'Test 2');
        Account c = new Account(Name = 'Test 3');
        Account d = new Account(Name = 'Test 4');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );
        MockDatabase.doInsert(con, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.aggregateQuery(
                'SELECT Account.Name, Name, COUNT(Id) FROM Contact GROUP BY Name, Account.Name'
            );
        } catch (QueryException e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage.contains('Duplicate alias'),
            'Expected exception message to contain \'Duplicate alias\''
        );
    }

    @IsTest
    static void testChildSubQueryWithWhereClause() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            conList.add(con);
        }
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, (SELECT FirstName, LastName FROM Contacts WHERE FirstName LIKE \'%Steve%\') FROM Account'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            5,
            queriedAccts[0].Contacts.size(),
            'Incorrect number of contacts queried'
        );

        for (Contact con : queriedAccts[0].Contacts) {
            Assert.isTrue(
                con.FirstName.contains('Steve'),
                'Expected first name to contain \'Steve\''
            );
        }
    }

    @IsTest
    static void testChildSubQueryWithWhereClause2() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'Steve',
                LastName = 'Banner' + i,
                AccountId = acct.Id
            );
            conList.add(con);
        }
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, (SELECT FirstName, LastName FROM Contacts WHERE LastName IN (\'Banner1\', \'Banner2\', \'Banner3\')) FROM Account'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            3,
            queriedAccts[0].Contacts.size(),
            'Incorrect number of contacts queried'
        );
        List<String> expectedLastNames = new List<String>{
            'Banner1',
            'Banner2',
            'Banner3'
        };
        for (Integer i = 0; i < 3; i++) {
            Contact con = queriedAccts[0].Contacts[i];
            Assert.isTrue(
                expectedLastNames.contains(con.LastName),
                'Expected last name to be in list of expected last names'
            );
        }
    }

    @IsTest
    static void testNot() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE NOT Name = \'Test\''
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testConditionalSubExpr() {
        Account a = new Account(Name = 'Test');
        Account b = new Account(Name = 'Test2');
        Account c = new Account(Name = 'Test3');
        Account d = new Account(Name = 'Not Test');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE Name = \'Test\' OR (Name = \'Test2\' AND Name = \'Test3\')'
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testHavingClause() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING SUM(NumberOfEmployees) > 10'
        );
        Test.stopTest();
        Assert.areEqual(2, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testHavingClauseMixedConditions() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING Name = \'Test1\' AND SUM(NumberOfEmployees) > 10 AND Name = \'Test2\''
        );
        Test.stopTest();

        Assert.areEqual(0, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testHavingClauseWithMixedConditionsCorrectAnd() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING Name = \'Test2\' OR Name = \'Test1\' AND SUM(NumberOfEmployees) > 10'
        );
        Test.stopTest();

        Assert.areEqual(2, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testHavingWithQueryWithBinds() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Map<String, Object> binds = new Map<String, Object>{ 'num' => 10 };

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQueryWithBinds(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING SUM(NumberOfEmployees) > :num',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(2, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testHavingCrazyConditions() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING Name = \'Test1\' AND SUM(NumberOfEmployees) > 10 OR Name = \'Test2\' AND SUM(NumberOfEmployees) > 10'
        );
        Test.stopTest();

        Assert.areEqual(2, queriedAccts.size(), 'Incorrect count');
    }

    @IsTest
    static void testOrderBy() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test4', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);
        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account ORDER BY Name'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test1', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[3].Name, 'Incorrect order');
    }

    @IsTest
    static void testOrderByDESC() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test4', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account ORDER BY Name DESC'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test4', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test1', queriedAccts[3].Name, 'Incorrect order');
    }

    @IsTest
    static void testOrderByASC() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test2', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test4', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account ORDER BY Name ASC'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test1', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[3].Name, 'Incorrect order');
    }

    @IsTest
    static void testOrderByWithGroupBy() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);
        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name ORDER BY Name'
        );
        Test.stopTest();

        Assert.areEqual(
            'Test1',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByWithGroupByDESC() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name ORDER BY Name DESC'
        );
        Test.stopTest();

        Assert.areEqual(
            'Test2',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test1',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByWithGroupByASC() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);
        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name ORDER BY Name ASC'
        );
        Test.stopTest();
        Assert.areEqual(
            'Test1',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByTwoFields() {
        Account a = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account b = new Account(Name = 'Test1', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Test2', NumberOfEmployees = 15);
        Account d = new Account(Name = 'Test2', NumberOfEmployees = 20);
        Account e = new Account(Name = 'Test2', NumberOfEmployees = 5);
        Account f = new Account(Name = 'Test3', NumberOfEmployees = 10);
        Account g = new Account(Name = 'Test3', NumberOfEmployees = 15);
        Account h = new Account(Name = 'Test3', NumberOfEmployees = 20);
        Account i = new Account(Name = 'Test3', NumberOfEmployees = 5);
        Account j = new Account(Name = 'Test4', NumberOfEmployees = 10);
        Account k = new Account(Name = 'Test4', NumberOfEmployees = 15);
        Account l = new Account(Name = 'Test4', NumberOfEmployees = 20);
        Account m = new Account(Name = 'Test4', NumberOfEmployees = 5);

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m
        };
        MockDatabase.doInsert(acctList, true);
        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees FROM Account ORDER BY Name, NumberOfEmployees'
        );
        Test.stopTest();
        Assert.areEqual(
            13,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test1', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test1', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[4].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[5].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[6].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[7].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[8].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[9].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[10].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[11].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[12].Name, 'Incorrect order');

        Assert.areEqual(
            5,
            queriedAccts[0].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            10,
            queriedAccts[1].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            5,
            queriedAccts[2].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            15,
            queriedAccts[3].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            20,
            queriedAccts[4].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            5,
            queriedAccts[5].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            10,
            queriedAccts[6].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            15,
            queriedAccts[7].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            20,
            queriedAccts[8].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            5,
            queriedAccts[9].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            10,
            queriedAccts[10].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            15,
            queriedAccts[11].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            20,
            queriedAccts[12].NumberOfEmployees,
            'Incorrect order'
        );
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    static void testOrderByThreeFields() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m
        };
        MockDatabase.doInsert(acctList, true);
        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY Name, NumberOfEmployees, AnnualRevenue'
        );
        Test.stopTest();
        Assert.areEqual(
            13,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );

        Assert.areEqual('Test1', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual(
            5,
            queriedAccts[0].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(1000, queriedAccts[0].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test1', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual(
            10,
            queriedAccts[1].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(1000, queriedAccts[1].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test2', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual(
            5,
            queriedAccts[2].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(2000, queriedAccts[2].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test2', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual(
            5,
            queriedAccts[3].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(4000, queriedAccts[3].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test2', queriedAccts[4].Name, 'Incorrect order');
        Assert.areEqual(
            20,
            queriedAccts[4].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(3000, queriedAccts[4].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test3', queriedAccts[5].Name, 'Incorrect order');
        Assert.areEqual(
            5,
            queriedAccts[5].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(5000, queriedAccts[5].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test3', queriedAccts[6].Name, 'Incorrect order');
        Assert.areEqual(
            10,
            queriedAccts[6].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(3000, queriedAccts[6].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test3', queriedAccts[7].Name, 'Incorrect order');
        Assert.areEqual(
            10,
            queriedAccts[7].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(5000, queriedAccts[7].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test3', queriedAccts[8].Name, 'Incorrect order');
        Assert.areEqual(
            15,
            queriedAccts[8].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(3000, queriedAccts[8].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test4', queriedAccts[9].Name, 'Incorrect order');
        Assert.areEqual(
            5,
            queriedAccts[9].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(3000, queriedAccts[9].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test4', queriedAccts[10].Name, 'Incorrect order');
        Assert.areEqual(
            5,
            queriedAccts[10].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            4000,
            queriedAccts[10].AnnualRevenue,
            'Incorrect order'
        );

        Assert.areEqual('Test4', queriedAccts[11].Name, 'Incorrect order');
        Assert.areEqual(
            10,
            queriedAccts[11].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            2000,
            queriedAccts[11].AnnualRevenue,
            'Incorrect order'
        );

        Assert.areEqual('Test4', queriedAccts[12].Name, 'Incorrect order');
        Assert.areEqual(
            10,
            queriedAccts[12].NumberOfEmployees,
            'Incorrect order'
        );
        Assert.areEqual(
            10000,
            queriedAccts[12].AnnualRevenue,
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByWithParentField() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m
        };
        MockDatabase.doInsert(acctList, true);

        Contact con0 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );

        Contact con1 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = b.Id
        );

        Contact con2 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = c.Id
        );

        Contact con3 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = d.Id
        );
        List<Contact> conList = new List<Contact>{ con0, con1, con2, con3 };
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Contact> queriedContacts = (List<Contact>) MockDatabase.query(
            'SELECT Id, FirstName, LastName, Account.Name FROM Contact ORDER BY Account.Name'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedContacts.size(),
            'Incorrect number of contacts queried'
        );
        Assert.areEqual(
            'Test1',
            queriedContacts[0].Account.Name,
            'Incorrect order'
        );
        Assert.areEqual(
            'Test1',
            queriedContacts[1].Account.Name,
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedContacts[2].Account.Name,
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedContacts[3].Account.Name,
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByWithGroupByParentField() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m
        };
        MockDatabase.doInsert(acctList, true);

        Contact con0 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );

        Contact con1 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = c.Id
        );

        Contact con2 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = f.Id
        );

        Contact con3 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = j.Id
        );
        List<Contact> conList = new List<Contact>{ con0, con1, con2, con3 };
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Account.Name, COUNT(Id) FROM Contact GROUP BY Account.Name ORDER BY Account.Name'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );

        Assert.areEqual(
            'Test1',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test3',
            queriedAccts[2].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test4',
            queriedAccts[3].get('Name'),
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByMutipleOrders() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m
        };
        MockDatabase.doInsert(acctList, true);

        Contact con0 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );

        Contact con1 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = c.Id
        );

        Contact con2 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = f.Id
        );

        Contact con3 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = j.Id
        );
        List<Contact> conList = new List<Contact>{ con0, con1, con2, con3 };
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Account.Name, COUNT(Id)' +
                ' FROM Contact' +
                ' GROUP BY Account.Name' +
                ' ORDER BY Account.Name, COUNT(Id)'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            'Test1',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test3',
            queriedAccts[2].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test4',
            queriedAccts[3].get('Name'),
            'Incorrect order'
        );
    }

    @IsTest
    static void testOrderByMutipleOrdersDESC() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m
        };
        MockDatabase.doInsert(acctList, true);

        Contact con0 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );

        Contact con1 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = c.Id
        );

        Contact con2 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = f.Id
        );

        Contact con3 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = j.Id
        );

        Contact con4 = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = k.Id
        );
        List<Contact> conList = new List<Contact>{
            con0,
            con1,
            con2,
            con3,
            con4
        };
        MockDatabase.doInsert(conList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Account.Name, COUNT(Id)' +
                ' FROM Contact' +
                ' GROUP BY Account.Name' +
                ' ORDER BY Account.Name DESC, COUNT(Id) DESC'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            'Test4',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test3',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAccts[2].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test1',
            queriedAccts[3].get('Name'),
            'Incorrect order'
        );

        Assert.areEqual(2, queriedAccts[0].get('expr0'), 'Incorrect order');
        Assert.areEqual(1, queriedAccts[1].get('expr0'), 'Incorrect order');
        Assert.areEqual(1, queriedAccts[2].get('expr0'), 'Incorrect order');
        Assert.areEqual(1, queriedAccts[3].get('expr0'), 'Incorrect order');
    }

    @IsTest
    static void testNullsFirst() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account n = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = null
        );
        Account o = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue NULLS FIRST'
        );
        Test.stopTest();

        Assert.areEqual(
            15,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test5', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test1', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test1', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test5', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[4].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[5].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[6].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[7].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[8].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[9].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[10].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[11].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[12].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[13].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[14].Name, 'Incorrect order');
    }

    @IsTest
    static void testNullsLast() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account n = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = null
        );
        Account o = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue NULLS LAST'
        );
        Test.stopTest();

        Assert.areEqual(
            15,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test1', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test1', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test5', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[4].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[5].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[6].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[7].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[8].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[9].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[10].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[11].Name, 'Incorrect order');
        Assert.areEqual('Test3', queriedAccts[12].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[13].Name, 'Incorrect order');
        Assert.areEqual('Test5', queriedAccts[14].Name, 'Incorrect order');
    }

    @IsTest
    static void testLimitSObject() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account n = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = null
        );
        Account o = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue NULLS LAST, Name NULLS FIRST LIMIT 5'
        );
        Test.stopTest();

        Assert.areEqual(
            5,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(1000, queriedAccts[0].AnnualRevenue, 'Incorrect order');
        Assert.areEqual(1000, queriedAccts[1].AnnualRevenue, 'Incorrect order');
        Assert.areEqual(1000, queriedAccts[2].AnnualRevenue, 'Incorrect order');
        Assert.areEqual(2000, queriedAccts[3].AnnualRevenue, 'Incorrect order');
        Assert.areEqual(2000, queriedAccts[4].AnnualRevenue, 'Incorrect order');

        Assert.areEqual('Test1', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test1', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test5', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test2', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test4', queriedAccts[4].Name, 'Incorrect order');
    }

    @IsTest
    static void testLimitCount() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account n = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = null
        );
        Account o = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Integer acctCount = MockDatabase.countQuery(
            'SELECT COUNT() FROM Account LIMIT 5'
        );
        Test.stopTest();

        Assert.areEqual(5, acctCount, 'Incorrect number of accounts queried');
    }

    @IsTest
    static void testLimitAggregate() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test1',
            NumberOfEmployees = 10,
            AnnualRevenue = 1000
        );
        Account c = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 2000
        );
        Account d = new Account(
            Name = 'Test2',
            NumberOfEmployees = 20,
            AnnualRevenue = 3000
        );
        Account e = new Account(
            Name = 'Test2',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account f = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 5000
        );
        Account g = new Account(
            Name = 'Test3',
            NumberOfEmployees = 15,
            AnnualRevenue = 3000
        );
        Account h = new Account(
            Name = 'Test3',
            NumberOfEmployees = 10,
            AnnualRevenue = 3000
        );
        Account i = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account j = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test4',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account l = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 4000
        );
        Account m = new Account(
            Name = 'Test4',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account n = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = null
        );
        Account o = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Name, COUNT(Id) FROM Account GROUP BY Name ORDER BY Name LIMIT 3'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            'Test1',
            queriedAccts[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAccts[1].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test3',
            queriedAccts[2].get('Name'),
            'Incorrect order'
        );

        Assert.areEqual(2, queriedAccts[0].get('expr0'), 'Incorrect order');
        Assert.areEqual(3, queriedAccts[1].get('expr0'), 'Incorrect order');
        Assert.areEqual(4, queriedAccts[2].get('expr0'), 'Incorrect order');
    }

    @IsTest
    static void testOnlyQueriedFieldsReturned() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        MockDatabase.doInsert(new List<Account>{ a }, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Name FROM Account'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual(
            'Test1',
            queriedAccts[0].Name,
            'Name should have been queried'
        );
        Assert.isNull(
            queriedAccts[0].NumberOfEmployees,
            'NumberOfEmployees should not have been queried'
        );
        Assert.isNull(
            queriedAccts[0].AnnualRevenue,
            'AnnualRevenue should not have been queried'
        );
    }

    @IsTest
    static void testOffset() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test2',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account c = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account d = new Account(
            Name = 'Test4',
            NumberOfEmployees = 20,
            AnnualRevenue = 4000
        );
        Account e = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account f = new Account(
            Name = 'Test6',
            NumberOfEmployees = 10,
            AnnualRevenue = 6000
        );
        Account g = new Account(
            Name = 'Test7',
            NumberOfEmployees = 15,
            AnnualRevenue = 7000
        );
        Account h = new Account(
            Name = 'Test8',
            NumberOfEmployees = 10,
            AnnualRevenue = 8000
        );
        Account i = new Account(
            Name = 'Test9',
            NumberOfEmployees = 5,
            AnnualRevenue = 9000
        );
        Account j = new Account(
            Name = 'Test10',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test11',
            NumberOfEmployees = 10,
            AnnualRevenue = 11000
        );
        Account l = new Account(
            Name = 'Test12',
            NumberOfEmployees = 5,
            AnnualRevenue = 12000
        );
        Account m = new Account(
            Name = 'Test13',
            NumberOfEmployees = 5,
            AnnualRevenue = 13000
        );
        Account n = new Account(
            Name = 'Test14',
            NumberOfEmployees = 5,
            AnnualRevenue = 14000
        );
        Account o = new Account(
            Name = 'Test15',
            NumberOfEmployees = 5,
            AnnualRevenue = 15000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue OFFSET 5'
        );
        Test.stopTest();

        Assert.areEqual(
            10,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test6', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test7', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test8', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test9', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test10', queriedAccts[4].Name, 'Incorrect order');
        Assert.areEqual('Test11', queriedAccts[5].Name, 'Incorrect order');
        Assert.areEqual('Test12', queriedAccts[6].Name, 'Incorrect order');
        Assert.areEqual('Test13', queriedAccts[7].Name, 'Incorrect order');
        Assert.areEqual('Test14', queriedAccts[8].Name, 'Incorrect order');
        Assert.areEqual('Test15', queriedAccts[9].Name, 'Incorrect order');
    }

    @IsTest
    static void testOffsetWithBindVar() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test2',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account c = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account d = new Account(
            Name = 'Test4',
            NumberOfEmployees = 20,
            AnnualRevenue = 4000
        );
        Account e = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account f = new Account(
            Name = 'Test6',
            NumberOfEmployees = 10,
            AnnualRevenue = 6000
        );
        Account g = new Account(
            Name = 'Test7',
            NumberOfEmployees = 15,
            AnnualRevenue = 7000
        );
        Account h = new Account(
            Name = 'Test8',
            NumberOfEmployees = 10,
            AnnualRevenue = 8000
        );
        Account i = new Account(
            Name = 'Test9',
            NumberOfEmployees = 5,
            AnnualRevenue = 9000
        );
        Account j = new Account(
            Name = 'Test10',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test11',
            NumberOfEmployees = 10,
            AnnualRevenue = 11000
        );
        Account l = new Account(
            Name = 'Test12',
            NumberOfEmployees = 5,
            AnnualRevenue = 12000
        );
        Account m = new Account(
            Name = 'Test13',
            NumberOfEmployees = 5,
            AnnualRevenue = 13000
        );
        Account n = new Account(
            Name = 'Test14',
            NumberOfEmployees = 5,
            AnnualRevenue = 14000
        );
        Account o = new Account(
            Name = 'Test15',
            NumberOfEmployees = 5,
            AnnualRevenue = 15000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Map<String, Object> binds = new Map<String, Object>{ 'offset' => 5 };
        Test.startTest();
        List<Account> queriedAccts = MockDatabase.queryWithBinds(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue OFFSET :offset',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        Assert.areEqual(
            10,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test6', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test7', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test8', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test9', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test10', queriedAccts[4].Name, 'Incorrect order');
        Assert.areEqual('Test11', queriedAccts[5].Name, 'Incorrect order');
        Assert.areEqual('Test12', queriedAccts[6].Name, 'Incorrect order');
        Assert.areEqual('Test13', queriedAccts[7].Name, 'Incorrect order');
        Assert.areEqual('Test14', queriedAccts[8].Name, 'Incorrect order');
        Assert.areEqual('Test15', queriedAccts[9].Name, 'Incorrect order');
    }

    @IsTest
    static void testLimitWithBindVar() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test2',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account c = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account d = new Account(
            Name = 'Test4',
            NumberOfEmployees = 20,
            AnnualRevenue = 4000
        );
        Account e = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account f = new Account(
            Name = 'Test6',
            NumberOfEmployees = 10,
            AnnualRevenue = 6000
        );
        Account g = new Account(
            Name = 'Test7',
            NumberOfEmployees = 15,
            AnnualRevenue = 7000
        );
        Account h = new Account(
            Name = 'Test8',
            NumberOfEmployees = 10,
            AnnualRevenue = 8000
        );
        Account i = new Account(
            Name = 'Test9',
            NumberOfEmployees = 5,
            AnnualRevenue = 9000
        );
        Account j = new Account(
            Name = 'Test10',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test11',
            NumberOfEmployees = 10,
            AnnualRevenue = 11000
        );
        Account l = new Account(
            Name = 'Test12',
            NumberOfEmployees = 5,
            AnnualRevenue = 12000
        );
        Account m = new Account(
            Name = 'Test13',
            NumberOfEmployees = 5,
            AnnualRevenue = 13000
        );
        Account n = new Account(
            Name = 'Test14',
            NumberOfEmployees = 5,
            AnnualRevenue = 14000
        );
        Account o = new Account(
            Name = 'Test15',
            NumberOfEmployees = 5,
            AnnualRevenue = 15000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Map<String, Object> binds = new Map<String, Object>{ 'limit' => 5 };
        Test.startTest();
        List<Account> queriedAccts = MockDatabase.queryWithBinds(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue LIMIT :limit',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        Assert.areEqual(
            5,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testLimitAndOffsetTogether() {
        Account a = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );
        Account b = new Account(
            Name = 'Test2',
            NumberOfEmployees = 10,
            AnnualRevenue = 2000
        );
        Account c = new Account(
            Name = 'Test3',
            NumberOfEmployees = 5,
            AnnualRevenue = 3000
        );
        Account d = new Account(
            Name = 'Test4',
            NumberOfEmployees = 20,
            AnnualRevenue = 4000
        );
        Account e = new Account(
            Name = 'Test5',
            NumberOfEmployees = 5,
            AnnualRevenue = 5000
        );
        Account f = new Account(
            Name = 'Test6',
            NumberOfEmployees = 10,
            AnnualRevenue = 6000
        );
        Account g = new Account(
            Name = 'Test7',
            NumberOfEmployees = 15,
            AnnualRevenue = 7000
        );
        Account h = new Account(
            Name = 'Test8',
            NumberOfEmployees = 10,
            AnnualRevenue = 8000
        );
        Account i = new Account(
            Name = 'Test9',
            NumberOfEmployees = 5,
            AnnualRevenue = 9000
        );
        Account j = new Account(
            Name = 'Test10',
            NumberOfEmployees = 10,
            AnnualRevenue = 10000
        );
        Account k = new Account(
            Name = 'Test11',
            NumberOfEmployees = 10,
            AnnualRevenue = 11000
        );
        Account l = new Account(
            Name = 'Test12',
            NumberOfEmployees = 5,
            AnnualRevenue = 12000
        );
        Account m = new Account(
            Name = 'Test13',
            NumberOfEmployees = 5,
            AnnualRevenue = 13000
        );
        Account n = new Account(
            Name = 'Test14',
            NumberOfEmployees = 5,
            AnnualRevenue = 14000
        );
        Account o = new Account(
            Name = 'Test15',
            NumberOfEmployees = 5,
            AnnualRevenue = 15000
        );

        List<Account> acctList = new List<Account>{
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            l,
            m,
            n,
            o
        };
        MockDatabase.doInsert(acctList, true);

        Map<String, Object> binds = new Map<String, Object>{
            'limit' => 5,
            'offset' => 5
        };
        Test.startTest();
        List<Account> queriedAccts = MockDatabase.queryWithBinds(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account ORDER BY AnnualRevenue LIMIT :limit OFFSET :offset',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        Assert.areEqual(
            5,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
        Assert.areEqual('Test6', queriedAccts[0].Name, 'Incorrect order');
        Assert.areEqual('Test7', queriedAccts[1].Name, 'Incorrect order');
        Assert.areEqual('Test8', queriedAccts[2].Name, 'Incorrect order');
        Assert.areEqual('Test9', queriedAccts[3].Name, 'Incorrect order');
        Assert.areEqual('Test10', queriedAccts[4].Name, 'Incorrect order');
    }

    @IsTest
    static void testForUpdate() {
        Account acct = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        MockDatabase.doInsert(acct, true);

        Test.startTest();
        List<Account> queriedAccts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name, NumberOfEmployees, AnnualRevenue FROM Account FOR UPDATE'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testForUpdateFailOnGroupBy() {
        Account acct = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        MockDatabase.doInsert(acct, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.query(
                'SELECT Name, COUNT(Id) FROM Account GROUP BY Name FOR UPDATE'
            );
        } catch (Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage != null &&
            exMessage.contains('FOR UPDATE not allowed in this context'),
            'Exception should have been thrown with the message "FOR UPDATE not allowed in this context"'
        );
    }

    @IsTest
    static void testForUpdateFailOnCount() {
        Account acct = new Account(
            Name = 'Test1',
            NumberOfEmployees = 5,
            AnnualRevenue = 1000
        );

        MockDatabase.doInsert(acct, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.query('SELECT COUNT() FROM Account FOR UPDATE');
        } catch (Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage != null &&
            exMessage.contains('FOR UPDATE not allowed in this context'),
            'Exception should have been thrown with the message "FOR UPDATE not allowed in this context"'
        );
    }

    @IsTest
    static void testIncludes() {
        QuickText qt1 = new QuickText(Name = 'Test1', Channel = 'Email;Phone;');

        QuickText qt2 = new QuickText(Name = 'Test2', Channel = 'Phone;');

        List<QuickText> qtList = new List<QuickText>{ qt1, qt2 };

        MockDatabase.doInsert(qtList, true);

        Test.startTest();
        List<QuickText> queriedQTs = (List<QuickText>) MockDatabase.query(
            'SELECT Name, Channel FROM QuickText WHERE Channel INCLUDES (\'Email\')'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedQTs.size(),
            'Incorrect number of quick texts queried'
        );
    }

    @IsTest
    static void testExcludes() {
        QuickText qt1 = new QuickText(Name = 'Test1', Channel = 'Email;Phone;');

        QuickText qt2 = new QuickText(Name = 'Test2', Channel = 'Phone;');

        List<QuickText> qtList = new List<QuickText>{ qt1, qt2 };

        MockDatabase.doInsert(qtList, true);

        Test.startTest();
        List<QuickText> queriedQTs = (List<QuickText>) MockDatabase.query(
            'SELECT Name, Channel FROM QuickText WHERE Channel EXCLUDES (\'Email\')'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedQTs.size(),
            'Incorrect number of quick texts queried'
        );
    }

    @IsTest
    static void testTypeOf() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Task t = new Task(Subject = 'Test', WhatId = acct.Id);
        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT TYPEOF What WHEN Account THEN Name ELSE Id END FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];

        Assert.areEqual(acct.Name, queriedTask.What.Name, 'Incorrect Name');
    }

    @IsTest
    static void testTypeOfWithOtherFields() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Task t = new Task(Subject = 'Test', WhatId = acct.Id);
        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT Id, Subject, TYPEOF What WHEN Account THEN Name ELSE Id END FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];

        Assert.areEqual(acct.Name, queriedTask.What.Name, 'Incorrect Name');
        Assert.areEqual(queriedTask.Subject, 'Test', 'Incorrect Subject');
    }

    @IsTest
    static void testTypeOfNoElse() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Task t = new Task(Subject = 'Test', WhatId = acct.Id);
        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT TYPEOF What WHEN Account THEN Name END FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];

        Assert.areEqual('Test', queriedTask.What.Name, 'Should be null');
    }

    @IsTest
    static void testTypeOfNoCaseMet() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Task t = new Task(Subject = 'Test', WhatId = acct.Id);
        MockDatabase.doInsert(t, true);
        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT TYPEOF What WHEN Opportunity THEN Name END FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];

        Assert.isNull(queriedTask.What, 'Should be null');
    }

    @IsTest
    static void testTypeOfWithMultipleCases() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);
        Task t = new Task(Subject = 'Test', WhatId = acct.Id);
        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT TYPEOF What WHEN Opportunity THEN Name WHEN Account THEN Name ELSE Id END FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];

        Assert.areEqual('Test', queriedTask.What.Name, 'Incorrect Name');
    }

    @IsTest
    static void testTypeOfWithOwner() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'realemail@email.com',
            Email = 'realemail@email.com'
        );

        MockDatabase.doInsert(u, true);
        Case c = new Case(OwnerId = u.Id);
        MockDatabase.doInsert(c, true);

        Test.startTest();
        List<Case> queriedCaseList = (List<Case>) MockDatabase.query(
            'SELECT TYPEOF Owner WHEN User THEN FirstName ELSE Id END FROM Case'
        );
        Test.stopTest();

        Case queriedCase = queriedCaseList[0];

        Assert.areEqual(
            u.FirstName,
            queriedCase.Owner.FirstName,
            'Incorrect Name'
        );
    }

    @IsTest
    static void testTypeOfWithOwnerElse() {
        Group caseQueue = new Group(
            Name = 'Case Queue',
            DeveloperName = 'Case_Queue'
        );

        MockDatabase.doInsert(caseQueue, true);
        Case c = new Case(OwnerId = caseQueue.Id);
        MockDatabase.doInsert(c, true);

        Test.startTest();
        List<Case> queriedCaseList = (List<Case>) MockDatabase.query(
            'SELECT TYPEOF Owner WHEN User THEN FirstName ELSE Name END FROM Case'
        );
        Test.stopTest();

        Case queriedCase = queriedCaseList[0];

        Assert.areEqual(
            caseQueue.Name,
            queriedCase.Owner.Name,
            'Incorrect Name'
        );
    }

    @IsTest
    static void testTypeOfWithGroupBy() {
        Group caseQueue = new Group(
            Name = 'Case Queue',
            DeveloperName = 'Case_Queue'
        );

        MockDatabase.doInsert(caseQueue, true);
        Case c = new Case(OwnerId = caseQueue.Id);
        MockDatabase.doInsert(c, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.query(
                'SELECT OwnerId, TYPEOF Owner WHEN User THEN FirstName ELSE Name END FROM Case GROUP BY OwnerId'
            );
        } catch (Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage != null &&
            exMessage.contains('TYPEOF not supported with GROUP BY'),
            'Exception should have been thrown with the message "TYPEOF not allowed in GROUP BY query"'
        );
    }

    @IsTest
    static void testTypeOfOuterJoin() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'test@test.com'
        );
        MockDatabase.doInsert(u, true);

        Account acct = new Account(OwnerId = u.Id, Name = 'Test');
        MockDatabase.doInsert(acct, true);

        Opportunity opp = new Opportunity(
            OwnerId = u.Id,
            Name = 'Test Opp',
            AccountId = acct.Id
        );
        MockDatabase.doInsert(opp, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.query(
                'SELECT Name FROM Account WHERE Id IN (SELECT TYPEOF Owner WHEN User THEN Id ELSE Id END FROM Opportunity)'
            );
        } catch (Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage != null &&
            exMessage.contains('TYPEOF not supported in outer join'),
            'Expected exception to be thrown'
        );
    }

    @IsTest
    static void testNormalPolymorphic() {
        Opportunity opp = new Opportunity(Name = 'Test');

        MockDatabase.doInsert(opp, true);

        Task t = new Task(Subject = 'Test', WhatId = opp.Id);
        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT Id, Subject, WhatId, What.Name FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];
        Assert.areEqual('Test', queriedTask.What.Name, 'Incorrect Name');
    }

    @IsTest
    static void testWhatType() {
        Opportunity opp = new Opportunity(Name = 'Test');

        MockDatabase.doInsert(opp, true);

        Task t = new Task(Subject = 'Test', WhatId = opp.Id);
        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Task> queriedTaskList = (List<Task>) MockDatabase.query(
            'SELECT Id, Subject, WhatId, What.Type FROM Task'
        );
        Test.stopTest();

        Task queriedTask = queriedTaskList[0];
        Assert.areEqual('Opportunity', queriedTask.What.Type, 'Incorrect Name');
    }

    @IsTest
    static void testOwnerType() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'fakeemail@email.com'
        );

        MockDatabase.doInsert(u, true);

        case c = new Case(OwnerId = u.Id, Subject = 'Test', Status = 'New');

        MockDatabase.doInsert(c, true);

        Test.startTest();
        List<Case> queriedCaseList = (List<Case>) MockDatabase.query(
            'SELECT Id, Subject, OwnerId, Owner.Type FROM Case'
        );
        Test.stopTest();

        Case queriedCase = queriedCaseList[0];
        Assert.areEqual('User', queriedCase.Owner.Type, 'Incorrect Type');
    }

    @IsTest
    static void testOwnerTypeAndName() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'fakeemail@email.com'
        );

        MockDatabase.doInsert(u, true);

        case c = new Case(OwnerId = u.Id, Subject = 'Test', Status = 'New');

        MockDatabase.doInsert(c, true);

        Test.startTest();
        List<Case> queriedCaseList = (List<Case>) MockDatabase.query(
            'SELECT Id, Subject, OwnerId, Owner.FirstName, Owner.Type FROM Case'
        );
        Test.stopTest();

        Case queriedCase = queriedCaseList[0];
        Assert.areEqual('User', queriedCase.Owner.Type, 'Incorrect Type');
        Assert.areEqual('Test', queriedCase.Owner.FirstName, 'Incorrect Name');
    }

    @IsTest
    static void testFirstNameQueueAndUser() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'fakeemail@email.com'
        );

        Group caseQueue = new Group(
            Name = 'Case Queue',
            DeveloperName = 'Case_Queue'
        );

        List<SObject> owners = new List<SObject>{ u, caseQueue };

        MockDatabase.doInsert(owners, true);

        case c1 = new Case(
            OwnerId = caseQueue.Id,
            Subject = 'Test',
            Status = 'New'
        );

        Case c2 = new Case(OwnerId = u.Id, Subject = 'Test', Status = 'New');

        List<Case> caseList = new List<Case>{ c1, c2 };

        MockDatabase.doInsert(caseList, true);

        Test.startTest();
        List<Case> queriedCaseList = (List<Case>) MockDatabase.query(
            'SELECT Id, Subject, OwnerId, Owner.FirstName, Owner.Type FROM Case'
        );
        Test.stopTest();

        for (case c : queriedCaseList) {
            if (c.Owner.Type == 'User') {
                Assert.areEqual('Test', c.Owner.FirstName, 'Incorrect Name');
            } else {
                Assert.areEqual(null, c.Owner.FirstName, 'Incorrect Name');
            }
        }
    }

    @IsTest
    static void testOwnerTypeAndNameWithWhere() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'fakeemail@email.com'
        );

        Group caseQueue = new Group(
            Name = 'Case Queue',
            DeveloperName = 'Case_Queue'
        );

        List<SObject> owners = new List<SObject>{ u, caseQueue };
        MockDatabase.doInsert(owners, true);

        case c1 = new Case(OwnerId = u.Id, Subject = 'Test', Status = 'New');

        Case c2 = new Case(
            OwnerId = caseQueue.Id,
            Subject = 'Test',
            Status = 'New'
        );

        List<Case> caseList = new List<Case>{ c1, c2 };

        MockDatabase.doInsert(caseList, true);

        Test.startTest();
        List<Case> queriedCaseList = (List<Case>) MockDatabase.query(
            'SELECT Id, Subject, OwnerId, Owner.FirstName, Owner.Type FROM Case WHERE Owner.Type = \'User\''
        );
        Test.stopTest();

        Case queriedCase = queriedCaseList[0];
        Assert.areEqual('User', queriedCase.Owner.Type, 'Incorrect Type');
        Assert.areEqual('Test', queriedCase.Owner.FirstName, 'Incorrect Name');
    }

    @IsTest
    static void testTypeWithGroupBy() {
        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'fakeemail@email.com'
        );

        Group caseQueue = new Group(
            Name = 'Case Queue',
            DeveloperName = 'Case_Queue'
        );

        List<SObject> owners = new List<SObject>{ u, caseQueue };
        MockDatabase.doInsert(owners, true);

        case c1 = new Case(OwnerId = u.Id, Subject = 'Test 1', Status = 'New');

        Case c2 = new Case(
            OwnerId = caseQueue.Id,
            Subject = 'Test 2',
            Status = 'New'
        );

        List<Case> caseList = new List<Case>{ c1, c2 };

        MockDatabase.doInsert(caseList, true);

        Test.startTest();
        List<Aggregate> queriedAggregates = MockDatabase.aggregateQuery(
            'SELECT Owner.Type, Subject FROM Case GROUP BY Owner.Type, Subject'
        );
        Test.stopTest();

        Assert.areEqual(
            2,
            queriedAggregates.size(),
            'Incorrect number of aggregates'
        );
        for (Aggregate a : queriedAggregates) {
            if (a.get('Type') == 'User') {
                Assert.areEqual(
                    'Test 1',
                    a.get('Subject'),
                    'Incorrect Subject'
                );
            } else {
                Assert.areEqual(
                    'Test 2',
                    a.get('Subject'),
                    'Incorrect Subject'
                );
            }
        }
    }

    @IsTest
    static void testTypeWithSubqery() {
        Account acct = new Account(Name = 'Test');

        MockDatabase.doInsert(acct, true);

        Task t = new Task(Subject = 'Test', WhatId = acct.Id);

        MockDatabase.doInsert(t, true);

        Test.startTest();
        List<Account> queriedAcctList = (List<Account>) MockDatabase.query(
            'SELECT (SELECT What.Type FROM Tasks) FROM Account'
        );
        Test.stopTest();

        Account queriedAcct = queriedAcctList[0];
        Task queriedTask = queriedAcct.Tasks[0];
        Assert.areEqual('Account', queriedTask.What.Type, 'Incorrect Name');
    }

    @IsTest
    static void testTypeInHavingClause() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(LastName = 'Test', AccountId = acct.Id);

        MockDatabase.doInsert(con, true);

        Task t = new Task(Subject = 'Test', WhatId = acct.Id);

        Task t2 = new Task(Subject = 'Test', WhatId = con.Id);

        List<Task> taskList = new List<Task>{ t, t2 };

        MockDatabase.doInsert(taskList, true);

        Test.startTest();
        List<Aggregate> queriedAggregates = MockDatabase.aggregateQuery(
            'SELECT What.Type, COUNT(Id) FROM Task GROUP BY What.Type HAVING What.Type = \'Account\''
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAggregates.size(),
            'Incorrect number of aggregates'
        );
        Assert.areEqual(
            'Account',
            queriedAggregates[0].get('Type'),
            'Incorrect Type'
        );
    }

    @IsTest
    static void testTypeInOrderBy() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(LastName = 'Test', AccountId = acct.Id);

        MockDatabase.doInsert(con, true);

        Task t = new Task(Subject = 'Test', WhatId = acct.Id);

        Task t2 = new Task(Subject = 'Test', WhatId = con.Id);

        List<Task> taskList = new List<Task>{ t, t2 };

        MockDatabase.doInsert(taskList, true);

        Test.startTest();
        List<Task> queriedTasks = (List<Task>) MockDatabase.query(
            'SELECT Id, What.Type FROM Task ORDER BY What.Type'
        );
        Test.stopTest();

        Assert.areEqual('Account', queriedTasks[0].What.Type, 'Incorrect Type');
        Assert.areEqual('Contact', queriedTasks[1].What.Type, 'Incorrect Type');
    }

    @IsTest
    static void testTypeInOrderByDesc() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(LastName = 'Test', AccountId = acct.Id);

        MockDatabase.doInsert(con, true);

        Task t = new Task(Subject = 'Test', WhatId = acct.Id);

        Task t2 = new Task(Subject = 'Test', WhatId = con.Id);

        List<Task> taskList = new List<Task>{ t, t2 };

        MockDatabase.doInsert(taskList, true);

        Test.startTest();
        List<Task> queriedTasks = (List<Task>) MockDatabase.query(
            'SELECT Id, What.Type FROM Task ORDER BY What.Type DESC'
        );
        Test.stopTest();

        Assert.areEqual('Contact', queriedTasks[0].What.Type, 'Incorrect Type');
        Assert.areEqual('Account', queriedTasks[1].What.Type, 'Incorrect Type');
    }

    @IsTest
    static void testWhereClauseComparisonToNull1() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(LastName = 'Test', AccountId = acct.Id);

        MockDatabase.doInsert(con, true);

        Task t = new Task(Subject = 'Test', WhatId = acct.Id);

        Task t2 = new Task(Subject = 'Test', WhatId = con.Id);

        List<Task> taskList = new List<Task>{ t, t2 };

        MockDatabase.doInsert(taskList, true);

        Test.startTest();
        List<Task> queriedTasks = (List<Task>) MockDatabase.query(
            'SELECT Id, What.Type FROM Task WHERE What.Type = NULL'
        );
        Test.stopTest();

        Assert.areEqual(0, queriedTasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void testWhereClauseComparisonToNull2() {
        Account acct = new Account(Name = 'Test');
        MockDatabase.doInsert(acct, true);

        Contact con = new Contact(LastName = 'Test', AccountId = acct.Id);

        MockDatabase.doInsert(con, true);

        Task t = new Task(Subject = 'Test', WhatId = acct.Id);

        Task t2 = new Task(Subject = 'Test', WhatId = con.Id);

        List<Task> taskList = new List<Task>{ t, t2 };

        MockDatabase.doInsert(taskList, true);

        Test.startTest();
        List<Task> queriedTasks = (List<Task>) MockDatabase.query(
            'SELECT Id, What.Type FROM Task WHERE What.Type != NULL'
        );
        Test.stopTest();

        Assert.areEqual(2, queriedTasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void testWhereClauseComparisonToNull3() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccounts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE NumberOfEmployees <> NULL'
        );
        Test.stopTest();

        Assert.areEqual(1, queriedAccounts.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void testWhereClauseComparisonToNull4() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Account> queriedAccounts = (List<Account>) MockDatabase.query(
            'SELECT Id, Name FROM Account WHERE NumberOfEmployees = NULL'
        );
        Test.stopTest();

        Assert.areEqual(1, queriedAccounts.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void testWhereClauseComparisonToNull5() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.query(
                'SELECT Id, Name FROM Account WHERE NumberOfEmployees > NULL'
            );
        } catch (QueryException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testWhereClauseComparisonToNull6() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.query(
                'SELECT Id, Name FROM Account WHERE NumberOfEmployees < NULL'
            );
        } catch (QueryException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testWhereClauseComparisonToNull7() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.query(
                'SELECT Id, Name FROM Account WHERE NumberOfEmployees >= NULL'
            );
        } catch (QueryException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testWhereClauseComparisonToNull8() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.query(
                'SELECT Id, Name FROM Account WHERE NumberOfEmployees <= NULL'
            );
        } catch (QueryException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testWhereClauseComparisonToNull9() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.query(
                'SELECT Id, Name FROM Account WHERE Name IN NULL'
            );
        } catch (QueryException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testWhereClauseComparisonToNull10() {
        Account acct1 = new Account(Name = 'Test1', NumberOfEmployees = 5);
        Account acct2 = new Account(Name = 'Test2');
        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.query(
                'SELECT Id, Name FROM Account WHERE Name NOT IN NULL'
            );
        } catch (QueryException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateEqual() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = TODAY'
        );
        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
        Assert.areEqual(
            opp1.Id,
            opportunities[0].Id,
            'Incorrect opportunity queried'
        );
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateLessThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate < TODAY'
        );
        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
        Assert.areEqual(
            opp3.Id,
            opportunities[0].Id,
            'Incorrect opportunity queried'
        );
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateGreaterThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate > TODAY'
        );
        Assert.areEqual(
            2,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateLessThanOrEqual() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate <= TODAY'
        );
        Assert.areEqual(
            2,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateGreaterThanOrEqual() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate >= TODAY'
        );
        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateGreaterThanOrEqual() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));
        Opportunity opp5 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate >= YESTERDAY'
        );
        Assert.areEqual(
            4,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateGreaterThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));
        Opportunity opp5 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate > YESTERDAY'
        );
        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateEquals() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));
        Opportunity opp5 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = YESTERDAY'
        );
        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateLessThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));
        Opportunity opp5 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate < YESTERDAY'
        );
        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateLessThanOrEquals() {
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = GMT.today()
        );
        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(1));
        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));
        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(2));
        Opportunity opp5 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5 },
            true
        );

        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate <= YESTERDAY'
        );
        Assert.areEqual(
            2,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeLessThanOrEqual() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime <= TODAY'
        );
        Assert.areEqual(2, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeLessThan() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime < TODAY'
        );
        Assert.areEqual(1, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeEquals() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime = TODAY'
        );
        Assert.areEqual(1, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeGreaterThan() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime > TODAY'
        );
        Assert.areEqual(2, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeGreaterThanOrEqual() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime >= TODAY'
        );
        Assert.areEqual(3, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeNotEquals1() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime != TODAY'
        );
        Assert.areEqual(3, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureTodayLiteralWorksForDateTimeNotEquals2() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime <> TODAY'
        );
        Assert.areEqual(3, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeLessThanOrEqual() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime <= YESTERDAY'
        );
        Assert.areEqual(1, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeLessThan() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );
        Task t5 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4, t5 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime < YESTERDAY'
        );
        Assert.areEqual(1, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeEquals() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime = YESTERDAY'
        );
        Assert.areEqual(1, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeGreaterThan() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime > YESTERDAY'
        );
        Assert.areEqual(3, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeGreaterThanOrEqual() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime >= YESTERDAY'
        );
        Assert.areEqual(4, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeNotEquals1() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime != YESTERDAY'
        );
        Assert.areEqual(3, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureYesterdayLiteralWorksForDateTimeNotEquals2() {
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now()
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(1)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(-1)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.now().addDays(2)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime <> YESTERDAY'
        );
        Assert.areEqual(3, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureLastWeekLiteralWorksForDateTimeLessThanOrEquals() {
        Date startOfLastWeek = GMT.today().toStartOfWeek().addDays(-7);
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfLastWeek.addDays(-14)
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfLastWeek.addDays(-15)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfLastWeek.addDays(4)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfLastWeek.addDays(5)
        );
        Task t5 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            GMT.today().toStartOfWeek().addMonths(1)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4, t5 }, true);

        Test.startTest();
        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime <= LAST_WEEK'
        );
        Test.stopTest();

        Assert.areEqual(4, tasks.size(), 'Incorrect number of tasks');
    }

    @IsTest
    static void ensureLastWeekLiteralWorksForDateLessThanOrEquals() {
        Date startOfLastWeek = GMT.today().toStartOfWeek().addDays(-7);
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = startOfLastWeek.addDays(-14)
        );
        Opportunity opp2 = new Opportunity(
            CloseDate = startOfLastWeek.addDays(-15)
        );
        Opportunity opp3 = new Opportunity(
            CloseDate = startOfLastWeek.addDays(4)
        );
        Opportunity opp4 = new Opportunity(
            CloseDate = startOfLastWeek.addDays(5)
        );
        Opportunity opp5 = new Opportunity(
            CloseDate = Gmt.today().toStartOfWeek().addMonths(1)
        );

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5 },
            true
        );
        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate <= LAST_WEEK'
        );
        Test.stopTest();
        Assert.areEqual(
            4,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureThisWeekLiteralWorksForDateTimeEquals() {
        DateTime startOfWeek = GMT.dateTime(GMT.today().toStartOfWeek());
        Task t1 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfWeek.addDays(1)
        );
        Task t2 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfWeek.addDays(2)
        );
        Task t3 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfWeek.addDays(-2)
        );
        Task t4 = (Task) Common.putReadOnlyField(
            new Task(),
            'CompletedDateTime',
            startOfWeek.addDays(-1)
        );

        MockDatabase.doInsert(new List<Task>{ t1, t2, t3, t4 }, true);

        Test.startTest();
        List<Task> tasks = MockDatabase.query(
            'SELECT Id FROM Task WHERE CompletedDateTime >= THIS_WEEK'
        );
        Test.stopTest();

        Assert.areEqual(2, tasks.size(), 'Incorrect number of tasks');
    }

    @isTest
    static void ensureThisWeekWorksForDateTimeEqualsInRange() {
        Date dayAfterStartOfWeek = GMT.today().toStartOfWeek().addDays(1);
        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = dayAfterStartOfWeek
        );

        MockDatabase.doInsert(new List<Opportunity>{ opp1 }, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = THIS_WEEK'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @IsTest
    static void ensureThisWeekLiteralWorksForDateEquals() {
        Date startOfWeek = GMT.today().toStartOfWeek();

        Opportunity opp1 = new Opportunity(
            Name = 'Today Opp',
            CloseDate = startOfWeek.addDays(1)
        );

        Opportunity opp2 = new Opportunity(CloseDate = startOfWeek.addDays(2));

        Opportunity opp3 = new Opportunity(CloseDate = startOfWeek.addDays(-2));

        Opportunity opp4 = new Opportunity(CloseDate = startOfWeek.addDays(-1));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate >= THIS_WEEK'
        );
        Test.stopTest();

        Assert.areEqual(
            2,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNDaysLiteralWorksForDateEquals() {
        Opportunity opp1 = new Opportunity(
            Name = 'Tomorrow Opp',
            CloseDate = GMT.today().addDays(1)
        );

        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(2));

        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(3));

        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(4));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = NEXT_N_DAYS:3'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNDaysAgoLiteralWorksForDateLessThanOrEquals() {
        Opportunity opp1 = new Opportunity(
            Name = 'Tomorrow Opp',
            CloseDate = GMT.today().addDays(1)
        );

        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(0));

        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-1));

        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate <= N_DAYS_AGO:1'
        );
        Test.stopTest();

        Assert.areEqual(
            2,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNWeeksWorksForDateLessThanOrEquals() {
        Opportunity opp1 = new Opportunity(
            Name = 'Tomorrow Opp',
            CloseDate = GMT.today().toStartOfWeek().addDays(7)
        );

        Opportunity opp2 = new Opportunity(
            CloseDate = GMT.today().toStartOfWeek().addDays(14)
        );

        Opportunity opp3 = new Opportunity(
            CloseDate = GMT.today().toStartOfWeek().addDays(21)
        );

        Opportunity opp4 = new Opportunity(
            CloseDate = GMT.today().toStartOfWeek().addDays(28)
        );

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4 },
            true
        );

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate <= NEXT_N_WEEKS:3'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastNWeeksWorksForDateGreaterThanOrEquals() {
        Opportunity opp1 = new Opportunity(
            Name = 'Tomorrow Opp',
            CloseDate = GMT.today().addDays(-1)
        );

        Opportunity opp2 = new Opportunity(CloseDate = GMT.today().addDays(-2));

        Opportunity opp3 = new Opportunity(CloseDate = GMT.today().addDays(-3));

        Opportunity opp4 = new Opportunity(CloseDate = GMT.today().addDays(-4));

        Opportunity opp5 = new Opportunity(
            CloseDate = GMT.today().addDays(-14)
        );

        Opportunity opp6 = new Opportunity(
            CloseDate = GMT.today().addDays(-15)
        );

        MockDatabase.doInsert(
            new List<Opportunity>{ opp1, opp2, opp3, opp4, opp5, opp6 },
            true
        );

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate >= LAST_N_WEEKS:1'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNMonthAgoWorksForDateGreaterThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Tomorrow Opp',
            CloseDate = GMT.today().addMonths(-1)
        );

        Opportunity opp2 = new Opportunity(
            CloseDate = GMT.today().addMonths(-2)
        );

        Opportunity opp3 = new Opportunity(
            CloseDate = GMT.today().addMonths(-3)
        );

        MockDatabase.doInsert(new List<Opportunity>{ opp1, opp2, opp3 }, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate > N_MONTHS_AGO:2'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureThisQuarterInWhereWorks() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 12; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = THIS_QUARTER'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastQuarterInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 12; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = LAST_QUARTER'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextQuarterInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date today = Gmt.today();
        for (Integer i = 0; i < 12; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = today.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = NEXT_QUARTER'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNQuartersWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date today = Gmt.today();
        for (Integer i = 0; i < 12; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = today.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = NEXT_N_QUARTERS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            6,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensuresThisYearWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = THIS_YEAR'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureThisFiscalYearWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = THIS_FISCAL_YEAR'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastNFiscalYearsWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 48; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = LAST_N_FISCAL_YEARS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            24,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextFiscalYearWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = NEXT_FISCAL_YEAR'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastFiscalYearWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Gmt.startOfThisFiscalYear();
        for (Integer i = 0; i < 13; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp BACKWARDS' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );

            oppList.add(
                new Opportunity(
                    Name = 'Opp FORWARDS' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = LAST_FISCAL_YEAR'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNFiscalYearsWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Gmt.startOfThisFiscalYear();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp FORWARDS' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id FROM Opportunity WHERE CloseDate = NEXT_N_FISCAL_YEARS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            24,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNFiscalYearsAgoWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Gmt.startOfThisFiscalYear();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = N_FISCAL_YEARS_AGO:2'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );

        Datetime twoFiscalYearsAgo = Gmt.startOfThisFiscalYear().addYears(-2);
        for (Opportunity opp : opportunities) {
            Assert.isTrue(
                opp.CloseDate >= twoFiscalYearsAgo,
                'Opportunity is not from the correct fiscal year ' +
                opp.CloseDate
            );
        }
    }

    @IsTest
    static void testAliases() {
        Account a = new Account(Name = 'Test 1');
        Account b = new Account(Name = 'Test 2');
        Account c = new Account(Name = 'Test 3');
        Account d = new Account(Name = 'Test 4');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );
        MockDatabase.doInsert(con, true);

        Test.startTest();
        List<Aggregate> queriedAccts = MockDatabase.aggregateQuery(
            'SELECT Account.Name acctName, Name, COUNT(Id) FROM Contact GROUP BY Name, Account.Name'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            queriedAccts.size(),
            'Incorrect number of accounts queried'
        );
    }

    @IsTest
    static void testDuplicateAliases() {
        Account a = new Account(Name = 'Test 1');
        Account b = new Account(Name = 'Test 2');
        Account c = new Account(Name = 'Test 3');
        Account d = new Account(Name = 'Test 4');

        List<Account> acctList = new List<Account>{ a, b, c, d };
        MockDatabase.doInsert(acctList, true);

        Contact con = new Contact(
            FirstName = 'Steve',
            LastName = 'Banner',
            AccountId = a.Id
        );
        MockDatabase.doInsert(con, true);

        String exMessage;
        Test.startTest();
        try {
            MockDatabase.aggregateQuery(
                'SELECT Account.Name acctName, Name acctName, COUNT(Id) FROM Contact GROUP BY Name, Account.Name'
            );
        } catch (QueryException e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();

        Assert.isTrue(
            exMessage.contains('Duplicate alias'),
            'Expected exception message to contain \'Duplicate alias\''
        );
    }

    @IsTest
    static void testCalendarMonthIsCorrect() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_MONTH(CreatedDate) FROM Account GROUP BY Name, CALENDAR_MONTH(CreatedDate)'
        );
        Test.stopTest();
        Integer calendarMonth = GMT.today().month();
        Assert.areEqual(
            calendarMonth,
            queriedAccountAggregates[0].get('expr0'),
            'Incorrect Month'
        );
        Assert.areEqual(
            calendarMonth,
            queriedAccountAggregates[1].get('expr0'),
            'Incorrect Month'
        );
    }

    @IsTest
    static void testCalendarMonthIsCorrectWithAlias() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_MONTH(CreatedDate) month FROM Account GROUP BY Name, CALENDAR_MONTH(CreatedDate)'
        );
        Test.stopTest();
        Integer calendarMonth = GMT.today().month();
        Assert.areEqual(
            calendarMonth,
            queriedAccountAggregates[0].get('month'),
            'Incorrect Month'
        );
        Assert.areEqual(
            calendarMonth,
            queriedAccountAggregates[1].get('month'),
            'Incorrect Month'
        );
    }

    @IsTest
    static void testCalendarMonthIsCorrectWithAliasFail() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, CALENDAR_MONTH(CreatedDate) month FROM Account GROUP BY Name, month'
            );
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testCalendarMonthInWhereClause() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);
        Integer month = GMT.today().month();
        Map<String, Object> binds = new Map<String, Object>{ 'month' => month };
        Test.startTest();
        List<Account> queriedAccountAggregates = (List<Account>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Account WHERE CALENDAR_MONTH(CreatedDate) = :month',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            2,
            queriedAccountAggregates.size(),
            'Incorrect number of records returned'
        );
    }

    @IsTest
    static void testCalendarMonthInWhereClauseWithOpportunityCloseDate() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today() - 60
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Integer month = GMT.today().month();
        Map<String, Object> binds = new Map<String, Object>{ 'month' => month };
        Test.startTest();
        List<Account> queriedOpportunities = (List<Account>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE CALENDAR_MONTH(CloseDate) = :month',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedOpportunities.size(),
            'Incorrect number of records returned'
        );
    }

    @IsTest
    static void testCalendarMonthInWhereClauseWithOpportunityCloseDateLessThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today().addMonths(-2)
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Integer month = GMT.today().month();
        Map<String, Object> binds = new Map<String, Object>{ 'month' => month };
        Test.startTest();
        List<Opportunity> queriedOpportunities = (List<Opportunity>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE CALENDAR_MONTH(CloseDate) < :month',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        // When we're about to approach a new year, the month will be 1 and opp2's month will be 11,
        // so we need to check if the month is less than the current month to work out the correct assertion here
        if (opp2.CloseDate.month() < month) {
            Assert.areEqual(
                1,
                queriedOpportunities.size(),
                'Incorrect number of records returned'
            );
            Assert.areEqual(
                'Test2',
                queriedOpportunities[0].Name,
                'Incorrect record returned'
            );
        } else {
            Assert.areEqual(
                0,
                queriedOpportunities.size(),
                'Incorrect number of records returned'
            );
        }
    }

    @IsTest
    static void testCalendarMonthWeirdDateTimeException() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, CALENDAR_MONTH(CreatedDate) month FROM Account GROUP BY Name, CreatedDate'
            );
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testCalendarMonthWeirdDateException() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today()
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Aggregate> queriedOpportunityAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_MONTH(CloseDate) FROM Opportunity GROUP BY Name, CloseDate'
        );
        Test.stopTest();
        Integer calendarMonth = GMT.today().month();
        Assert.areEqual(
            calendarMonth,
            queriedOpportunityAggregates[0].get('expr0'),
            'Incorrect Month'
        );
        Assert.areEqual(
            calendarMonth,
            queriedOpportunityAggregates[1].get('expr0'),
            'Incorrect Month'
        );
    }

    /**
     * @description Ensure this date function works with Date fields
     */
    @IsTest
    static void useDateForOneRecord() {
        Opportunity opp = new Opportunity(
            Name = 'First Calendar Quarter',
            CloseDate = Date.newInstance(2024, 1, 1)
        );
        DML.doMockInsert(opp);

        Test.startTest();
        List<Opportunity> oppList = Selector.query(
            'SELECT Id, Name' +
                ' FROM Opportunity' +
                ' WHERE CALENDAR_QUARTER(CloseDate) = 1'
        );
        Test.stopTest();

        Assert.areEqual(1, oppList.size(), 'Incorrect number of opportunities');
        Assert.areEqual(
            'First Calendar Quarter',
            oppList[0].Name,
            'Incorrect opportunity'
        );
    }

    /**
     * @description Ensure this works when returning multiple opportunities
     */
    @IsTest
    static void returnMultipleUsingDates() {
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities.addAll(createOpportunitiesInCalendarQuarter(3, 1));
        opportunities.addAll(createOpportunitiesInCalendarQuarter(4, 2));
        opportunities.addAll(createOpportunitiesInCalendarQuarter(3, 3));
        opportunities.addAll(createOpportunitiesInCalendarQuarter(2, 4));
        DML.doMockInsert(opportunities);

        Test.startTest();
        List<Opportunity> queriedOpportunities = Selector.query(
            'SELECT Id, Name' +
                ' FROM Opportunity' +
                ' WHERE CALENDAR_QUARTER(CloseDate) = 2'
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedOpportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    /**
     * @description Ensure this date function works with DateTime fields
     */
    @IsTest
    static void useDateTimeForOneRecord() {
        List<Case> cases = createCasesInCalendarQuarter(1, 1);
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = Selector.query(
            'SELECT CaseNumber ' +
                ' FROM Case' +
                ' WHERE CALENDAR_QUARTER(ClosedDate) = 1'
        );
        Test.stopTest();

        Assert.areEqual(1, queriedCases.size(), 'Expected case to be queried');
    }

    @IsTest
    static void useMultipleDateTimesQuarterOne() {
        testUsingDateTimes(1);
    }

    @IsTest
    static void useMultipleDateTimesQuarterTwo() {
        testUsingDateTimes(2);
    }

    @IsTest
    static void useMultipleDateTimesQuarterThree() {
        testUsingDateTimes(3);
    }

    @IsTest
    static void useMultipleDateTimesQuarterFour() {
        testUsingDateTimes(4);
    }

    @IsTest
    static void useMultipleDatesQuarterOne() {
        testUsingDates(1);
    }

    @IsTest
    static void useMultipleDatesQuarterTwo() {
        testUsingDates(2);
    }

    @IsTest
    static void useMultipleDatesQuarterThree() {
        testUsingDates(3);
    }

    @IsTest
    static void useMultipleDatesQuarterFour() {
        testUsingDates(4);
    }

    @IsTest
    static void useInvalidCalendarQuarterWithDates() {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Opportunity> queriedOpps = queryOpportunitiesByCalendarQuarter(5);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedOpps.size(),
            'Expected no opportunities to be returned when querying by invalid calendar quarter'
        );
    }

    @IsTest
    static void useNegativeCalendarQuarterWithDates() {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Opportunity> queriedOpps = queryOpportunitiesByCalendarQuarter(
            -50
        );
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedOpps.size(),
            'Expected no opportunities to be returned when querying by invalid calendar quarter'
        );
    }

    @IsTest
    static void useInvalidCalendarQuarterWithDatetimes() {
        List<Case> cases = buildTestCases();
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = queryCasesByCalendarQuarter(5);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedCases.size(),
            'Expected no cases to be returned when querying by invalid calendar quarter'
        );
    }

    @IsTest
    static void useNegativeCalendarQuarterWithDatetimes() {
        List<Case> cases = buildTestCases();
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = queryCasesByCalendarQuarter(-50);
        Test.stopTest();
        Assert.areEqual(
            0,
            queriedCases.size(),
            'Expected no cases to be returned when querying by invalid calendar quarter'
        );
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterOne() {
        testHavingUsingDates(1);
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterTwo() {
        testHavingUsingDates(2);
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterThree() {
        testHavingUsingDates(3);
    }

    @IsTest
    static void useCalendarQuarterDateWithHavingClauseQuarterFour() {
        testHavingUsingDates(4);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedOne() {
        testHavingUsingDatesUnselected(1);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedTwo() {
        testHavingUsingDatesUnselected(2);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedThree() {
        testHavingUsingDatesUnselected(3);
    }

    @IsTest
    static void userCalendarQuarterDateWithHavingUnselectedFour() {
        testHavingUsingDatesUnselected(4);
    }

    static void testHavingUsingDatesUnselected(Integer targetCalendarQuarter) {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Aggregate> queriedOpportunities = queryOpportunitiesHavingCalendarQuarterUnselected(
            targetCalendarQuarter
        );
        Test.stopTest();
        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedOpportunities.size(),
            'Expected ' + targetRecords + ' Aggregates to be returned'
        );
    }

    static void testHavingUsingDates(Integer targetCalendarQuarter) {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Aggregate> queriedOpportunities = queryOpportunitiesHavingCalendarQuarter(
            targetCalendarQuarter
        );
        Test.stopTest();
        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedOpportunities.size(),
            'Expected ' + targetRecords + ' Aggregates to be returned'
        );
    }

    static void testUsingDates(Integer targetCalendarQuarter) {
        List<Opportunity> opps = buildTestOpportunities();
        DML.doMockInsert(opps);
        Test.startTest();
        List<Opportunity> queriedOpportunities = queryOpportunitiesByCalendarQuarter(
            targetCalendarQuarter
        );
        Test.stopTest();

        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedOpportunities.size(),
            'Expected case to be queried'
        );
    }

    static List<Opportunity> buildTestOpportunities() {
        List<Opportunity> opps = new List<Opportunity>();
        opps.addAll(
            createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(1), 1)
        );
        opps.addAll(
            createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(2), 2)
        );
        opps.addAll(
            createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(3), 3)
        );
        opps.addAll(
            createOpportunitiesInCalendarQuarter(RECORDS_BY_QUARTER.get(4), 4)
        );
        return opps;
    }

    static List<Aggregate> queryOpportunitiesHavingCalendarQuarter(
        Integer targetCalendarQuarter
    ) {
        Map<String, Object> binds = new Map<String, Object>{
            'targetCalendarQuarter' => targetCalendarQuarter
        };
        return Selector.aggregateQueryWithBinds(
            'SELECT Name, CALENDAR_QUARTER(CloseDate)' +
                ' FROM Opportunity' +
                ' GROUP BY Name, CloseDate' +
                ' HAVING CALENDAR_QUARTER(CloseDate) = :targetCalendarQuarter',
            binds,
            AccessLevel.SYSTEM_MODE
        );
    }

    static List<Aggregate> queryOpportunitiesHavingCalendarQuarterUnselected(
        Integer targetCalendarQuarter
    ) {
        Map<String, Object> binds = new Map<String, Object>{
            'targetCalendarQuarter' => targetCalendarQuarter
        };
        // the difference here is that CALENDAR_QUARTER(CloseDate) is not in the SELECT clause,
        // but this is a valid query that should return the same result, except with the CloseDate selected
        return Selector.aggregateQueryWithBinds(
            'SELECT Name, CloseDate' +
                ' FROM Opportunity' +
                ' GROUP BY Name, CloseDate' +
                ' HAVING CALENDAR_QUARTER(CloseDate) = :targetCalendarQuarter',
            binds,
            AccessLevel.SYSTEM_MODE
        );
    }

    static List<Opportunity> queryOpportunitiesByCalendarQuarter(
        Integer targetCalendarQuarter
    ) {
        Map<String, Object> binds = new Map<String, Object>{
            'targetCalendarQuarter' => targetCalendarQuarter
        };
        return Selector.queryWithBinds(
            'SELECT Id ' +
                ' FROM Opportunity' +
                ' WHERE CALENDAR_QUARTER(CloseDate) = :targetCalendarQuarter',
            binds,
            AccessLevel.SYSTEM_MODE
        );
    }

    static void testUsingDateTimes(Integer targetCalendarQuarter) {
        List<Case> cases = buildTestCases();
        DML.doMockInsert(cases);
        Test.startTest();
        List<Case> queriedCases = queryCasesByCalendarQuarter(
            targetCalendarQuarter
        );
        Test.stopTest();

        Integer targetRecords = RECORDS_BY_QUARTER.get(targetCalendarQuarter);
        Assert.areEqual(
            targetRecords,
            queriedCases.size(),
            'Expected case to be queried'
        );
    }

    static List<Case> buildTestCases() {
        List<Case> cases = new List<Case>();
        cases.addAll(
            createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(1), 1)
        );
        cases.addAll(
            createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(2), 2)
        );
        cases.addAll(
            createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(3), 3)
        );
        cases.addAll(
            createCasesInCalendarQuarter(RECORDS_BY_QUARTER.get(4), 4)
        );
        return cases;
    }

    static List<Case> queryCasesByCalendarQuarter(Integer calendarQuarter) {
        Map<String, Object> binds = new Map<String, Object>{
            'targetCalendarQuarter' => calendarQuarter
        };
        return Selector.queryWithBinds(
            'SELECT Id ' +
                ' FROM Case' +
                ' WHERE CALENDAR_QUARTER(ClosedDate) = :targetCalendarQuarter',
            binds,
            AccessLevel.SYSTEM_MODE
        );
    }

    static List<Case> createCasesInCalendarQuarter(
        Integer numberOfCases,
        Integer calendarQuarter
    ) {
        List<Integer> calendarQuarters = new List<Integer>{ 1, 2, 3, 4 };
        if (!calendarQuarters.contains(calendarQuarter)) {
            throw new IllegalArgumentException('Invalid calendar quarter');
        }
        List<Case> cases = new List<Case>();
        Integer month = calendarQuarter * 3 - 1;
        for (Integer i = 0; i < numberOfCases; i++) {
            Case newCase = (Case) Common.putReadOnlyField(
                new Case(),
                'ClosedDate',
                DateTime.newInstance(YEAR, month, DAY, 0, 0, 0)
            );
            cases.add(newCase);
        }
        return cases;
    }

    static List<Opportunity> createOpportunitiesInCalendarQuarter(
        Integer numberOfOpps,
        Integer calendarQuarter
    ) {
        List<Integer> calendarQuarters = new List<Integer>{ 1, 2, 3, 4 };
        if (!calendarQuarters.contains(calendarQuarter)) {
            throw new IllegalArgumentException('Invalid calendar quarter');
        }
        List<Opportunity> opportunities = new List<Opportunity>();
        Integer month = calendarQuarter * 3 - 1;
        for (Integer i = 0; i < numberOfOpps; i++) {
            Opportunity newOpp = new Opportunity(
                Name = 'Test Opportunity ' +
                    String.valueOf(Math.random()).left(8),
                CloseDate = Date.newInstance(YEAR, month, DAY)
            );
            opportunities.add(newOpp);
        }
        return opportunities;
    }

    @IsTest
    static void testCalendarYearIsCorrect() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_YEAR(CreatedDate) FROM Account GROUP BY Name, CALENDAR_YEAR(CreatedDate)'
        );
        Test.stopTest();
        Integer calendarYear = GMT.today().year();
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[0].get('expr0'),
            'Incorrect Year'
        );
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[1].get('expr0'),
            'Incorrect Year'
        );
    }

    @IsTest
    static void testCalendarYearIsCorrectWithAlias() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        List<Aggregate> queriedAccountAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_YEAR(CreatedDate) year FROM Account GROUP BY Name, CALENDAR_YEAR(CreatedDate)'
        );
        Test.stopTest();
        Integer calendarYear = GMT.today().year();
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[0].get('year'),
            'Incorrect Year'
        );
        Assert.areEqual(
            calendarYear,
            queriedAccountAggregates[1].get('year'),
            'Incorrect Year'
        );
    }

    @IsTest
    static void testCalendarYearIsCorrectWithAliasFail() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, CALENDAR_YEAR(CreatedDate) year FROM Account GROUP BY Name, year'
            );
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testCalendarYearInWhereClause() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);
        Integer year = GMT.today().year();
        Map<String, Object> binds = new Map<String, Object>{ 'year' => year };
        Test.startTest();
        List<Account> queriedAccountAggregates = (List<Account>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Account WHERE CALENDAR_YEAR(CreatedDate) = :year',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            2,
            queriedAccountAggregates.size(),
            'Incorrect number of records returned'
        );
    }

    @IsTest
    static void testCalendarYearInWhereClauseWithOpportunityCloseDate() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today() - 366
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Integer year = GMT.today().year();
        Map<String, Object> binds = new Map<String, Object>{ 'year' => year };
        Test.startTest();
        List<Account> queriedOpportunities = (List<Account>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE CALENDAR_YEAR(CloseDate) = :year',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedOpportunities.size(),
            'Incorrect number of records returned'
        );
    }

    @IsTest
    static void testCalendarYearInWhereClauseWithOpportunityCloseDateLessThan() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today() - 366
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Integer year = GMT.today().year();
        Map<String, Object> binds = new Map<String, Object>{ 'year' => year };
        Test.startTest();
        List<Opportunity> queriedOpportunities = (List<Opportunity>) MockDatabase.queryWithBinds(
            'SELECT Name FROM Opportunity WHERE CALENDAR_YEAR(CloseDate) < :year',
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        Assert.areEqual(
            1,
            queriedOpportunities.size(),
            'Incorrect number of records returned'
        );
        Assert.areEqual(
            'Test2',
            queriedOpportunities[0].Name,
            'Incorrect record returned'
        );
    }

    @IsTest
    static void testCalendarYearWeirdDateTimeException() {
        Account acct1 = new Account(Name = 'Test');

        Account acct2 = new Account(Name = 'Test2');

        List<Account> acctList = new List<Account>{ acct1, acct2 };
        MockDatabase.doInsert(acctList, true);

        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            MockDatabase.aggregateQuery(
                'SELECT Name, CALENDAR_YEAR(CreatedDate) year FROM Account GROUP BY Name, CreatedDate'
            );
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Exception should have been thrown');
    }

    @IsTest
    static void testCalendarYearWeirdDateException() {
        Opportunity opp1 = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test2',
            CloseDate = Gmt.today()
        );

        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Aggregate> queriedOpportunityAggregates = (List<Aggregate>) MockDatabase.aggregateQuery(
            'SELECT Name, CALENDAR_YEAR(CloseDate) FROM Opportunity GROUP BY Name, CloseDate'
        );
        Test.stopTest();
        Integer calendarMonth = GMT.today().year();
        Assert.areEqual(
            calendarMonth,
            queriedOpportunityAggregates[0].get('expr0'),
            'Incorrect Year'
        );
        Assert.areEqual(
            calendarMonth,
            queriedOpportunityAggregates[1].get('expr0'),
            'Incorrect Year'
        );
    }

    /**
     * @description This is to test using the CALENDAR_YEAR method in the HAVING clause of a query
     */
    @IsTest
    static void testCalendarYearInHavingClause() {
        Opportunity testOpp = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );
        DML.doMockInsert(testOpp);

        Test.startTest();
        List<Aggregate> ar = Selector.aggregateQuery(
            String.join(
                new List<String>{
                    'SELECT Name, CALENDAR_YEAR(CloseDate)',
                    'FROM Opportunity GROUP BY Name, CALENDAR_YEAR(CloseDate)',
                    'HAVING CALENDAR_YEAR(CloseDate) > 2010'
                },
                ' '
            )
        );
        Test.stopTest();

        Assert.areEqual(1, ar.size(), 'Incorrect number of records returned');
    }

    /**
     * @description Should still select the opportunity via the HAVING clause
     */
    @IsTest
    static void testCalendarYearInHavingClauseUnselected() {
        Opportunity testOpp = new Opportunity(
            Name = 'Test',
            CloseDate = Gmt.today()
        );
        DML.doMockInsert(testOpp);

        Test.startTest();
        List<Aggregate> ar = Selector.aggregateQuery(
            'SELECT Name, CloseDate' +
                ' FROM Opportunity GROUP BY Name, CloseDate' +
                ' HAVING CALENDAR_YEAR(CloseDate) > 2010'
        );
        Test.stopTest();

        Assert.areEqual(1, ar.size(), 'Incorrect number of records returned');
    }

    /**
     * @description Bulkified test of calendar year logic
     */
    @IsTest
    static void testCalendarYearInHavingClauseMultipleOpps() {
        List<Opportunity> oppList = new List<Opportunity>();

        // 50 opportunities, each with a close date of a year prior
        for (Integer i = 0; i < 50; i++) {
            Date closeDate = Gmt.today().addYears(-i);
            Opportunity newOpp = new Opportunity(
                Name = 'Test Opp' + i,
                CloseDate = closeDate
            );
            oppList.add(newOpp);
        }
        DML.doMockInsert(oppList);

        Test.startTest();
        Map<String, Object> binds = new Map<String, Object>{
            'year' => Gmt.today().addYears(-10).year()
        };
        List<Aggregate> ar = Selector.aggregateQueryWithBinds(
            String.join(
                new List<String>{
                    'SELECT Name, CALENDAR_YEAR(CloseDate)',
                    'FROM Opportunity GROUP BY Name, CALENDAR_YEAR(CloseDate)',
                    'HAVING CALENDAR_YEAR(CloseDate) > :year'
                },
                ' '
            ),
            binds,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        Assert.areEqual(
            10,
            ar.size(),
            'Expected 10 opportunities, but got ' + ar.size() + ' instead.'
        );
    }

    @isTest
    static void ensureNYearsAgoWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = N_YEARS_AGO:2'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLasNFiscalQuartersWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = LAST_N_FISCAL_QUARTERS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );

        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        Date startDate = startOfThisFiscalQuarter.addMonths(-6);
        for (Opportunity opp : opportunities) {
            Assert.isTrue(
                opp.CloseDate >= startDate,
                'Opportunity is not in the correct fiscal quarter'
            );
        }
    }

    @isTest
    static void ensureNextFiscalQuarterWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = NEXT_FISCAL_QUARTER'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNFiscalQuartersWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = NEXT_N_FISCAL_QUARTERS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastFiscalQuarterWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfThisFiscalQuarter.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = LAST_FISCAL_QUARTER'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureThisFiscalQuarterWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfThisFiscalQuarter.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = THIS_FISCAL_QUARTER'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastNYearsWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = LAST_N_YEARS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            24,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastYearWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = LAST_YEAR'
        );
        Test.stopTest();

        Assert.areEqual(
            12,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNYearsWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfYear = Date.newInstance(Gmt.today().year(), 1, 1);
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfYear.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = NEXT_N_YEARS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            24,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastNQuartersWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfThisFiscalQuarter.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = LAST_N_QUARTERS:2'
        );
        Test.stopTest();

        Assert.areEqual(
            6,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNQuartersAgoWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfThisFiscalQuarter = Gmt.startOfThisFiscalQuarter();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfThisFiscalQuarter.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = N_QUARTERS_AGO:2'
        );
        Test.stopTest();

        Assert.areEqual(
            3,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNWeeksAgoWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfWeek = Gmt.today().toStartOfWeek();
        for (Integer i = 0; i < 36; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfWeek.addDays(-7 * i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = N_WEEKS_AGO:3'
        );
        Test.stopTest();

        Assert.areEqual(
            1,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureNextNMonthsWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfMonth = Gmt.today().toStartOfMonth();
        for (Integer i = 0; i < 12; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfMonth.addMonths(i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = NEXT_N_MONTHS:6'
        );
        Test.stopTest();

        Assert.areEqual(
            6,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }

    @isTest
    static void ensureLastNMonthsWorksInWhereClause() {
        List<Opportunity> oppList = new List<Opportunity>();
        Date startOfMonth = Gmt.today().toStartOfMonth();
        for (Integer i = 0; i < 12; i++) {
            oppList.add(
                new Opportunity(
                    Name = 'Opp' + i,
                    CloseDate = startOfMonth.addMonths(-i)
                )
            );
        }

        MockDatabase.doInsert(oppList, true);

        Test.startTest();
        List<Opportunity> opportunities = MockDatabase.query(
            'SELECT Id, CloseDate FROM Opportunity WHERE CloseDate = LAST_N_MONTHS:6'
        );
        Test.stopTest();

        Assert.areEqual(
            6,
            opportunities.size(),
            'Incorrect number of opportunities'
        );
    }
}
