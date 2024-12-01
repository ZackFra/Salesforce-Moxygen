@isTest
private class NextWeekParserTest {

    @isTest
    static void ensureNextWeekCanBeParsed() {
        NextWeekParser parser = new NextWeekParser();

        Test.startTest();
        Intermediary result = parser.parse('NEXT_WEEK');
        Test.stopTest();

        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.NEXT_WEEK_LITERAL, head.id, 'Token should be NEXT_WEEK_LITERAL');
    }
}