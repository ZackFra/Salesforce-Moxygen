@IsTest
public class AggregateTest {
    
    @IsTest
    private static void testAggregate() {
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

    @IsTest
    private static void testGet() {
        Map<String, Object> ar = new Map<String, Object> {
            'Name' => 'Test Account',
            'Type' => 'Prospect',
            'Industry' => 'Agriculture'
        };

        Test.startTest();
        Aggregate a = new Aggregate(ar);
        String name = (String) a.get('Name');
        String type = (String) a.get('Type');
        String industry = (String) a.get('Industry');
        Test.stopTest();

        Assert.areEqual('Test Account', name, 'Name is not correct');
        Assert.areEqual('Prospect', type, 'Type is not correct');
        Assert.areEqual('Agriculture', industry, 'Industry is not correct');
    }
}