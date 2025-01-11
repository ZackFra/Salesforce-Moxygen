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
private class MockDatabaseAliasTest {
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
}
