@isTest
private class AggregateStandardProcessorTest {
    @isTest
    static void ensureGroupByParentFieldWorksCorrectly() {
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

        List<String> groupByFields = new List<String>{ 'Account.Name' };
        AggregateStandardProcessor processor = new AggregateStandardProcessor();
        Set<ProtoAggregate> queriedAggregates = new Set<ProtoAggregate>();
        Test.startTest();
        for (Contact con : conList) {
            queriedAggregates.add(
                processor.findOrCreateGroupedAggregate(con, groupByFields)
            );
        }
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAggregates.size(),
            'Incorrect number of aggregates produced'
        );
    }

    @isTest
    static void ensureGroupedAggregateIsFindable() {
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

        List<String> groupByFields = new List<String>{ 'Account.Name' };
        AggregateStandardProcessor processor = new AggregateStandardProcessor();
        processor.createAndSaveGroupedAggregate(con1, groupByFields);
        Test.startTest();
        ProtoAggregate protoAggr = processor.findGroupedAggregate(
            con1,
            groupByFields
        );
        Test.stopTest();

        Assert.isNotNull(protoAggr, 'Grouped aggregate not found');
    }

    @isTest
    static void ensureMultipleGroupedAggregatesAreProduced() {
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

        List<String> groupByFields = new List<String>{ 'Account.Name' };
        AggregateStandardProcessor processor = new AggregateStandardProcessor();
        processor.findOrCreateGroupedAggregate(con0, groupByFields);
        processor.findOrCreateGroupedAggregate(con1, groupByFields);
        Test.startTest();
        ProtoAggregate protoAggr0 = processor.findGroupedAggregate(
            con0,
            groupByFields
        );
        ProtoAggregate protoAggr1 = processor.findGroupedAggregate(
            con1,
            groupByFields
        );
        Test.stopTest();

        Assert.areNotEqual(
            protoAggr0,
            protoAggr1,
            'Grouped aggregates are the same'
        );
    }

    @isTest
    static void ensureGroupedAggregateHasCorrectValues() {
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

        List<String> groupByFields = new List<String>{ 'Account.Name' };
        AggregateStandardProcessor processor = new AggregateStandardProcessor();

        Test.startTest();
        ProtoAggregate aggr = processor.createGroupedAggregate(
            con0,
            groupByFields
        );
        Test.stopTest();

        ComparableRecordData comparableInfo = ComparableService.getComparables(
            con0,
            'Account.Name'
        );

        Assert.areEqual(
            a.Name,
            aggr.get(comparableInfo.getComparableFieldName()),
            'Grouped aggregate has incorrect value'
        );
    }

    @isTest
    static void ensureIsGroupedAggregateForThisRecord() {
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

        List<String> groupByFields = new List<String>{ 'Account.Name' };
        AggregateStandardProcessor processor = new AggregateStandardProcessor();
        ProtoAggregate ar = processor.createGroupedAggregate(
            con1,
            groupByFields
        );
        Test.startTest();
        Boolean isGroupedAggregate = processor.isGroupedAggregateForThisRecord(
            ar,
            con1,
            groupByFields
        );
        Test.stopTest();

        Assert.isTrue(isGroupedAggregate, 'Grouped aggregate not found');
    }

    @isTest
    static void ensureIsGroupedAggregateGivenComparableInfo() {
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

        List<String> groupByFields = new List<String>{ 'Account.Name' };
        AggregateStandardProcessor processor = new AggregateStandardProcessor();
        ProtoAggregate ar = processor.createGroupedAggregate(
            con1,
            groupByFields
        );
        ComparableRecordData comparableInfo = ComparableService.getComparables(
            con1,
            'Account.Name'
        );
        Test.startTest();
        Boolean isGroupedAggregate = processor.isGroupedAggregateGivenComparableInfo(
            ar,
            comparableInfo
        );
        Test.stopTest();

        Assert.isTrue(isGroupedAggregate, 'Grouped aggregate not found');
    }
}
