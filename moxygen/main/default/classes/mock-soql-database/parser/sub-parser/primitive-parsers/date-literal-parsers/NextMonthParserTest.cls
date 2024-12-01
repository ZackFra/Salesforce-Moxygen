@isTest
private class NextMonthParserTest {

    @isTest
    static void ensureNextMonthCanBeParsed() {
        NextMonthParser parser = new NextMonthParser();

        Test.startTest();
        Intermediary result = parser.parse('NEXT_MONTH');
        Test.stopTest();

        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.NEXT_MONTH_LITERAL, head.id, 'Token should be NEXT_MONTH_LITERAL');
    }
}