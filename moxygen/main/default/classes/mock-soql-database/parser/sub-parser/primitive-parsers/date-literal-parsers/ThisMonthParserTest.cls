@isTest
private class ThisMonthParserTest {

    @isTest
    static void ensureThisMonthCanBeParsed() {
        ThisMonthParser parser = new ThisMonthParser();

        Test.startTest();
        Intermediary intermediary = parser.parse(Token.THIS_MONTH_LITERAL);
        Test.stopTest();

        String subquery = intermediary.subquery;
        Node head = intermediary.head;

        Assert.areEqual('', subquery, 'Subquery should be empty');
        Assert.areEqual(Token.THIS_MONTH_LITERAL, head.id, 'Id should be THIS_MONTH_LITERAL');
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Node type should be DATE_LITERAL');
    }
}