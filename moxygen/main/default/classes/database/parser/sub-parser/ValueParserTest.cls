@isTest
private class ValueParserTest {
    @isTest
    static void ensureTomorrowIsParseable() {
        ValueParser parser = new ValueParser();
        Test.startTest();
        Intermediary intermediary = parser.parse(Token.TOMORROW_LITERAL);
        Test.stopTest();
        String subquery = intermediary.subquery;
        Node head = intermediary.head;
        Assert.areEqual('', subquery, 'Subquery should be empty');
        Assert.areEqual(
            Token.TOMORROW_LITERAL,
            head.id,
            'Tomorrow should be parseable'
        );
        Assert.areEqual(
            NodeType.DATE_LITERAL,
            head.nodeType,
            'Tomorrow should be of type tomorrow literal'
        );
    }

    @isTest
    static void ensureTomorrowAndAnotherTokenIsParseable() {
        ValueParser parser = new ValueParser();
        Test.startTest();
        Intermediary intermediary = parser.parse(
            Token.TOMORROW_LITERAL + ' AND Id = 1'
        );
        Test.stopTest();
        String subquery = intermediary.subquery;
        Node head = intermediary.head;
        Assert.areEqual(
            ' AND Id = 1',
            subquery,
            'Subquery should be " AND Id = 1"'
        );
        Assert.areEqual(
            Token.TOMORROW_LITERAL,
            head.id,
            'Tomorrow should be parseable'
        );
        Assert.areEqual(
            NodeType.DATE_LITERAL,
            head.nodeType,
            'Tomorrow should be of type tomorrow literal'
        );
    }

    @isTest
    static void ensureLastWeekCanBeParsed() {
        ValueParser parser = new ValueParser();
        Test.startTest();
        Intermediary intermediary = parser.parse(Token.LAST_WEEK_LITERAL);
        Test.stopTest();

        String subquery = intermediary.subquery;
        Node head = intermediary.head;

        Assert.areEqual('', subquery, 'Subquery should be empty');
        Assert.areEqual(
            Token.LAST_WEEK_LITERAL,
            head.id,
            'Id should be LAST_WEEK_LITERAL'
        );
        Assert.areEqual(
            NodeType.DATE_LITERAL,
            head.nodeType,
            'Node type should be DATE_LITERAL'
        );
    }

    @IsTest
    static void ensureThisWeekCanBeParsed() {
        ValueParser parser = new ValueParser();
        Test.startTest();
        Intermediary intermediary = parser.parse(Token.THIS_WEEK_LITERAL);
        Test.stopTest();

        String subquery = intermediary.subquery;
        Node head = intermediary.head;

        Assert.areEqual('', subquery, 'Subquery should be empty');
        Assert.areEqual(
            Token.THIS_WEEK_LITERAL,
            head.id,
            'Id should be THIS_WEEK_LITERAL'
        );
        Assert.areEqual(
            NodeType.DATE_LITERAL,
            head.nodeType,
            'Node type should be DATE_LITERAL'
        );
    }
}
