@IsTest
public with sharing class ParserTestUtil {

    /**
     * @description Given a static resouce name, this method will parsse and compare its query
     *              against its listed AST
     * @param srName 
     */
    public static void assertStaticResource(String srName) {
        AbstractSyntaxTreeWithQuery astWithQuery = ParserTestUtil.getAstWithQueryFor(srName);
        Test.startTest();
            Node head = ParserTestUtil.parseQuery(astWithQuery.query);
        Test.stopTest();
        ParserTestUtil.assertAstsEqual(astWithQuery.ast, head);
    }

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
        Boolean isExceptionThrown = false;
        try {
            p.parse(query);
        } catch(Exception e) {
            return e;
        }
        return null;
    }

    private static AbstractSyntaxTreeWithQuery getAstWithQueryFor(String srName) {
        StaticResource sr = [SELECT Body FROM StaticResource WHERE Name = :srName];
        String body = sr.Body.toString();
        return (AbstractSyntaxTreeWithQuery) JSON.deserialize(body, AbstractSyntaxTreeWithQuery.class);
    }

    private static Node parseQuery(String query) {
        Parser p = new Parser();
        Node head = p.parse(query);
        return head;
    }

    private static void assertAstsEqual(Node expected, Node actual) {
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

    private static String formatAssertionMessage(Node expected, Node actual, String field) {
        return (
            'Expected ' + field + ' to be equal' + '\n' + 
            'Expected nodeType : ' + expected.nodeType + ', Actual nodeType: ' + actual.nodeType + '\n' +
            'Expected id : ' + expected.id + ', Actual id: ' + actual.id + '\n' +
            'Expected Left Null : ' + (expected.left == null) + ', Actual Left Null: ' + (actual.left == null) + '\n' +
            'Expected Right Null : ' + (expected.right == null) + ', Actual Right Null: ' + (actual.right == null) + '\n'
        );
    }
}