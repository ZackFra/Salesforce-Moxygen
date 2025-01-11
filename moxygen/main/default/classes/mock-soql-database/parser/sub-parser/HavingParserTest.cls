@isTest
private class HavingParserTest {

    @isTest
    static void ensureTodayCanByParsedByHavingParser() {
        HavingParser parser = new HavingParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        intermediary = parser.parse('HAVING CreatedDate < TODAY');
        Test.stopTest();

        Assert.isNotNull(intermediary, 'Should be able to parse date literals');

    }

    @isTest
    static void ensureTomorrowCanByParsedByHavingParser() {
        HavingParser parser = new HavingParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('HAVING CreatedDate < TOMORROW');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');

    }

    @isTest
    static void ensureYesterdayCanByParsedByHavingParser() {
        HavingParser parser = new HavingParser();
        Exception ex;
        Intermediary intermediary;
        Test.startTest();
        try {
            intermediary = parser.parse('HAVING CreatedDate < YESTERDAY');
        } catch(Exception e) {
            ex = e;
        }
        Test.stopTest();

        Assert.isNull(ex, 'Should be able to parse date literals');

    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    private static void selectIdFromAccountGroupByIdHavingCountIdGreaterThan0() {
        ParserTestUtil.assertStaticResource('HAVING_0');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void havingClauseWithMultipleConditions() {
        ParserTestUtil.assertStaticResource('HAVING_1');
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    static void correctHavingClauseTreeForOrAndWhereLogic() {
        ParserTestUtil.assertStaticResource('HAVING_2');
    }
}