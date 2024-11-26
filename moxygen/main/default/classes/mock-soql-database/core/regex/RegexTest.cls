@isTest
private class RegexTest {
    @isTest
    static void ensureValidRegexReturnsMatch() {
        Regex regExpr = new Regex();
        String regexPattern = '^[a-zA-Z0-9]*$';
        String str = 'abc123';
        Test.startTest();
        Boolean result = regExpr.matches(str, regexPattern);
        Test.stopTest();
        Assert.isTrue(result, 'Regex did not match');
    }

    @isTest
    static void ensureInvalidStringReturnsNonMatch() {
        Regex regExpr = new Regex();
        String regexPattern = '^[a-zA-Z0-9]*$';
        String str = 'abc123!';
        Test.startTest();
        Boolean result = regExpr.matches(str, regexPattern);
        Test.stopTest();
        Assert.isFalse(result, 'Regex matched');
    }
}