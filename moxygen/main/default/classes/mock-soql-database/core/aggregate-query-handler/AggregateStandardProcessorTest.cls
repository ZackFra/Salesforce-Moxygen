@isTest
private class AggregateStandardProcessorTest {
    @IsTest
    static void ensureGroupByGroupsCorrectlyWithLookupFieldsWithMultParentRecords() {
        Node head = new Parser().parse(
            'SELECT Account.Name, COUNT(Id)' + 
            ' FROM Contact' +
            ' GROUP BY Account.Name' + 
            ' ORDER BY Account.Name, COUNT(Id)'
        );

        AggregateStandardProcessor processor = new AggregateStandardProcessor();
        processor.setTopLevelNodes(new TopLevelNodes(head));

        Account acct1 = new Account(Name = 'Test');
        Account acct2 = new Account(Name = 'Test');
        List<SObject> records = new List<SObject> {
            acct1, acct2
        };
        MockDatabase.doInsert(records, true);
        records.clear();
        Contact con1 = new Contact(FirstName = 'Steve', LastName = 'Banner', AccountId = acct1.Id);
        Contact con2 = new Contact(FirstName = 'Steve', LastName = 'Banner', AccountId = acct2.Id);
        records.add(con1);
        records.add(con2);
        MockDatabase.doInsert(records, true);
        records.clear();

        Test.startTest();
            processor.processRecord(con1);
            processor.processRecord(con2);
            List<ProtoAggregate> aggregates = processor.finish();
        Test.stopTest();
        Assert.areEqual(1, aggregates.size(), 'Expected 1 proto-aggregate');
    }
}