@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class LimitParserTest {
    @IsTest
    static void selectIdFromAccountLimit10() {
        ParserTestUtil.assertStaticResource('LIMIT_0');
    }
}
