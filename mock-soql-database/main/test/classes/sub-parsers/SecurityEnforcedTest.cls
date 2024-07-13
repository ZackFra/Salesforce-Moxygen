@IsTest
private class SecurityEnforcedTest {
    @IsTest
    static void testSpacing1() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY NameWITH SECURITY_ENFORCED');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(isExceptionThrown, 'Expected exception to be thrown');
    }

    @IsTest
    static void testSpacing2() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY Name WITHSECURITY_ENFORCED');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(isExceptionThrown, 'Expected exception to be thrown');        
    }

    @IsTest
    static void testSpacing3() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY Name WITH SECURITY_ENFORCED    ');
        } catch(Exception e) {
            isExceptionThrown = false;
        }
        Test.stopTest();
        Assert.isFalse(isExceptionThrown, 'Expected exception not to be thrown');             
    }

    @IsTest
    static void testSecurityEnforceInSubQuery() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name FROM Account WHERE Id IN (SELECT Id FROM Account WHERE Name = \'test\' WITH SECURITY_ENFORCED)');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(isExceptionThrown, 'Expected exception to be thrown');
    }

    @IsTest
    static void testSecurityEnforceInWhereClauseSubQuery() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name FROM Account WHERE Id = (SELECT Id FROM Account WHERE Name = \'test\' WITH SECURITY_ENFORCED)');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isTrue(isExceptionThrown, 'Expected exception to be thrown');
    }
}