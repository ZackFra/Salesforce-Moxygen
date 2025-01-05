@isTest
private class ThisYearParserTest {

    @isTest
    static void ensureThisYearIsParseable() {
        DateLiteralParser parser = new ThisYearParser();
        Intermediary thisYear = parser.parse('THIS_YEAR');
        Assert.areEqual('', thisYear.subquery, 'Subquery should be empty');
        Assert.areEqual(Token.THIS_YEAR_LITERAL, thisYear.head.id, 'Head should be THIS_YEAR');
        Assert.areEqual(NodeType.DATE_LITERAL, thisYear.head.nodeType, 'Head should be a date literal');
        Assert.isNull(thisYear.head.left, 'Head should not have a left child');
        Assert.isNull(thisYear.head.right, 'Head should not have a right child');
    }
}