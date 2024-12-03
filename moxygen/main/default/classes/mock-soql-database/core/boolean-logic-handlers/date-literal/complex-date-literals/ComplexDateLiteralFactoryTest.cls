@isTest
private class ComplexDateLiteralFactoryTest {

    // all the dynamic literals have this specific combination of characters in them
    static final String DYNAMIC_LITERAL_CHARACTERS = 'n_';

    @isTest
    static void ensureAllValidDateLiteralsProduceStrategies() {
        Set<String> tokens = ComplexDateLiteralFactory.getTokens();
        for(String token : tokens) {

            // LAST_N_DAYS, NEXT_N_DAYS, N_FISCAL_YEARS_AGO, etc.
            if(token.contains(DYNAMIC_LITERAL_CHARACTERS)) {
                token = token + ':5';
            }

            ComplexDateLiteralStrategy strategy = ComplexDateLiteralFactory.getStrategy(token);
            Assert.isNotNull(strategy, 'Strategy should not be null');
        }
    }
}