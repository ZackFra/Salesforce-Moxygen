@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class GroupByParserTest {

    @IsTest
    static void selectNameFromAccountWithAliasGroupByName() {
        ParserTestUtil.assertStaticResource('GROUP_BY_0');
    }

    @IsTest
    static void duplicateGroupByClauses1() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY Name WITH SECURITY_ENFORCED    ');
    }
}