@IsTest
public with sharing class CommonTest {
    @IsTest
    private static void testNullCheck() {
        String str = null;
        Map<String, Object> args = new Map<String, Object> {
            'str' => str
        };
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            Common.nullCheck(args);
        } catch(IllegalArgumentException ex) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(isExceptionThrown, 'IllegalArgumentException should be thrown');
    }
}