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

    @IsTest
    static void allNumericFuncs() {
        // AVG, MAX, MIN, SUM
        List<String> srNames = new List<String> {
            'AGGREGATE_0',
            'AGGREGATE_1',
            'AGGREGATE_2',
            'AGGREGATE_3'
        };
        ParserTestUtil.assertStaticResources(srNames);
    }

    @IsTest
    static void allCountFuncs() {
        // COUNT(), COUNT(Id), COUNT_DISTINCT(Id)
        List<String> srNames = new List<String> {
            'AGGREGATE_4',
            'AGGREGATE_5',
            'AGGREGATE_6'
        };
        ParserTestUtil.assertStaticResources(srNames);
    }


}