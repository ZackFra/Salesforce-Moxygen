@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class ValueListParserTest {
    @IsTest
    static void simpleStringValueList() {
        ParserTestUtil.assertStaticResource('VALUE_LIST_0');
    }
}