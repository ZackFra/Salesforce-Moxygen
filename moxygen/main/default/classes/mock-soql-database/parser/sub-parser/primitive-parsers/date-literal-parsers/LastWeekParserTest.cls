@isTest
private class LastWeekParserTest {

    @isTest
    static void ensureLastWeekCanBeParsed() {
        LastWeekParser parser = new LastWeekParser();

        Test.startTest();
        Intermediary intermediary = parser.parse('LAST_WEEK');
        Test.stopTest();

        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
        Node head = intermediary.head;
        Assert.areEqual(head.id, Token.LAST_WEEK_LITERAL, 'Id should be LAST_WEEK_LITERAL');
        Assert.areEqual(head.nodeType, NodeType.DATE_LITERAL, 'Node type should be DATE_LITERAL');
    }
}