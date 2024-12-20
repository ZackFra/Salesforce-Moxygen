@isTest
private class TomorrowParserTest {
    @isTest
    static void ensureTomorrowIsParsedByTheParser() {
        TomorrowParser parser = new TomorrowParser();
        Test.startTest();
        Intermediary intermediary = parser.parse(Token.TOMORROW_LITERAL);
        Test.stopTest();
        Assert.areEqual('', intermediary.subquery, 'The query should be empty');
        Assert.areEqual(Token.TOMORROW_LITERAL, intermediary.head.id, 'The node id should be TOMORROW_LITERAL');
        Assert.areEqual(NodeType.DATE_LITERAL, intermediary.head.nodeType, 'The node type should be DATE_LITERAL');
    }

    @isTest
    static void ensureParsingSomethingOtherThanTomorrowThrowsAnException() {
        TomorrowParser parser = new TomorrowParser();
        Test.startTest();
        ParsingException ex = null;
        try {
            parser.parse('TODAY');
        } catch(ParsingException e) {
            ex = e;
        }
        Test.stopTest();
        Assert.isNotNull(ex, 'An exception should be thrown');
    }
}