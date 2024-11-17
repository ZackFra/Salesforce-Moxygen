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
    static void canParseTodayLiteralInDate() {
        Parser p = new Parser();
        Node head = p.parse('SELECT Id FROM Account WHERE CreatedDate = TODAY');
        Node todayNode = head.right.right.left.right;
        Assert.areEqual(todayNode.nodeType, NodeType.DATE_LITERAL, 'Should be a date literal');
        Assert.areEqual(todayNode.id, Token.TODAY_LITERAL, 'Should be a today literal');
        Assert.isNull(todayNode.left, 'Should not have a left node');
        Assert.isNull(todayNode.right, 'Should not have a right node');
        
    }
}