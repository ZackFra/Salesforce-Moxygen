@isTest
private class MockAggregateQueryHandlerTest {
    @IsTest
    static void ensureProcessingAggregateQueryReturnsCorrectNumberOfResults() {
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

        Node head = new Parser()
            .parse(
                'SELECT Account.Name, COUNT(Id)' +
                    ' FROM Contact' +
                    ' GROUP BY Account.Name' +
                    ' ORDER BY Account.Name, COUNT(Id)'
            );
        MockAggregateQueryHandler aggrHandler = new MockAggregateQueryHandler();
        TopLevelNodes topLevel = new TopLevelNodes(head);
        Test.startTest();
        List<ProtoAggregate> queriedAggregates = aggrHandler.handleFilterAndGroupByNodes(
            topLevel,
            conList,
            new Map<String, Object>()
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAggregates.size(),
            'Incorrect number of aggregates produced'
        );
    }

    @IsTest
    static void ensureAggregateQueryReturnsCorrectNumberOfResults() {
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

        Node head = new Parser()
            .parse(
                'SELECT Account.Name, COUNT(Id)' +
                    ' FROM Contact' +
                    ' GROUP BY Account.Name' +
                    ' ORDER BY Account.Name, COUNT(Id)'
            );
        MockAggregateQueryHandler aggrHandler = new MockAggregateQueryHandler();
        Test.startTest();
        List<Aggregate> queriedAggregates = aggrHandler.doQuery(
            head,
            new Map<String, Object>()
        );
        Test.stopTest();

        Assert.areEqual(
            4,
            queriedAggregates.size(),
            'Incorrect number of aggregates produced'
        );
        Assert.areEqual(
            'Test1',
            queriedAggregates[0].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test2',
            queriedAggregates[1].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test3',
            queriedAggregates[2].get('Name'),
            'Incorrect order'
        );
        Assert.areEqual(
            'Test4',
            queriedAggregates[3].get('Name'),
            'Incorrect order'
        );
    }
}
