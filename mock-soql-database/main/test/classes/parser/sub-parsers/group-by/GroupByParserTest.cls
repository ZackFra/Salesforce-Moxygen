@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class GroupByParserTest {

    @IsTest
    static void selectNameFromAccountWithAliasGroupByName() {
        ParserTestUtil.assertStaticResource('GROUP_BY_0');
    }

    @IsTest
    static void selectCountWithAliasAndGroupBy() {
        ParserTestUtil.assertStaticResource('GROUP_BY_1');
    }

    @IsTest
    static void duplicateGroupByClauses1() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id = \'test\' GROUP BY Name WITH SECURITY_ENFORCED    ');
    }

    @IsTest
    static void groupByRollupShouldFail() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT Name, COUNT(Id) FROM Account GROUP BY ROLLUP(Name)', 
            'GROUP BY ROLLUP is not supported by the mock SOQL parser'
        );
    }

    @IsTest
    static void groupByCubeShouldFail() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT Name, COUNT(Id) FROM Account GROUP BY CUBE(Name, CreatedDate, LastModifiedDate)',
            'GROUP BY CUBE is not supported by the mock SOQL parser'
        );
    }
}