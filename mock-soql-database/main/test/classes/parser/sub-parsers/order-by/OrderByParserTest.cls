@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class OrderByParserTest {
    @IsTest
    static void selectIdFromAccountOrderByNameId() {
        ParserTestUtil.assertStaticResource('ORDER_BY_0');
    }
}