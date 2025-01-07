@isTest
private class ThisFiscalYearParserTest {

    @isTest
    static void ensureThisFiscalYearIsParseable() {
        DateLiteralParser parser = new ThisFiscalYearParser();
        Intermediary intermediary = parser.parse('THIS_FISCAL_YEAR');
        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.THIS_FISCAL_YEAR_LITERAL, intermediary.head.id, 'id should be THIS_FISCAL_YEAR');
        Assert.areEqual(NodeType.DATE_LITERAL, intermediary.head.nodeType, 'value should be THIS_FISCAL_YEAR');
        Assert.isNull(intermediary.head.left, 'left should be null');
        Assert.isNull(intermediary.head.right, 'right should be null');
    }
}