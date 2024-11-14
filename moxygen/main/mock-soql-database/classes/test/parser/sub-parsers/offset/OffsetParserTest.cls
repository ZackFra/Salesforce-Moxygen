@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class OffsetParserTest {
    @IsTest
    static void selectNameFromAccountOffset10() {
        ParserTestUtil.assertStaticResource('OFFSET_0');
    }
}