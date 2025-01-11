@isTest
private class OrganizationSingletonTest {
    @isTest
    static void ensureGetInstanceReturnsOurOrganization() {
        Test.startTest();
        Organization org = OrganizationSingleton.getInstance();
        Test.stopTest();

        Assert.isNotNull(org, 'Organization should not be null');
    }

    @IsTest
    static void ensureOurOrganizationIsPulledFromCacheWhenRetrievedTwice() {
        Test.startTest();
        Organization org1 = OrganizationSingleton.getInstance();
        Organization org2 = OrganizationSingleton.getInstance();

        Integer numberOfSoqlQueries = Limits.getQueries();
        Test.stopTest();

        Assert.areEqual(org1, org2, 'Organization should be the same instance');

        Assert.areEqual(
            1,
            numberOfSoqlQueries,
            'Should only have queried for Organization once'
        );
    }
}
