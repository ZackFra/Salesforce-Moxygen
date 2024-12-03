@isTest
private class LastNDaysParserTest {

    @IsTest
    static void ensureLastNDaysCanBeParsed() {
        LastNDaysParser parser = new LastNDaysParser();

        String input = 'LAST_N_DAYS:5';

        Test.startTest();
        Intermediary result = parser.parse(input);
        Test.stopTest();

        String expectedOutput = input.toLowerCase();
        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(expectedOutput, head.id, 'Token should be LAST_N_DAYS_LITERAL');
    }

    @IsTest
    static void ensureSpacesDontCauseIssues() {
        LastNDaysParser parser = new LastNDaysParser();

        String input = 'LAST_N_DAYS  :  5  ';

        Test.startTest();
        Intermediary result = parser.parse(input);
        Test.stopTest();

        String expectedOutput = removeWhitespaces(input.toLowerCase());
        Node head = result.head;
        Assert.areEqual('  ', result.subquery, 'Subquery should be empty');
        Assert.areEqual(expectedOutput, head.id, 'Token should be LAST_N_DAYS_LITERAL');
    }

    @IsTest
    static void ensureNegativeValuesCannotBeParsed() {
        LastNDaysParser parser = new LastNDaysParser();

        String input = 'LAST_N_DAYS:-5 ';
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            Intermediary result = parser.parse(input);
        } catch(ValidationException e) {
            isExceptionThrown = true;
        } 
        Test.stopTest();

        Assert.isTrue(isExceptionThrown, 'Negative values should not be allowed');
    }

    static String removeWhitespaces(String str) {
        return str.replaceAll('\\s', '');
    }
}