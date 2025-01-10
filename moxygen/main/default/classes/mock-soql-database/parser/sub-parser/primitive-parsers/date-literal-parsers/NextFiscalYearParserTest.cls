@isTest
private class NextFiscalYearParserTest {

    @isTest
    static void ensureNextFiscalYearIsParseable() {
        DateLiteralParser nextFiscalYearParser = new NextFiscalYearParser();
        Intermediary intermediary = nextFiscalYearParser.parse('NEXT_FISCAL_YEAR');

        Assert.areEqual(Token.NEXT_FISCAL_YEAR_LITERAL, intermediary.head.id, 'Should be a NEXT_FISCAL_YEAR token');
        Assert.areEqual(NodeType.DATE_LITERAL, intermediary.head.nodeType, 'Should be a DATE_LITERAL node');
        Assert.isNull(intermediary.head.left, 'Should not have a left');
        Assert.isNull(intermediary.head.right, 'Should not have a right');
        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
    }
}