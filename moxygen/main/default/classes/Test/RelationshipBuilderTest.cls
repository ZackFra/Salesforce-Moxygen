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
private class RelationshipBuilderTest {
    @IsTest
    static void testParent() {
        MockORM db = new MockORM();
        MockDML dml = (MockDML) db.getDML();

        Account acct = new Account(Name = 'Test Account');

        Account insertedAcct = (Account) dml.doMockInsert(acct);
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', AccountId = insertedAcct.Id);
        Opportunity insertedOpp = (Opportunity) dml.doMockInsert(opp);

        Test.startTest();
        Opportunity oppWithAcct = (Opportunity) new RelationshipBuilder()
            .relateParent()
                .setChild(insertedOpp)
                .setParent(insertedAcct)
                .setRelationshipField('AccountId')
                .setRelationshipName('Account')
                .build();
        Test.stopTest();

        Assert.areEqual(
            insertedAcct.Id,
            oppWithAcct.Account.Id, 
            'Account is not related to Opportunity'
        );
    }

    @IsTest
    static void testChild() {
        MockORM db = new MockORM();
        MockDML dml = (MockDML) db.getDML();

        Account acct = new Account(Name = 'Test Account');

        Account insertedAcct = (Account) dml.doMockInsert(acct);
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', AccountId = insertedAcct.Id);
        Opportunity insertedOpp = (Opportunity) dml.doMockInsert(opp);

        List<Opportunity> oppList = new List<Opportunity>{insertedOpp};

        Test.startTest();
        Account acctWithOpps = (Account) new RelationshipBuilder()
            .relateChildren()
                .setParent(acct)
                .setChildren(oppList)
                .setRelationshipField('AccountId')
                .setRelationshipName('Opportunities')
                .build();
        Test.stopTest();

        Assert.areEqual(
            insertedOpp.Id,
            acctWithOpps.Opportunities[0].Id, 
            'Opportunity is not related to Account'
        );
    }
}