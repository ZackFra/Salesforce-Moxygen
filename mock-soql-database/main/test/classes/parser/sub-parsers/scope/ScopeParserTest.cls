@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class ScopeParserTest {
    @IsTest
    static void selectIdNameFromAccountUsingScopeEverything() {
        ParserTestUtil.assertStaticResource('SCOPE_0');
    }
}