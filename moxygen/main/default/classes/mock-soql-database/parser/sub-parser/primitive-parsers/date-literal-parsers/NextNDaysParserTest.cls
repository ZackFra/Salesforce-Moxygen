@isTest
private class NextNDaysParserTest {

    @IsTest
    static void ensureNextNDaysCanBeParsed() {
        NextNDaysParser parser = new NextNDaysParser();

        String input = 'NEXT_N_DAYS:5';

        Test.startTest();
        Intermediary result = parser.parse(input);
        Test.stopTest();

        String expectedOutput = input.toLowerCase();
        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(expectedOutput, head.id, 'Token should be NEXT_N_DAYS with value 5');
    }
}