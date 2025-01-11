@isTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class ForViewOrReferenceParserTest {
    @isTest
    static void selectNameFromAccountForView() {
        ParserTestUtil.assertStaticResource('FOR_VIEW_OR_REFERENCE_0');
    }

    @IsTest
    static void selectNameFromAccountForReference() {
        ParserTestUtil.assertStaticResource('FOR_VIEW_OR_REFERENCE_1');
    }
}
