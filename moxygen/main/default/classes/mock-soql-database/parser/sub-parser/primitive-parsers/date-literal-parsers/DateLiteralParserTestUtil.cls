@isTest
public with sharing class DateLiteralParserTestUtil {
    /**
     * @description Utility for ensuring N_DAY and N_WEEK tokens can be parsed
     * @param input 
     * @param parser 
     * @return  `Boolean`
     */
    public static Boolean ensureVariableTokenCanBeParsed(String input, DateLiteralParser parser) {
        Test.startTest();
        Intermediary result = parser.parse(input);
        Test.stopTest();

        String expectedOutput = input.toLowerCase();
        Node head = result.head;
        Assert.areEqual('', result.subquery, 'Subquery should be empty');
        Assert.areEqual(expectedOutput, head.id, 'Token should be ' + input);

        return true;
    }
}