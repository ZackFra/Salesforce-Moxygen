@IsTest
private class RelationshipBuilderTest {
    @IsTest
    static void testParent() {
        MockORM db = new MockORM();
        MockDML dml = (MockDML) db.getDML();

        Account acct = new Account(Name = 'Test Account');

        dml.doMockInsert(acct);
        Account insertedAcct = (Account) db.selectRecordById(acct.Id);
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', AccountId = insertedAcct.Id);
        dml.doMockInsert(opp);
        Opportunity insertedOpp = (Opportunity) db.selectRecordById(opp.Id);

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
		
        dml.doMockInsert(acct);
        Account insertedAcct = (Account) db.selectRecordById(acct.Id);
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', AccountId = insertedAcct.Id);
        
        dml.doMockInsert(opp);
        Opportunity insertedOpp = (Opportunity) db.selectRecordById(opp.Id);

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