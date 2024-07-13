@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class WhereParserTest {
    @IsTest
    static void selectWithWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_0');
    }

    @IsTest
    static void subqueryInWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_1');
    }

    @IsTest
    static void subqueryInWhereClauseWithItsOwnWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_2');
    }

    @IsTest
    static void booleanInWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_3');
    }
}