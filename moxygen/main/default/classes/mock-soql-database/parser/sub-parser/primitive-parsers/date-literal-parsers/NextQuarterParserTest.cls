@isTest
private class NextQuarterParserTest {

    @isTest
    static void ensureNextQuarterCanBeParsed() {
        NextQuarterParser parser = new NextQuarterParser();

        Test.startTest();
        Intermediary intermediary = parser.parse('NEXT_QUARTER');
        Test.stopTest();

        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
        Node head = intermediary.head;
        Assert.areEqual(head.id, Token.NEXT_QUARTER_LITERAL, 'Id should be LAST_QUARTER_LITERAL');
        Assert.areEqual(head.nodeType, NodeType.DATE_LITERAL, 'Node type should be DATE_LITERAL');
    }
}