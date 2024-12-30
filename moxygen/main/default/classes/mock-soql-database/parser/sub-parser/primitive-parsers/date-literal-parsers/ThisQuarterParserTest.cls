@isTest
private class ThisQuarterParserTest {
    @isTest
    static void ensureThisQuarterCanBeParsed() {
        DateLiteralParser parser = new ThisQuarterParser();
        Intermediary intermediary = parser.parse('THIS_QUARTER');
        Assert.areEqual(Token.THIS_QUARTER_LITERAL, intermediary.head.id, 'Id should be THIS_QUARTER_LITERAL');
        Assert.areEqual(NodeType.DATE_LITERAL, intermediary.head.nodeType, 'Value should be THIS_QUARTER_LITERAL');
        Assert.isNull(intermediary.head.left, 'Left should be null');
        Assert.isNull(intermediary.head.right, 'Right should be null');
        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
    }
}