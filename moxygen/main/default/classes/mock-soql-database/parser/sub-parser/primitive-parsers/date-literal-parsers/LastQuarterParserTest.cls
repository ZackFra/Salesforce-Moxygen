@isTest
private class LastQuarterParserTest {

    @isTest
    static void ensureLastQuarterCanBeParsed() {
        LastQuarterParser parser = new LastQuarterParser();

        Test.startTest();
        Intermediary intermediary = parser.parse('LAST_QUARTER');
        Test.stopTest();

        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
        Node head = intermediary.head;
        Assert.areEqual(head.id, Token.LAST_QUARTER_LITERAL, 'Id should be LAST_QUARTER_LITERAL');
        Assert.areEqual(head.nodeType, NodeType.DATE_LITERAL, 'Node type should be DATE_LITERAL');
    }
}