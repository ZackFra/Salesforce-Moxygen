@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class WithSecurityEnforcedParserTest {
    @IsTest
    static void testSpacing1() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY NameWITH SECURITY_ENFORCED');
    }

    @IsTest
    static void testSpacing2() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY Name WITHSECURITY_ENFORCED');      
    }

    @IsTest
    static void testSpacing3() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' WITH SECURITY_ENFORCED    ');
    }

    @IsTest
    static void testSecurityEnforceInSubQuery() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Id IN (SELECT Id FROM Account WHERE Name = \'test\' WITH SECURITY_ENFORCED)');
    }

    @IsTest
    static void testSecurityEnforceInWhereClauseSubQuery() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Id = (SELECT Id FROM Account WHERE Name = \'test\' WITH SECURITY_ENFORCED)');
    }
}