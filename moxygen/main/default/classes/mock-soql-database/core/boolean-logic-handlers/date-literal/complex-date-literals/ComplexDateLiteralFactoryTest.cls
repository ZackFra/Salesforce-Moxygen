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
}