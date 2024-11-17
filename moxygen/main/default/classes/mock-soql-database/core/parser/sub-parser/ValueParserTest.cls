@isTest
private class ValueParserTest {
    @IsTest 
    static void ensureValueParserParsesYesterday() {
        ValueParser vp = new ValueParser();
        Test.startTest();
        Intermediary result = vp.parse('YESTERDAY');
        Test.stopTest();
        Node head = result.head;
        Assert.areEqual(Token.YESTERDAY_LITERAL, head.id, 'Expected ' + Token.YESTERDAY_LITERAL + ' but got ' + result.head.id);
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Expected ' + NodeType.DATE_LITERAL + ' but got ' + result.head.nodeType);
        Assert.isNull(head.left, 'Expected null but got ' + head.left);
        Assert.isNull(head.right, 'Expected null but got ' + head.right);
        Assert.areEqual('', result.subquery, 'Expected empty string but got ' + result.subquery);
    }

    @IsTest
    static void ensureValueParserParsesToday() {
        ValueParser vp = new ValueParser();
        Test.startTest();
        Intermediary result = vp.parse('TODAY');
        Test.stopTest();
        Node head = result.head;
        Assert.areEqual(Token.TODAY_LITERAL, head.id, 'Expected ' + Token.TODAY_LITERAL + ' but got ' + result.head.id);
        Assert.areEqual(NodeType.DATE_LITERAL, head.nodeType, 'Expected ' + NodeType.DATE_LITERAL + ' but got ' + result.head.nodeType);
        Assert.isNull(head.left, 'Expected null but got ' + head.left);
        Assert.isNull(head.right, 'Expected null but got ' + head.right);
        Assert.areEqual('', result.subquery, 'Expected empty string but got ' + result.subquery);
    }

    @IsTest
    static void ensureValueParserParsesDateTimeLiteral() {
        ValueParser p = new ValueParser();
        DateTime now = GMT.now();
        String nowAsSoqlString = Common.dateTimeToSoqlString(now);
        
        Intermediary result;
        Test.startTest();
        try {
            result = p.parse(nowAsSoqlString);
        } catch(Exception e) {
            Assert.fail('Expected no exception but got ' + e.getMessage() + ' for ' + now);
        }
        Test.stopTest();
        Node head = result.head;
        Assert.areEqual(nowAsSoqlString.toLowerCase(), head.id, 'Expected ' + nowAsSoqlString + ' but got ' + head.id);
        Assert.areEqual(NodeType.XSTRING, head.nodeType, 'Expected ' + NodeType.XSTRING + ' but got ' + head.nodeType);
        Assert.isNull(head.left, 'Expected null but got ' + head.left);
        Assert.isNull(head.right, 'Expected null but got ' + head.right);

        Assert.areEqual('', result.subquery, 'Expected empty string but got ' + result.subquery);
    }

    @IsTest
    static void ensureValueParserParsesDateLiteral() {
        ValueParser p = new ValueParser();
        Date today = GMT.today();
        String nowAsSoqlString = Common.dateToSoqlString(today);

        Intermediary result;
        Test.startTest();
        try {
            result = p.parse(nowAsSoqlString);
        } catch(Exception e) {
            Assert.fail('Expected no exception but got ' + e.getMessage() + ' for ' + today);
        }
        Test.stopTest();
        Node head = result.head;
        Assert.areEqual(head.id, nowAsSoqlString, 'Expected ' + nowAsSoqlString + ' but got ' + head.id);
        Assert.areEqual(head.nodeType, NodeType.XSTRING, 'Expected ' + NodeType.XSTRING + ' but got ' + head.nodeType);
        Assert.isNull(head.left, 'Expected null but got ' + head.left);
        Assert.isNull(head.right, 'Expected null but got ' + head.right);

        Assert.areEqual('', result.subquery, 'Expected empty string but got ' + result.subquery);
    }
}