@isTest
private class Last90DaysParserTest {

    @isTest
    static void ensureParserCanParseLast90Days() {
        Last90DaysParser parser = new Last90DaysParser();

        Test.startTest();
        Intermediary result = parser.parse('LAST_90_DAYS');
        Test.stopTest();

        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.LAST_90_DAYS_LITERAL, head.id, 'Token should be LAST_90_DAYS_LITERAL');
    }
}