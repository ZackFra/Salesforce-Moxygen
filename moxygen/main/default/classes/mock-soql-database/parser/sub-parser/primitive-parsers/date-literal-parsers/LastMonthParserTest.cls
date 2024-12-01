@isTest
private class LastMonthParserTest {

    @isTest
    static void ensureLastMonthCanBeParsed() {
        LastMonthParser parser = new LastMonthParser();

        Test.startTest();
        Intermediary result = parser.parse('LAST_MONTH');
        Test.stopTest();

        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.LAST_MONTH_LITERAL, head.id, 'Token should be LAST_MONTH_LITERAL');
    }
}