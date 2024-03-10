@IsTest
public with sharing class AggregateTest {
    @IsTest
    static void testAggregate() {
        Map<String, Object> ar = new Map<String, Object> {
            'Name' => 'Test Account',
            'Type' => 'Prospect',
            'Industry' => 'Agriculture'
        };

        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            new Aggregate(ar);
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Exception was thrown');
    }
}