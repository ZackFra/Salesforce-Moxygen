@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class WhereParserTest {
    @IsTest
    static void selectWithWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_0');
    }

    @IsTest
    static void subqueryInWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_1');
    }

    @IsTest
    static void subqueryInWhereClauseWithItsOwnWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_2');
    }

    @IsTest
    static void booleanInWhereClause() {
        ParserTestUtil.assertStaticResource('WHERE_3');
    }

    @IsTest
    static void bindVarInWhere() {
        ParserTestUtil.assertStaticResource('WHERE_4');
    }

    @IsTest
    static void andLogicInWhere() {
        ParserTestUtil.assertStaticResource('WHERE_5');
    }

    @IsTest
    static void mixedOrWithAndLogicInWhere() {
        ParserTestUtil.assertStaticResource('WHERE_6');
    }

    @IsTest
    static void whereWithNot() {
        ParserTestUtil.assertStaticResource('WHERE_7');
    }

    @IsTest
    static void correctsTreeForOrPrecedence(){
        ParserTestUtil.assertStaticResource('WHERE_8');
    }

    @IsTest
    static void correctsSubTreeForOrPrecedence() {
        ParserTestUtil.assertStaticResource('WHERE_9');
    }

    @IsTest
    static void acceptsTodayInWhereClause() {
        Parser p = new Parser();
        Node head = p.parse('SELECT Id FROM Account WHERE CreatedDate < TODAY');
        Assert.areEqual(head.right.right.left.right.id, 'TODAY', 'Today literal not parsed correctly');
    }
}