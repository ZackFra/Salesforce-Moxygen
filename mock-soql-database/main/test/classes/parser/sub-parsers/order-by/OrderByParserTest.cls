@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class OrderByParserTest {
    @IsTest
    static void selectIdFromAccountOrderByNameId() {
        ParserTestUtil.assertStaticResource('ORDER_BY_0');
    }

    @IsTest
    static void orderByDesc() {
        ParserTestUtil.assertStaticResource('ORDER_BY_1');
    }

    @IsTest
    static void nullsFirst() {
        ParserTestUtil.assertStaticResource('ORDER_BY_2');
    }

    @IsTest
    static void nullsLast() {
        ParserTestUtil.assertStaticResource('ORDER_BY_3');
    }
}