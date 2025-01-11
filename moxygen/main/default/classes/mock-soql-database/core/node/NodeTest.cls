@IsTest
private class NodeTest {
    @IsTest
    static void toStringActsAsExpected() {
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Account');

        Test.startTest();
        String result = head.toString();
        Test.stopTest();

        String expectedResult = '{ id: id, nodeType: field }, { id: select, nodeType: select }, { id: account, nodeType: object }, { id: from, nodeType: from }';
        Assert.areEqual(
            expectedResult,
            result,
            'Expected result to be "' + expectedResult + '"'
        );
    }
}
