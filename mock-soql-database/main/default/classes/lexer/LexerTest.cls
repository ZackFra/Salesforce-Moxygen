@IsTest
@SuppressWarnings('PMD.NcssTypeCount, PMD.CyclomaticComplexity')
private with sharing class LexerTest {

    @IsTest
    private static void testToString() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account');
        String result = head.toString();
        Test.stopTest();
        String expectedResult = '{ id: id, nodeType: field }, { id: select, nodeType: select }, { id: account, nodeType: object }, { id: from, nodeType: from }';
        Assert.areEqual(
            expectedResult,
            result, 
            'Expected result to be "' + expectedResult + '"'
        );
    }

    // fails for the wrong reason
    @IsTest
    private static void testAggrFuncFail1() {
        String exMessage;
        Test.startTest();
        Lexer t = new Lexer();
        try {
            t.parse('SELECT SUM_DISTINCT(Amount) FROM Opportunity');
        } catch(Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();
        Assert.isNotNull(
            exMessage, 
            'Expected exception message to be not null'
        );
        Assert.isTrue(
            exMessage.startsWith('Parsing exception, expected "("'),
            'Expected exception message to start with "Parsing exception, expected "(""'
        );
    }

    @IsTest
    private static void testAggrFuncFail2() {
        String exMessage;
        Test.startTest();
        Lexer t = new Lexer();
        try {
            t.parse('SELECT C(Amount) FROM Opportunity');
        } catch(Exception e) {
            exMessage = e.getMessage();
        }
        Test.stopTest();
        Assert.isNotNull(
            exMessage, 
            'Expected exception message to be not null'
        );
        Assert.isTrue(
            exMessage.startsWith('Parsing exception, expected "from"'),
            'Expected exception message to start with "Parsing exception, expected "from""'
        );
    }

    @IsTest
    private static void testAggrFuncFail3() {
        Lexer t = new Lexer();
        Boolean isExceptionThrown = false;
        String exMessage;

        Test.startTest();
        try {
            t.parse('SELECT SUM(DISTINCT Amount) FROM Opportunity');
        } catch(Exception e) {
            exMessage = e.getMessage();
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isTrue(
            isExceptionThrown, 
            'Expected exception to be thrown'
        );
        Assert.isTrue(
            exMessage.startsWith('Parsing exception, expected ")"'),
            'Expected exception message to start with "Parsing exception, expected ")"'
        );
    }

    @IsTest
    private static void testParseBoolean() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account WHERE IsDeleted = true');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');


        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node operatorNode = whereNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node isDeletedNode = operatorNode.left;
        Assert.areEqual('isdeleted', isDeletedNode.id, 'Expected id to be "isdeleted"');
        Assert.areEqual('field', isDeletedNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(isDeletedNode.left, 'Expected left to be null');
        Assert.isNull(isDeletedNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('true', valueNode.id, 'Expected id to be "true"');
        Assert.areEqual('boolean', valueNode.nodeType, 'Expected nodeType to be "boolean"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testOrderBy() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account ORDER BY Name, Id');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to be not null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode = orderByNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node idNode2 = nameNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');
    }

    @IsTest
    private static void testLimit() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account LIMIT 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node limitNode = fromNode.right;
        Assert.areEqual('limit', limitNode.id, 'Expected id to be "limit"');
        Assert.areEqual('limit', limitNode.nodeType, 'Expected nodeType to be "limit"');
        Assert.isNotNull(limitNode.left, 'Expected left to be not null');
        Assert.isNull(limitNode.right, 'Expected right to be null');

        Node valueNode = limitNode.left;
        Assert.areEqual('10', valueNode.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testForUpdate() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account FOR UPDATE');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node forUpdateNode = fromNode.right;
        Assert.areEqual('for update', forUpdateNode.id, 'Expected id to be "for update"');
        Assert.areEqual('for update', forUpdateNode.nodeType, 'Expected nodeType to be "for update"');
        Assert.isNull(forUpdateNode.left, 'Expected left to be null');
        Assert.isNull(forUpdateNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testHavingClause() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account GROUP BY Id HAVING COUNT(Id) > 0');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');
    
        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Node idNode2 = groupByNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual('having', havingNode.id, 'Expected id to be "having"');
        Assert.areEqual('having', havingNode.nodeType, 'Expected nodeType to be "having"');
        Assert.isNotNull(havingNode.left, 'Expected left to be not null');
        Assert.isNull(havingNode.right, 'Expected right to be null');

        Node operatorNode = havingNode.left;
        Assert.areEqual('>', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node aggregateFunctionNode = operatorNode.left;
        Assert.areEqual('count', aggregateFunctionNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', aggregateFunctionNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(aggregateFunctionNode.left, 'Expected left to be null');
        Assert.isNotNull(aggregateFunctionNode.right, 'Expected right to be not null');

        Node idNode3 = aggregateFunctionNode.right;
        Assert.areEqual('id', idNode3.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode3.left, 'Expected left to be null');
        Assert.isNull(idNode3.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('0', valueNode.id, 'Expected id to be "0"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testAggrFuncs() {
        List<String> aggrFuncs = new List<String> {
            'avg',
            'count',
            'count_distinct',
            'min',
            'max',
            'sum'
        };
        List<Map<String, Object>> nodes = new List<Map<String, Object>>();
        Test.startTest();
        for(String func : aggrFuncs) {
            Lexer t = new Lexer();
            Node head = t.parse('SELECT ' + func + '(Amount) FROM Opportunity');
            Map<String, Object> nodeDatum = new Map<String, Object> {
                'head' => head,
                'func' => func
            };
            nodes.add(nodeDatum);
        }
        Test.stopTest();


        for(Map<String, Object> nodeData : nodes) { 
            Node head = (Node) nodeData.get('head');
            String func = (String) nodeData.get('func');

            // we expect this to come back in a particular order
            Assert.areEqual('select', head.id, 'Expected id to be "select"');
            Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
            Assert.isNotNull(head.left, 'Expected left to be not null');
            Assert.isNotNull(head.right, 'Expected right to be not null');
    
            Node sumNode = head.left;
            Assert.areEqual(func, sumNode.id, 'Expected id to be "' + func + '"');
            Assert.areEqual('aggregate function', sumNode.nodeType, 'Expected nodeType to be "aggregate function"');
            Assert.isNull(sumNode.left, 'Expected left to be null');
            Assert.isNotNull(sumNode.right, 'Expected right to be not null');
    
            Node amountNode = sumNode.right;
            Assert.areEqual('amount', amountNode.id, 'Expected id to be "amount"');
            Assert.areEqual('field', amountNode.nodeType, 'Expected nodeType to be "field"');
            Assert.isNull(amountNode.left, 'Expected left to be null');
            Assert.isNull(amountNode.right, 'Expected right to be null');
    
            Node fromNode = head.right;
            Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
            Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
            Assert.isNotNull(fromNode.left, 'Expected left to be not null');
            Assert.isNull(fromNode.right, 'Expected right to be null');
    
            Node opportunityNode = fromNode.left;
            Assert.areEqual('opportunity', opportunityNode.id, 'Expected id to be "opportunity"');
            Assert.areEqual('object', opportunityNode.nodeType, 'Expected nodeType to be "object"');
            Assert.isNull(opportunityNode.left, 'Expected left to be null');
            Assert.isNull(opportunityNode.right, 'Expected right to be null');       
        }
    }

    @IsTest
    private static void testSelectAccount() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account');
        Test.stopTest();
        
        // we expect this to come back in a particular order
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testSelectWithWhereClause() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account WHERE Name = \'Test\'');
        Test.stopTest();
        
        // we expect this to come back in a particular order
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node operatorNode = whereNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node nameNode = operatorNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "name"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "value"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "value"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testMixedFieldsSubQueries() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id, (SELECT Id FROM Contacts), Name FROM Account');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node subQueryNode = idNode.left;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNotNull(subQueryNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node subQuerySelectNode = subQueryNode.right;
        Assert.areEqual('select', subQuerySelectNode.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode.right, 'Expected right to not be null');

        Node subQueryIdNode = subQuerySelectNode.left;
        Assert.areEqual('id', subQueryIdNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', subQueryIdNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryIdNode.left, 'Expected left to be null');
        Assert.isNull(subQueryIdNode.right, 'Expected right to be null');

        Node subQueryFromNode = subQuerySelectNode.right;
        Assert.areEqual('from', subQueryFromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode.left, 'Expected left to not be null');
        Assert.isNull(subQueryFromNode.right, 'Expected right to be null');

        Node subQueryContactNode = subQueryFromNode.left;
        Assert.areEqual('contacts', subQueryContactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', subQueryContactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryContactNode.left, 'Expected left to be null');
        Assert.isNull(subQueryContactNode.right, 'Expected right to be null');

        Node nameNode = subQueryNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testSubQueryWithSubQueryFirst() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT (SELECT Id FROM Contacts), Id FROM Account');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node subQueryNode = head.left;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNotNull(subQueryNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node subQuerySelectNode = subQueryNode.right;
        Assert.areEqual('select', subQuerySelectNode.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode.right, 'Expected right to not be null');

        Node subQueryIdNode = subQuerySelectNode.left;
        Assert.areEqual('id', subQueryIdNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', subQueryIdNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryIdNode.left, 'Expected left to be null');
        Assert.isNull(subQueryIdNode.right, 'Expected right to be null');

        Node subQueryFromNode = subQuerySelectNode.right;
        Assert.areEqual('from', subQueryFromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode.left, 'Expected left to not be null');
        Assert.isNull(subQueryFromNode.right, 'Expected right to be null');

        Node subQueryContactNode = subQueryFromNode.left;
        Assert.areEqual('contacts', subQueryContactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', subQueryContactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryContactNode.left, 'Expected left to be null');
        Assert.isNull(subQueryContactNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testSubQueryWithSubQuerySecond() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id, (SELECT Id FROM Contacts) FROM Account');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node subQueryNode = idNode.left;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNull(subQueryNode.left, 'Expected left to be null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node subQuerySelectNode = subQueryNode.right;
        Assert.areEqual('select', subQuerySelectNode.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode.right, 'Expected right to not be null');

        Node subQueryIdNode = subQuerySelectNode.left;
        Assert.areEqual('id', subQueryIdNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', subQueryIdNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryIdNode.left, 'Expected left to be null');
        Assert.isNull(subQueryIdNode.right, 'Expected right to be null');

        Node subQueryFromNode = subQuerySelectNode.right;
        Assert.areEqual('from', subQueryFromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode.left, 'Expected left to not be null');
        Assert.isNull(subQueryFromNode.right, 'Expected right to be null');

        Node subQueryContactNode = subQueryFromNode.left;
        Assert.areEqual('contacts', subQueryContactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', subQueryContactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryContactNode.left, 'Expected left to be null');
        Assert.isNull(subQueryContactNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testMultipleSubQueries() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id, (SELECT Id FROM Contacts), (SELECT Id FROM Opportunities) FROM Account');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node subQueryNode = idNode.left;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNotNull(subQueryNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node subQuerySelectNode = subQueryNode.right;
        Assert.areEqual('select', subQuerySelectNode.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode.right, 'Expected right to not be null');

        Node subQueryIdNode = subQuerySelectNode.left;
        Assert.areEqual('id', subQueryIdNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', subQueryIdNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryIdNode.left, 'Expected left to be null');
        Assert.isNull(subQueryIdNode.right, 'Expected right to be null');

        Node subQueryFromNode = subQuerySelectNode.right;
        Assert.areEqual('from', subQueryFromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode.left, 'Expected left to not be null');
        Assert.isNull(subQueryFromNode.right, 'Expected right to be null');

        Node subQueryContactNode = subQueryFromNode.left;
        Assert.areEqual('contacts', subQueryContactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', subQueryContactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryContactNode.left, 'Expected left to be null');
        Assert.isNull(subQueryContactNode.right, 'Expected right to be null');

        Node subQueryNode2 = subQueryNode.left;
        Assert.areEqual('subquery', subQueryNode2.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode2.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNull(subQueryNode2.left, 'Expected left to be null');
        Assert.isNotNull(subQueryNode2.right, 'Expected right to not be null');

        Node subQuerySelectNode2 = subQueryNode2.right;
        Assert.areEqual('select', subQuerySelectNode2.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode2.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode2.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode2.right, 'Expected right to not be null');

        Node subQueryIdNode2 = subQuerySelectNode2.left;
        Assert.areEqual('id', subQueryIdNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', subQueryIdNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryIdNode2.left, 'Expected left to be null');
        Assert.isNull(subQueryIdNode2.right, 'Expected right to be null');

        Node subQueryFromNode2 = subQuerySelectNode2.right;
        Assert.areEqual('from', subQueryFromNode2.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode2.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode2.left, 'Expected left to not be null');
        Assert.isNull(subQueryFromNode2.right, 'Expected right to be null');

        Node subQueryOpportunityNode = subQueryFromNode2.left;
        Assert.areEqual('opportunities', subQueryOpportunityNode.id, 'Expected id to be "opportunities"');
        Assert.areEqual('object', subQueryOpportunityNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryOpportunityNode.left, 'Expected left to be null');
        Assert.isNull(subQueryOpportunityNode.right, 'Expected right to be null');

    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testSubQueryWithQueryInWhereClause() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Contact)');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node operatorNode = whereNode.left;
        Assert.areEqual('in', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node idNode2 = operatorNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node subQueryNode = operatorNode.right;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNull(subQueryNode.left, 'Expected left to be null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node subQuerySelectNode = subQueryNode.right;
        Assert.areEqual('select', subQuerySelectNode.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode.right, 'Expected right to not be null');

        Node subQueryAccountIdNode = subQuerySelectNode.left;
        Assert.areEqual('accountid', subQueryAccountIdNode.id, 'Expected id to be "accountid"');
        Assert.areEqual('field', subQueryAccountIdNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryAccountIdNode.left, 'Expected left to be null');
        Assert.isNull(subQueryAccountIdNode.right, 'Expected right to be null');

        Node subQueryFromNode = subQuerySelectNode.right;
        Assert.areEqual('from', subQueryFromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode.left, 'Expected left to not be null');
        Assert.isNull(subQueryFromNode.right, 'Expected right to be null');

        Node subQueryContactNode = subQueryFromNode.left;
        Assert.areEqual('contact', subQueryContactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', subQueryContactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryContactNode.left, 'Expected left to be null');
        Assert.isNull(subQueryContactNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testSubQueryWithQueryInWhereClause2() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Name = \'Test\')');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node operatorNode = whereNode.left;
        Assert.areEqual('in', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node idNode2 = operatorNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node subQueryNode = operatorNode.right;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNull(subQueryNode.left, 'Expected left to be null');

        Node subQuerySelectNode = subQueryNode.right;
        Assert.areEqual('select', subQuerySelectNode.id, 'Expected id to be "select"');
        Assert.areEqual('select', subQuerySelectNode.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(subQuerySelectNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQuerySelectNode.right, 'Expected right to not be null');

        Node subQueryAccountIdNode = subQuerySelectNode.left;
        Assert.areEqual('accountid', subQueryAccountIdNode.id, 'Expected id to be "accountid"');
        Assert.areEqual('field', subQueryAccountIdNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(subQueryAccountIdNode.left, 'Expected left to be null');
        Assert.isNull(subQueryAccountIdNode.right, 'Expected right to be null');

        Node subQueryFromNode = subQuerySelectNode.right;
        Assert.areEqual('from', subQueryFromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', subQueryFromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(subQueryFromNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQueryFromNode.right, 'Expected right to not be null');

        Node subQueryContactNode = subQueryFromNode.left;
        Assert.areEqual('contact', subQueryContactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', subQueryContactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(subQueryContactNode.left, 'Expected left to be null');

        Node subQueryWhereNode = subQueryFromNode.right;
        Assert.areEqual('where', subQueryWhereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', subQueryWhereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(subQueryWhereNode.left, 'Expected left to not be null');
        Assert.isNull(subQueryWhereNode.right, 'Expected right to be null');

        Node subQueryOperatorNode = subQueryWhereNode.left;
        Assert.areEqual('=', subQueryOperatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', subQueryOperatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(subQueryOperatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(subQueryOperatorNode.right, 'Expected right to not be null');

        Node subQueryNameNode = subQueryOperatorNode.left;
        Assert.areEqual('name', subQueryNameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', subQueryNameNode.nodeType, 'Expected nodeType to be "name"');
        Assert.isNull(subQueryNameNode.left, 'Expected left to be null');
        Assert.isNull(subQueryNameNode.right, 'Expected right to be null');

        Node subQueryValueNode = subQueryOperatorNode.right;
        Assert.areEqual('test', subQueryValueNode.id, 'Expected id to be "value"');
        Assert.areEqual('string', subQueryValueNode.nodeType, 'Expected nodeType to be "value"');
        Assert.isNull(subQueryValueNode.left, 'Expected left to be null');
        Assert.isNull(subQueryValueNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testBindVar() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account WHERE Id = :id');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node operatorNode = whereNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node idNode2 = operatorNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node bindVarNode = operatorNode.right;
        Assert.areEqual('id', bindVarNode.id, 'Expected id to be "id"');
        Assert.areEqual('bind variable', bindVarNode.nodeType, 'Expected nodeType to be "bind variable"');
        Assert.isNull(bindVarNode.left, 'Expected left to be null');
        Assert.isNull(bindVarNode.right, 'Expected right to be null');

    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testAndStatements() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' AND LastName = \'test2\' AND Account.Name = \'testAcct\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node andNode = whereNode.left;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode = andNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode2 = andNode.right;
        Assert.areEqual('and', andNode2.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode2.left, 'Expected left to not be null');
        Assert.isNotNull(andNode2.right, 'Expected right to not be null');

        Node operatorNode2 = andNode2.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode2.right;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testQueryWithOrAnd() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' OR LastName = \'test2\' AND Account.Name = \'testAcct\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node orNode = whereNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node operatorNode = orNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode = orNode.right;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode2 = andNode.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode.right;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');

        
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testNot() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Contact WHERE NOT FirstName = \'test\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node notNode = whereNode.left;
        Assert.areEqual('not', notNode.id, 'Expected id to be "not"');
        Assert.areEqual('not', notNode.nodeType, 'Expected nodeType to be "not"');
        Assert.isNotNull(notNode.left, 'Expected left to be not null');
        Assert.isNull(notNode.right, 'Expected right to be null');

        Node operatorNode = notNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testCorrectsForAndWithOr() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' OR LastName = \'test2\' AND Account.Name = \'testAcct\' OR Account.Name = \'testAcct2\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node orNode = whereNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node orNode2 = orNode.left;
        Assert.areEqual('or', orNode2.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode2.left, 'Expected left to not be null');
        Assert.isNotNull(orNode2.right, 'Expected right to not be null');

        Node operatorNode = orNode2.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode = orNode2.right;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode2 = andNode.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode.right;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');

        Node operatorNode4 = orNode.right;
        Assert.areEqual('=', operatorNode4.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode4.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode4.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode4.right, 'Expected right to not be null');

        Node accountNameNode2 = operatorNode4.left;
        Assert.areEqual('account.name', accountNameNode2.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode2.left, 'Expected left to be null');
        Assert.isNull(accountNameNode2.right, 'Expected right to be null');

        Node valueNode4 = operatorNode4.right;
        Assert.areEqual('testacct2', valueNode4.id, 'Expected id to be "testacct2"');
        Assert.areEqual('string', valueNode4.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode4.left, 'Expected left to be null');
        Assert.isNull(valueNode4.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testCorrectsForAndWithOrWithSubExpr() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' AND LastName = \'test2\' OR (Account.Name = \'testAcct\' AND Account.Name = \'testAcct2\' OR Account.Name = \'testAcct3\')');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node orNode = whereNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node andNode = orNode.left;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode = andNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node operatorNode2 = andNode.right;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node subExprNode2 = orNode.right;
        Assert.areEqual('conditional subexpression', subExprNode2.id, 'Expected id to be "conditional subexpression"');
        Assert.areEqual('conditional subexpression', subExprNode2.nodeType, 'Expected nodeType to be "conditional subexpression"');
        Assert.isNotNull(subExprNode2.left, 'Expected left to not be null');
        Assert.isNull(subExprNode2.right, 'Expected right to be null');

        Node orNode2 = subExprNode2.left;
        Assert.areEqual('or', orNode2.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode2.left, 'Expected left to not be null');
        Assert.isNotNull(orNode2.right, 'Expected right to not be null');

        Node andNode2 = orNode2.left;
        Assert.areEqual('and', andNode2.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode2.left, 'Expected left to not be null');
        Assert.isNotNull(andNode2.right, 'Expected right to not be null');

        Node operatorNode3 = andNode2.left;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');

        Node operatorNode4 = andNode2.right;
        Assert.areEqual('=', operatorNode4.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode4.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode4.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode4.right, 'Expected right to not be null');

        Node accountNameNode2 = operatorNode4.left;
        Assert.areEqual('account.name', accountNameNode2.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode2.left, 'Expected left to be null');
        Assert.isNull(accountNameNode2.right, 'Expected right to be null');

        Node valueNode4 = operatorNode4.right;
        Assert.areEqual('testacct2', valueNode4.id, 'Expected id to be "testacct2"');
        Assert.areEqual('string', valueNode4.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode4.left, 'Expected left to be null');
        Assert.isNull(valueNode4.right, 'Expected right to be null');

        Node operatorNode5 = orNode2.right;
        Assert.areEqual('=', operatorNode5.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode5.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode5.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode5.right, 'Expected right to not be null');

        Node accountNameNode3 = operatorNode5.left;
        Assert.areEqual('account.name', accountNameNode3.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode3.left, 'Expected left to be null');
        Assert.isNull(accountNameNode3.right, 'Expected right to be null');

        Node valueNode5 = operatorNode5.right;
        Assert.areEqual('testacct3', valueNode5.id, 'Expected id to be "testacct3"');
        Assert.areEqual('string', valueNode5.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode5.left, 'Expected left to be null');
        Assert.isNull(valueNode5.right, 'Expected right to be null');

    }

    @IsTest
    private static void testAlias() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT COUNT(Id) Cnt1 FROM Account GROUP BY Id');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node countNode = head.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node aliasNode = idNode.left;
        Assert.areEqual('Cnt1', aliasNode.id, 'Expected id to be "Cnt1"');
        Assert.areEqual('alias', aliasNode.nodeType, 'Expected nodeType to be "alias"');
        Assert.isNull(aliasNode.left, 'Expected left to be null');
        Assert.isNull(aliasNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual(accountNode.id, 'account', 'Expected id to be "account"');
        Assert.areEqual(accountNode.nodeType, 'object', 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNull(groupByNode.right, 'Expected right to be null');

        Node idNode2 = groupByNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testParseValueList() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName IN (\'test\', \'test2\')');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual(idNode.id, 'id', 'Expected id to be "id"');
        Assert.areEqual(idNode.nodeType, 'field', 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node inNode = whereNode.left;
        Assert.areEqual('in', inNode.id, 'Expected id to be "in"');
        Assert.areEqual('operator', inNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(inNode.left, 'Expected left to not be null');
        Assert.isNotNull(inNode.right, 'Expected right to not be null');

        Node firstNameNode = inNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueListNode = inNode.right;
        Assert.areEqual('value list', valueListNode.id, 'Expected id to be "value list"');
        Assert.areEqual('value list', valueListNode.nodeType, 'Expected nodeType to be "value list"');
        Assert.isNotNull(valueListNode.left, 'Expected left to not be null');
        Assert.isNull(valueListNode.right, 'Expected right to be null');

        Node valueNode = valueListNode.left;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNotNull(valueNode.left, 'Expected left to not be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node valueListNode2 = valueNode.left;
        Assert.areEqual('value list', valueListNode2.id, 'Expected id to be "value list"');
        Assert.areEqual('value list', valueListNode2.nodeType, 'Expected nodeType to be "value list"');
        Assert.isNotNull(valueListNode2.left, 'Expected left to not be null');
        Assert.isNull(valueListNode2.right, 'Expected right to be null');

        Node valueNode2 = valueListNode2.left;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');
    }

    @IsTest
    private static void testSingularCount() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT COUNT() FROM Account');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node countNode = head.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNull(countNode.right, 'Expected right to be null');
 
        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testSimpleAlias() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id id FROM Account');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNotNull(idNode.right, 'Expected right to not be null');

        Node idAliasNode = idNode.right;
        Assert.areEqual('id', idAliasNode.id, 'Expected id to be "id"');
        Assert.areEqual('alias', idAliasNode.nodeType, 'Expected nodeType to be "alias"');
        Assert.isNull(idAliasNode.left, 'Expected left to be null');
        Assert.isNull(idAliasNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testAliases() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Account.Name acctName, Name, COUNT(Id) FROM Contact GROUP BY Name, Account.Name');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node accountNameNode = head.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(accountNameNode.left, 'Expected left to not be null');
        Assert.isNotNull(accountNameNode.right, 'Expected right to not be null');

        Node acctNameNode = accountNameNode.right;
        Assert.areEqual('acctName', acctNameNode.id, 'Expected id to be "acctName"');
        Assert.areEqual('alias', acctNameNode.nodeType, 'Expected nodeType to be "alias"');
        Assert.isNull(acctNameNode.left, 'Expected left to be null');
        Assert.isNull(acctNameNode.right, 'Expected right to be null');

        Node nameNode = accountNameNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual(contactNode.id, 'contact', 'Expected id to be "contact"');
        Assert.areEqual(contactNode.nodeType, 'object', 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual(groupByNode.id, 'group by', 'Expected id to be "group by"');
        Assert.areEqual(groupByNode.nodeType, 'group by', 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNull(groupByNode.right, 'Expected right to be null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual(nameNode2.id, 'name', 'Expected id to be "name"');
        Assert.areEqual(nameNode2.nodeType, 'field', 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode2.left, 'Expected left to not be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node accountNameNode2 = nameNode2.left;
        Assert.areEqual(accountNameNode2.id, 'account.name', 'Expected id to be "account.name"');
        Assert.areEqual(accountNameNode2.nodeType, 'field', 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode2.left, 'Expected left to be null');
        Assert.isNull(accountNameNode2.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testSubQueryNoAlias() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node nameNode = idNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node subQueryNode = nameNode.left;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNull(subQueryNode.left, 'Expected left to be not null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node selectNode2 = subQueryNode.right;
        Assert.areEqual('select', selectNode2.id, 'Expected id to be "select"');
        Assert.areEqual('select', selectNode2.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(selectNode2.left, 'Expected left to be not null');
        Assert.isNotNull(selectNode2.right, 'Expected right to be not null');

        Node idNode2 = selectNode2.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode2.left, 'Expected left to not be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node firstNameNode = idNode2.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(firstNameNode.left, 'Expected left to not be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node lastNameNode = firstNameNode.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node fromNode = selectNode2.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node contactsNode = fromNode.left;
        Assert.areEqual('contacts', contactsNode.id, 'Expected id to be "contacts"');
        Assert.areEqual('object', contactsNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactsNode.left, 'Expected left to be null');
        Assert.isNull(contactsNode.right, 'Expected right to be null');

        Node fromNode2 = head.right;
        Assert.areEqual('from', fromNode2.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode2.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode2.left, 'Expected left to be not null');
        Assert.isNull(fromNode2.right, 'Expected right to be null');

        Node accountNode = fromNode2.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testHavingClauseWithMultipleConditions() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Name, COUNT(Id) FROM Account GROUP BY Name HAVING COUNT(Id) > 1 AND COUNT(Id) < 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to be not null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual('having', havingNode.id, 'Expected id to be "having"');
        Assert.areEqual('having', havingNode.nodeType, 'Expected nodeType to be "having"');
        Assert.isNotNull(havingNode.left, 'Expected left to be not null');
        Assert.isNull(havingNode.right, 'Expected right to be null');

        Node andNode = havingNode.left;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode = andNode.left;
        Assert.areEqual('>', operatorNode.id, 'Expected id to be ">"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node countNode2 = operatorNode.left;
        Assert.areEqual('count', countNode2.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode2.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode2.left, 'Expected left to be null');
        Assert.isNotNull(countNode2.right, 'Expected right to not be null');

        Node idNode2 = countNode2.right;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('1', valueNode.id, 'Expected id to be "1"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node operatorNode2 = andNode.right;
        Assert.areEqual('<', operatorNode2.id, 'Expected id to be "<"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node countNode3 = operatorNode2.left;
        Assert.areEqual('count', countNode3.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode3.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode3.left, 'Expected left to be null');
        Assert.isNotNull(countNode3.right, 'Expected right to not be null');

        Node idNode3 = countNode3.right;
        Assert.areEqual('id', idNode3.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode3.left, 'Expected left to be null');
        Assert.isNull(idNode3.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('10', valueNode2.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode2.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testHavingClauseWhereAdjust() {
        Lexer l = new Lexer();
        
        Test.startTest();
        Node head = l.parse('SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING Name = \'Test2\' OR Name = \'Test1\' AND SUM(NumberOfEmployees) > 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node sumNode = nameNode.left;
        Assert.areEqual('sum', sumNode.id, 'Expected id to be "sum"');
        Assert.areEqual('aggregate function', sumNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(sumNode.left, 'Expected left to be null');
        Assert.isNotNull(sumNode.right, 'Expected right to not be null');

        Node numberOfEmployeesNode = sumNode.right;
        Assert.areEqual('numberofemployees', numberOfEmployeesNode.id, 'Expected id to be "numberofemployees"');
        Assert.areEqual('field', numberOfEmployeesNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(numberOfEmployeesNode.left, 'Expected left to be null');
        Assert.isNull(numberOfEmployeesNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual('having', havingNode.id, 'Expected id to be "having"');
        Assert.areEqual('having', havingNode.nodeType, 'Expected nodeType to be "having"');
        Assert.isNotNull(havingNode.left, 'Expected left to not be null');
        Assert.isNull(havingNode.right, 'Expected right to be null');

        Node orNode = havingNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "or"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node operatorNode = orNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "="');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node nameNode3 = operatorNode.left;
        Assert.areEqual('name', nameNode3.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode3.left, 'Expected left to be null');
        Assert.isNull(nameNode3.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test2', valueNode.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode = orNode.right;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "and"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode2 = andNode.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "="');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node nameNode4 = operatorNode2.left;
        Assert.areEqual('name', nameNode4.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode4.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode4.left, 'Expected left to be null');
        Assert.isNull(nameNode4.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test1', valueNode2.id, 'Expected id to be "test1"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode.right;
        Assert.areEqual('>', operatorNode3.id, 'Expected id to be ">"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node sumNode2 = operatorNode3.left;
        Assert.areEqual('sum', sumNode2.id, 'Expected id to be "sum"');
        Assert.areEqual('aggregate function', sumNode2.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(sumNode2.left, 'Expected left to be null');
        Assert.isNotNull(sumNode2.right, 'Expected right to not be null');

        Node numberOfEmployeesNode2 = sumNode2.right;
        Assert.areEqual('numberofemployees', numberOfEmployeesNode2.id, 'Expected id to be "numberofemployees"');
        Assert.areEqual('field', numberOfEmployeesNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(numberOfEmployeesNode2.left, 'Expected left to be null');
        Assert.isNull(numberOfEmployeesNode2.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('10', valueNode3.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode3.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');
    }

    @IsTest
    private static void testOrderByDesc() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Name FROM Account ORDER BY Name DESC');
        Test.stopTest();
        
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to not be null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode2 = orderByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNotNull(nameNode2.right, 'Expected right to not be null');

        Node descNode = nameNode2.right;
        Assert.areEqual('desc', descNode.id, 'Expected id to be "desc"');
        Assert.areEqual('direction', descNode.nodeType, 'Expected nodeType to be "desc"');
        Assert.isNull(descNode.left, 'Expected left to be null');
        Assert.isNull(descNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testNullsFirst() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Name FROM Account ORDER BY Name NULLS FIRST');
        Test.stopTest();
        
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to not be null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode2 = orderByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNotNull(nameNode2.right, 'Expected right to not be null');

        Node nullsFirstNode = nameNode2.right;
        Assert.areEqual('nulls first', nullsFirstNode.id, 'Expected id to be "nulls first"');
        Assert.areEqual('nulls direction', nullsFirstNode.nodeType, 'Expected nodeType to be "nulls first"');
        Assert.isNull(nullsFirstNode.left, 'Expected left to be null');
        Assert.isNull(nullsFirstNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testNullsLast() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Name FROM Account ORDER BY Name NULLS LAST');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to not be null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode2 = orderByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNotNull(nameNode2.right, 'Expected right to not be null');

        Node nullsLastNode = nameNode2.right;
        Assert.areEqual('nulls last', nullsLastNode.id, 'Expected id to be "nulls last"');
        Assert.areEqual('nulls direction', nullsLastNode.nodeType, 'Expected nodeType to be "nulls last"');
        Assert.isNull(nullsLastNode.left, 'Expected left to be null');
        Assert.isNull(nullsLastNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testOffset() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Name FROM Account OFFSET 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node offsetNode = fromNode.right;
        Assert.areEqual('offset', offsetNode.id, 'Expected id to be "offset"');
        Assert.areEqual('offset', offsetNode.nodeType, 'Expected nodeType to be "offset"');
        Assert.isNotNull(offsetNode.left, 'Expected left to be null');
        Assert.isNull(offsetNode.right, 'Expected right to not be null');

        Node valueNode = offsetNode.left;
        Assert.areEqual('10', valueNode.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
        
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testTypeOf() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT TYPEOF What WHEN Account THEN Name WHEN Opportunity THEN Amount ELSE Name END FROM Event');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node typeofNode = head.left;
        Assert.areEqual('what', typeofNode.id, 'Expected id to be "what"');
        Assert.areEqual('typeof', typeofNode.nodeType, 'Expected nodeType to be "typeof"');
        Assert.isNull(typeofNode.left, 'Expected left to be null');
        Assert.isNotNull(typeofNode.right, 'Expected right to not be null');

        Node whenNode = typeofNode.right;
        Assert.areEqual('when', whenNode.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode.right, 'Expected right to not be null');

        Node accountNode = whenNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node nameNode = whenNode.right;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "when"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNotNull(nameNode.right, 'Expected right to not be null');

        Node whenNode2 = nameNode.right;
        Assert.areEqual('when', whenNode2.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode2.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode2.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode2.right, 'Expected right to not be null');


        Node opportunityNode = whenNode2.left;
        Assert.areEqual('opportunity', opportunityNode.id, 'Expected id to be "opportunity"');
        Assert.areEqual('object', opportunityNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(opportunityNode.left, 'Expected left to be null');
        Assert.isNull(opportunityNode.right, 'Expected right to be null');

        Node amountNode = whenNode2.right;
        Assert.areEqual('amount', amountNode.id, 'Expected id to be "amount"');
        Assert.areEqual('field', amountNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(amountNode.left, 'Expected left to be null');
        Assert.isNotNull(amountNode.right, 'Expected right to not be null');

        Node elseNode = amountNode.right;
        Assert.areEqual('else', elseNode.id, 'Expected id to be "else"');
        Assert.areEqual('else', elseNode.nodeType, 'Expected nodeType to be "else"');
        Assert.isNull(elseNode.left, 'Expected left to not be null');
        Assert.isNotNull(elseNode.right, 'Expected right to be null');

        Node nameNode2 = elseNode.right;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node eventNode = fromNode.left;
        Assert.areEqual('event', eventNode.id, 'Expected id to be "event"');
        Assert.areEqual('object', eventNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(eventNode.left, 'Expected left to be null');
        Assert.isNull(eventNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testTypeOfMultipleFields() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT TYPEOF What WHEN Account THEN Name, Phone WHEN Opportunity THEN Amount ELSE Name END FROM Event');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node typeofNode = head.left;
        Assert.areEqual('what', typeofNode.id, 'Expected id to be "typeof"');
        Assert.areEqual('typeof', typeofNode.nodeType, 'Expected nodeType to be "typeof"');
        Assert.isNull(typeofNode.left, 'Expected left to be null');
        Assert.isNotNull(typeofNode.right, 'Expected right to not be null');

        Node whenNode = typeofNode.right;
        Assert.areEqual('when', whenNode.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode.right, 'Expected right to not be null');

        Node accountNode = whenNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node nameNode = whenNode.right;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "when"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNotNull(nameNode.right, 'Expected right to not be null');

        Node phoneNode = nameNode.left;
        Assert.areEqual('phone', phoneNode.id, 'Expected id to be "phone"');
        Assert.areEqual('field', phoneNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(phoneNode.left, 'Expected left to be null');
        Assert.isNull(phoneNode.right, 'Expected right to be null');

        Node whenNode2 = nameNode.right;
        Assert.areEqual('when', whenNode2.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode2.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode2.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode2.right, 'Expected right to not be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node eventNode = fromNode.left;
        Assert.areEqual('event', eventNode.id, 'Expected id to be "event"');
        Assert.areEqual('object', eventNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(eventNode.left, 'Expected left to be null');
        Assert.isNull(eventNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testScope() {
        Test.startTest();
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id, Name FROM Account USING SCOPE everything');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node nameNode = idNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node usingNode = fromNode.right;
        Assert.areEqual('using scope', usingNode.id, 'Expected id to be "using"');
        Assert.areEqual('using scope', usingNode.nodeType, 'Expected nodeType to be "using"');
        Assert.isNotNull(usingNode.left, 'Expected left to not be null');
        Assert.isNull(usingNode.right, 'Expected right to be null');

        Node scopeNode = usingNode.left;
        Assert.areEqual('everything', scopeNode.id, 'Expected id to be "everything"');
        Assert.areEqual('scope', scopeNode.nodeType, 'Expected nodeType to be "scope"');
        Assert.isNull(scopeNode.left, 'Expected left to be null');
        Assert.isNull(scopeNode.right, 'Expected right to be null');

    }

    @IsTest
    static void testGroupByRollup() {
        String exMessage;
        Test.startTest();
        Lexer t = new Lexer();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account GROUP BY ROLLUP(Name)');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'GROUP BY ROLLUP is not supported by the mock SOQL parser',
            exMessage, 
            'Expected GROUP BY ROLLUP to not be supported'
        );
    }

    @IsTest
    static void testGroupByCube() {
        Lexer t = new Lexer();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account GROUP BY CUBE(Name, CreatedDate, LastModifiedDate)');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'GROUP BY CUBE is not supported by the mock SOQL parser',
            exMessage, 
            'Expected GROUP BY CUBE to not be supported'
        );

    }

    @IsTest
    static void testForView() {
        Lexer t = new Lexer();
        Test.startTest();
        Node head = t.parse('SELECT Name, COUNT(Id) FROM Account FOR VIEW');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left not to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node forViewNode = fromNode.right;
        Assert.areEqual('for view', forViewNode.id, 'Expected id to be "for view"');
        Assert.areEqual('for view', forViewNode.nodeType, 'Expected nodeType to be "for view"');
        Assert.isNull(forViewNode.left, 'Expected left to be null');
        Assert.isNull(forViewNode.right, 'Expected right to be null');

    }

    @IsTest
    static void testForReference() {
        Lexer t = new Lexer();
        Test.startTest();
        Node head = t.parse('SELECT Name, COUNT(Id) FROM Account FOR REFERENCE');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left not to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node forViewNode = fromNode.right;
        Assert.areEqual('for reference', forViewNode.id, 'Expected id to be "for reference"');
        Assert.areEqual('for reference', forViewNode.nodeType, 'Expected nodeType to be "for reference"');
        Assert.isNull(forViewNode.left, 'Expected left to be null');
        Assert.isNull(forViewNode.right, 'Expected right to be null');
    }

    @IsTest
    static void testUpdateTrackingExpectError() {
        Lexer t = new Lexer();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account UPDATE TRACKING');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'UPDATE TRACKING is not supported by the mock SOQL parser',
            exMessage, 
            'Expected UPDATE TRACKING to not be supported'
        );
    }

    @IsTest
    static void testUpdateViewStatExpectError() {
        Lexer t = new Lexer();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account UPDATE VIEWSTAT');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'UPDATE VIEWSTAT is not supported by the mock SOQL parser',
            exMessage, 
            'Expected UPDATE VIEWSTAT to not be supported'
        );
    }

    @IsTest
    static void testWithDataCategoryExpectError() {
        Lexer t = new Lexer();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Title FROM KnowledgeArticleVersion WHERE PublishStatus=\'online\' WITH DATA CATEGORY Geography__c ABOVE usa__c');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'WITH [DATA CATEGORY] is not supported by the mock SOQL parser',
            exMessage, 
            'Expected WITH DATA CATEGORY to not be supported'
        );
    }
}