@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class HavingParserTest {
    @IsTest
    private static void selectIdFromAccountGroupByIdHavingCountIdGreaterThan0() {
        ParserTestUtil.assertStaticResource('HAVING_0');
    }

    @IsTest
    static void havingClauseWithMultipleConditions() {
        ParserTestUtil.assertStaticResource('HAVING_1');
    }

    @IsTest
    static void correctHavingClauseTreeForOrAndWhereLogic() {
        ParserTestUtil.assertStaticResource('HAVING_2');
    }
}