@IsTest
public with sharing class ParserTestUtil {

    /**
     * @description Assert muliple static resources align with their queries
     * @param srNames 
     */
    public static void assertStaticResources(List<String> srNames) {
        List<AbstractSyntaxTreeWithQuery> astsWithQueries = getAstsWithQueryFor(srNames);
        List<Node> headNodes = new List<Node>();
        Test.startTest();
        for(AbstractSyntaxTreeWithQuery astWithquery : astsWithQueries) {
            Node head = parseQuery(astWithQuery.query);
            headNodes.add(head);
        }
        Test.stopTest();

        for(Integer i = 0; i <  astsWithQueries.size(); i++) {
            assertAstsEqual(astsWithQueries[i].ast, headNodes[i]);
        }
    }

    /**
     * @description Given a static resouce name, this method will parsse and compare its query
     *              against its listed AST
     * @param srName 
     */
    public static void assertStaticResource(String srName) {
        AbstractSyntaxTreeWithQuery astWithQuery = getAstWithQueryFor(srName);
        Test.startTest();
            Node head = parseQuery(astWithQuery.query);
        Test.stopTest();
        assertAstsEqual(astWithQuery.ast, head);
    }

    /**
     * @description Assert that an exception is thrown with a specific message
     * @param query `String`
     * @param message `String`
     */
    public static void assertExceptionIsThrownWithMessage(String query, String message) {
        Test.startTest();
        Exception e = tryParsingQuery(query);
        Test.stopTest();
        Assert.isNotNull(
            e, 
            'Expected exception to be thrown'
        );
        Assert.isTrue(
            e.getMessage().contains(message),
            'Expected exception message to contain ' + message + ' but was ' + e.getMessage()
        );
    }

    /**
     * @description Given a query, this method will test it and check if an exception is thrown
     * @param query 
     */
    public static void assertExceptionIsThrown(String query) {
        Test.startTest();
        Exception e = tryParsingQuery(query);
        Test.stopTest();

        Assert.isNotNull(e, 'Expected exception to be thrown');
    }

    /**
     * @description Given a query, this method will test it and check if an exception is not thrown
     * @param query 
     */
    public static void assertExceptionIsNotThrown(String query) {
        Test.startTest();
        Exception e = tryParsingQuery(query);
        Test.stopTest();

        Assert.isNull(e, 'Expected exception to not be thrown');
    }

    static Exception tryParsingQuery(String query) {
        Parser p = new Parser();
        try {
            p.parse(query);
        } catch(Exception e) {
            return e;
        }
        return null;
    }

    static AbstractSyntaxTreeWithQuery getAstWithQueryFor(String srName) {
        List<AbstractSyntaxTreeWithQuery> astsWithQuery = getAstsWithQueryFor(new List<String>{srName});
        return astsWithQuery[0];
    }

    static List<AbstractSyntaxTreeWithQuery> getAstsWithQueryFor(List<String> srNames) {
        List<StaticResource> resources = [SELECT Body FROM StaticResource WHERE Name IN :srNames];
        List<AbstractSyntaxTreeWithQuery> resourceBodies = new List<AbstractSyntaxTreeWithQuery>();
        for(StaticResource resource : resources) {
            String body = resource.Body.toString();
            AbstractSyntaxTreeWithQuery astWithQuery = (AbstractSyntaxTreeWithQuery) JSON.deserialize(
                body, 
                AbstractSyntaxTreeWithQuery.class
            );
            resourceBodies.add(astWithQuery);
        }

        return resourceBodies;
    }

    static Node parseQuery(String query) {
        Parser p = new Parser();
        Node head = p.parse(query);
        return head;
    }

    static void assertAstsEqual(Node expected, Node actual) {
        if(expected == null && actual == null) {
            return;
        }

        Assert.areEqual(
            expected.nodeType, 
            actual.nodeType, 
            formatAssertionMessage(expected, actual, 'nodeType')
        );

        Assert.areEqual(
            expected.id, 
            actual.id, 
            formatAssertionMessage(expected, actual, 'id')
        );

        Assert.isTrue(
            (expected.left != null && actual.left != null) ||
            (expected.left == null && actual.left == null),
            formatAssertionMessage(expected, actual, 'left')
        );

        Assert.isTrue(
            (expected.right != null && actual.right != null) ||
            (expected.right == null && actual.right == null),
            formatAssertionMessage(expected, actual, 'right')
        );

        assertAstsEqual(expected.left, actual.left);
        assertAstsEqual(expected.right, actual.right);
    }

    static String formatAssertionMessage(Node expected, Node actual, String field) {
        return (
            'Expected ' + field + ' to be equal' + '\n' + 
            'Expected nodeType : ' + expected.nodeType + ', Actual nodeType: ' + actual.nodeType + '\n' +
            'Expected id : ' + expected.id + ', Actual id: ' + actual.id + '\n' +
            'Expected Left Null : ' + (expected.left == null) + ', Actual Left Null: ' + (actual.left == null) + '\n' +
            'Expected Right Null : ' + (expected.right == null) + ', Actual Right Null: ' + (actual.right == null) + '\n'
        );
    }
}