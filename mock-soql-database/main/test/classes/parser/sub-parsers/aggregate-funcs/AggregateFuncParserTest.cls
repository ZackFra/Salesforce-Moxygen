@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class AggregateFuncParserTest {
    @IsTest
    static void testAggrFuncFail1() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT SUM_DISTINCT(Amount) FROM Opportunity',
            'Parsing exception, expected "("'
        );
    }

    @IsTest
    static void testAggrFuncFail2() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT C(Amount) FROM Opportunity', 
            'Parsing exception, expected "from"'
        );
    }

    @IsTest
    static void testAggrFuncFail3() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT SUM(DISTINCT Amount) FROM Opportunity', 
            'Parsing exception, expected ")"'
        );
    }
}