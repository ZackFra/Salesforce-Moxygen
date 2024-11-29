@isTest
private class WhereParserTest {

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void selectWithWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_0');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void subqueryInWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_1');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void subqueryInWhereClauseWithItsOwnWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_2');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void booleanInWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_3');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void bindVarInWhere() {
        ParserTestUtil.assertStaticResource('WHERE_4');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void andLogicInWhere() {
        ParserTestUtil.assertStaticResource('WHERE_5');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void mixedOrWithAndLogicInWhere() {
        ParserTestUtil.assertStaticResource('WHERE_6');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void whereWithNot() {
        ParserTestUtil.assertStaticResource('WHERE_7');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void correctsTreeForOrPrecedence(){
        ParserTestUtil.assertStaticResource('WHERE_8');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void correctsSubTreeForOrPrecedence() {
        ParserTestUtil.assertStaticResource('WHERE_9');
    }

    @isTest
    static void ensureTodayCanBeParsedByWhereParser() {
        WhereParser parser = new WhereParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('WHERE CreatedDate = TODAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');
    }

    @isTest
    static void ensureYesterdayCanBeParsedByWhereParser() {
        WhereParser parser = new WhereParser();
        Exception ex;

        Test.startTest();
        try {
            parser.parse('WHERE CreatedDate = YESTERDAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');
    }

    @isTest
    static void ensureTomorrowCanBeParsedByWhereParser() {
        WhereParser parser = new WhereParser();
        Exception ex;

        Test.startTest();
        try {
            parser.parse('WHERE CreatedDate = TOMORROW');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');
    }
}