@isTest
private class ValueListParserTest {
    @IsTest
    static void simpleStringValueList() {
        ParserTestUtil.assertStaticResource('VALUE_LIST_0');
    }

    @isTest
    static void ensureValueListCanParseListOfDateLiterals() {

        ValueListParser parser = new ValueListParser();
        Intermediary valueListIntermediary;
        Exception ex;
        Test.startTest();
        try {
            valueListIntermediary = parser.parse('YESTERDAY, TODAY, TOMORROW');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse list of date literals');
        Assert.areEqual('', valueListIntermediary.subquery, 'Subquery should be empty');

        Node head = valueListIntermediary.head;
        assertValueList(head);

        head = head.left;
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Should be of type date literal');
        Assert.areEqual(Token.YESTERDAY_LITERAL, head.id, 'Should be of type yesterday literal');

        head = head.left;
        assertValueList(head);

        head = head.left;
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Should be of type date literal');
        Assert.areEqual(Token.TODAY_LITERAL, head.id, 'Should be of type today literal');

        head = head.left;
        assertValueList(head);

        head = head.left;
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Should be of type date literal');
        Assert.areEqual(Token.TOMORROW_LITERAL, head.id, 'Should be of type tomorrow literal');

        Assert.isNull(head.left, 'Should be no more nodes');
    }

    private static void assertValueList(Node head) {
        Assert.areEqual(NodeType.VALUE_LIST, head.nodeType, 'Should be of type value list');
        Assert.areEqual(NodeType.VALUE_LIST, head.id, 'Should be of type value list');
    }
}