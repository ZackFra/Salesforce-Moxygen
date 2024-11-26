@isTest
private class TomorrowParserTest {
    @isTest
    static void ensureTomorrowIsParsedByTheParser() {
        TomorrowParser parser = new TomorrowParser();
        Test.startTest();
        Intermediary intermediary = parser.parse(Token.TOMORROW_LITERAL);
        Test.stopTest();
        Assert.areEqual('', intermediary.query, 'The query should be empty');
        Assert.areEqual(Token.TOMORROW_LITERAL, intermediary.node.id, 'The node id should be TOMORROW_LITERAL');
        Assert.areEqual(NodeType.DATE_LITERAL, intermediary.node.nodeType, 'The node type should be DATE_LITERAL');
    }
}