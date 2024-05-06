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
private class SelectorBacktickReplacementTests {
    @IsTest
    static void testQuery() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT Name FROM Account WHERE Name = `Test`';
        Test.startTest();
        List<Account> acctList = Selector.query(query);
        Test.stopTest();
        Account queriedAcct = acctList[0];
        Assert.areEqual(
            'Test',
            queriedAcct.Name,
            'Account Name should be Test'
        );
    }

    @IsTest
    static void testQueryWithAccessLevel() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT Name FROM Account WHERE Name = `Test`';
        Test.startTest();
        List<Account> acctList = Selector.query(query, AccessLevel.SYSTEM_MODE);
        Test.stopTest();
        Account queriedAcct = acctList[0];
        Assert.areEqual(
            'Test',
            queriedAcct.Name,
            'Account Name should be Test'
        );        
    }

    @IsTest
    static void testQueryWithBinds() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);

        // worthless bind, not what we're testing here, but needed for queryWithBinds
        Map<String, Object> binds = new Map<String, Object>{
            'name' => 'Test12342132'
        };
        String query = 'SELECT Name FROM Account WHERE Name = `Test` OR Name = :name';
        Test.startTest();
        List<Account> acctList = Selector.queryWithBinds(query, binds, AccessLevel.SYSTEM_MODE);
        Test.stopTest();
        Account queriedAcct = acctList[0];
        Assert.areEqual(
            'Test',
            queriedAcct.Name,
            'Account Name should be Test'
        );          
    }

    @IsTest
    static void testAggregateQuery() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT COUNT(Id) FROM Account WHERE Name = `Test` GROUP BY Name';
        Test.startTest();
        List<Aggregate> aggregates = Selector.aggregateQuery(query);
        Test.stopTest();
        Aggregate aggregate = aggregates[0];
        Integer count = (Integer) aggregate.get('expr0');
        Assert.areEqual(
            1,
            count,
            'Count should be 1'
        );
    }

    @IsTest
    static void testAggregateQueryWithAccessLevel() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT COUNT(Id) FROM Account WHERE Name = `Test` GROUP BY Name';
        Test.startTest();
        List<Aggregate> aggregates = Selector.aggregateQuery(query, AccessLevel.SYSTEM_MODE);
        Test.stopTest();
        Aggregate aggregate = aggregates[0];
        Integer count = (Integer) aggregate.get('expr0');
        Assert.areEqual(
            1,
            count,
            'Count should be 1'
        );
    }

    @IsTest
    static void testAggregateQueryWithBinds() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        Map<String, Object> binds = new Map<String, Object> {
            'name' => 'Test12312321'
        };
        String query = 'SELECT COUNT(Id) FROM Account WHERE Name = `Test` or Name = :name GROUP BY Name';
        Test.startTest();
        List<Aggregate> aggregates = Selector.aggregateQueryWithBinds(query, binds, AccessLevel.SYSTEM_MODE);
        Test.stopTest();
        Aggregate aggregate = aggregates[0];
        Integer count = (Integer) aggregate.get('expr0');
        Assert.areEqual(
            1,
            count,
            'Count should be 1'
        );        
    }

    @IsTest
    static void testCountQuery() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT COUNT() FROM Account WHERE Name = `Test`';
        Test.startTest();
        Integer cnt = Selector.countQuery(query);
        Test.stopTest();

        Assert.areEqual(
            1,
            cnt,
            'Count should be 1'
        );
    }

    @IsTest
    static void testCountQueryWithAccessLevel() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT COUNT() FROM Account WHERE Name = `Test`';
        Test.startTest();
        Integer cnt = Selector.countQuery(query, AccessLevel.SYSTEM_MODE);
        Test.stopTest();
        Assert.areEqual(
            1,
            cnt,
            'Count should be 1'
        );        
    }

    @IsTest
    static void testCountQueryWithBinds() {
        Account acct = new Account(
            Name = 'Test'
        );
        DML.doInsert(acct, true);
        String query = 'SELECT COUNT() FROM Account WHERE Name = `Test`';
        Map<String, Object> binds = new Map<String, Object> {
            'name' => 'Test12312321'
        };
        Test.startTest();
        Integer cnt = Selector.countQueryWithBinds(query, binds, AccessLevel.SYSTEM_MODE);
        Test.stopTest();
        Assert.areEqual(
            1,
            cnt,
            'Count should be 1'
        );        
    }
}