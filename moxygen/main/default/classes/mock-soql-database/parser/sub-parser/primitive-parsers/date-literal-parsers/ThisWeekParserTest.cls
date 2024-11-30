@isTest
private class ThisWeekParserTest {

    @isTest
    static void ensureThisWeekCanBeParsed() {
        ThisWeekParser parser = new ThisWeekParser();

        Test.startTest();
        Intermediary intermediary = parser.parse(Token.THIS_WEEK_LITERAL);
        Test.stopTest();

        String subquery = intermediary.subquery;
        Node head = intermediary.head;

        Assert.areEqual('', subquery, 'Subquery should be empty');
        Assert.areEqual(Token.THIS_WEEK_LITERAL, head.id, 'Id should be THIS_WEEK_LITERAL');
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Node type should be DATE_LITERAL');
    }
}