@isTest
private class DateLiteralComparableFactoryTest {
    @isTest
    static void ensureCreateWorksWithAllSupportedTokens() {
        Set<String> supportedTokens = DateLiteralComparableFactory.getSupportedTokens();
        for (String supportedToken : supportedTokens) {
            if (supportedToken.contains('n_')) {
                supportedToken += ':5';
            }
            DateLiteral dl = new DateLiteral.Builder()
                .setFieldValue(supportedToken)
                .build();
            DateLiteralComparable comparable = DateLiteralComparableFactory.create(
                dl
            );
            Assert.isNotNull(
                comparable,
                'DateLiteralComparable should not be null'
            );
        }
    }
}
