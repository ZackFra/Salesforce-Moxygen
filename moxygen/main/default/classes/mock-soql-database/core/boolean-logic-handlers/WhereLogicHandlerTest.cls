@IsTest
private class WhereLogicHandlerTest {
    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateEqualsToday() {
        Parser p = new Parser();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CloseDate = TODAY');
        Node operatorNode = selectNode.right.right.left;
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType()),
            CloseDate = GMT.today()
        );

        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result);
    }

    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateTimeEqualsToday() {
        Parser p = new Parser();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CreatedDate = TODAY');
        Node operatorNode = selectNode.right.right.left;
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType())
        );
        DateTime now = GMT.now();
        opp = (Opportunity) Common.putReadOnlyField(opp, 'CreatedDate', now);

        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' with ' + opp.CreatedDate + ' and ' + now);
    }

    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateTimeEqualsTodayAsDateGmt() {
        Parser p = new Parser();
        DateTime now = GMT.now();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CreatedDate = ' + Common.dateTimeToSoqlString(now));
        Node operatorNode = selectNode.right.right.left;
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType())
        );
        opp = (Opportunity) Common.putReadOnlyField(opp, 'CreatedDate', now);

        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' with ' + opp.CreatedDate + ' and ' + now);
    }

    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateTimeEqualsYesterday() {
        Parser p = new Parser();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CreatedDate = YESTERDAY');
        Node operatorNode = selectNode.right.right.left;
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType())
        );
        DateTime yesterday = GMT.now().addDays(-1);
        opp = (Opportunity) Common.putReadOnlyField(opp, 'CreatedDate', yesterday);

        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' with ' + opp.CreatedDate + ' and ' + yesterday);
    }

    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateEqualsYesterday() {
        Parser p = new Parser();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CloseDate = YESTERDAY');
        Node operatorNode = selectNode.right.right.left;
        Date yesterday = GMT.today().addDays(-1);
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType()),
            CloseDate = yesterday
        );
        
        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isTrue(result, 'Expected true but got ' + result + ' with ' + opp.CreatedDate + ' and ' + yesterday);
    }

    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateEqualsYesterdayAndFieldIsNull() {
        Parser p = new Parser();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CloseDate = YESTERDAY');
        Node operatorNode = selectNode.right.right.left;
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType())
        );
        
        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isFalse(result, 'Expected false but got ' + result);
    }

    @IsTest
    static void ensureWhereLogicHandlerWorksWithDateTimeEqualsYesterdayAndFieldIsNull() {
        Parser p = new Parser();
        Node selectNode = p.parse('SELECT Id FROM Opportunity WHERE CreatedDate = YESTERDAY');
        Node operatorNode = selectNode.right.right.left;
        Opportunity opp = new Opportunity(
            Id = fflib_IDGenerator.generate(Opportunity.getSObjectType())
        );
        
        BooleanLogicOptions options = new BooleanLogicOptions()
            .setParams(null)
            .setHead(selectNode)
            .setObj(opp)
            .setSelectNode(selectNode);
        BooleanLogicHandler handler = new WhereLogicHandler(options);

        Test.startTest();
        Boolean result = handler.isCompareConditionMet(operatorNode);
        Test.stopTest();

        Assert.isFalse(result, 'Expected false but got ' + result);
    }
}