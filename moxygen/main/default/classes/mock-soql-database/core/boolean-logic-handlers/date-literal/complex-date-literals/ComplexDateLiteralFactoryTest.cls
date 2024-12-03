@isTest
private class ComplexDateLiteralFactoryTest {

    @isTest
    static void ensureAllValidDateLiteralsProduceStrategies() {
        Set<String> tokens = ComplexDateLiteralFactory.getTokens();
        for(String token : tokens) {
            ComplexDateLiteralStrategy strategy = ComplexDateLiteralFactory.getStrategy(token);
            Assert.isNotNull(strategy, 'Strategy should not be null');
        }
    }

    @IsTest
    static void ensureLastNDaysWorksWithDate() {
        Test.startTest();
        ComplexDateLiteralStrategy strategy = ComplexDateLiteralFactory.getStrategy('last_n_days:5');
        Test.stopTest();
        Assert.areEqual(
            LastNDaysStrategy.class.getName(), 
            Typeof.forObject(strategy), 
            'LastNDaysStrategy should be returned'
        );
    } 
}