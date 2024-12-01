@isTest
private class Next90DaysParserTest {

    @isTest
    static void ensureNext90DaysCanBeParsed() {
        Next90DaysParser parser = new Next90DaysParser();

        Test.startTest();
        Intermediary result = parser.parse('NEXT_90_DAYS');
        Test.stopTest();

        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.NEXT_90_DAYS_LITERAL, head.id, 'Token should be NEXT_90_DAYS_LITERAL');
    }
}