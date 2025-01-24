@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class SelectParserTest {
    @IsTest
    static void selectIdFromAccount() {
        ParserTestUtil.assertStaticResource('SELECT_0');
    }

    @IsTest
    static void selectIdNameFromAccount() {
        ParserTestUtil.assertStaticResource('SELECT_1');
    }

    @IsTest
    static void selectAccountNameFromContact() {
        ParserTestUtil.assertStaticResource('SELECT_2');
    }

    @IsTest
    static void selectContactAccountNameFromCase() {
        ParserTestUtil.assertStaticResource('SELECT_3');
    }

    @IsTest
    static void selectFirstNameLastNameNameFromContact() {
        ParserTestUtil.assertStaticResource('SELECT_4');
    }

    @IsTest
    static void mixedFieldsSubQueries() {
        ParserTestUtil.assertStaticResource('SELECT_5');
    }

    @IsTest
    static void subQueryAsFirstItemQueried() {
        ParserTestUtil.assertStaticResource('SELECT_6');
    }

    @IsTest
    static void subQueryAsSecondItemQueried() {
        ParserTestUtil.assertStaticResource('SELECT_7');
    }

    @IsTest
    static void multipleSubqueriesFromAccount() {
        ParserTestUtil.assertStaticResource('SELECT_8');
    }

    @IsTest
    static void subqueryAsThirdItemQueried() {
        ParserTestUtil.assertStaticResource('SELECT_9');
    }

    @IsTest
    static void selectTypeofWhatFromEvent() {
        ParserTestUtil.assertStaticResource('SELECT_10');
    }

    @IsTest
    static void selectTypeOfMultipleFields() {
        ParserTestUtil.assertStaticResource('SELECT_11');
    }
}
